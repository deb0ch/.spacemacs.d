import os
import os.path
import logging
import json
import ycm_core

BASE_FLAGS = [
    "-Wall",
    "-Wextra"
]

def FlagsForFile(filename):
    logging.info("%s: Getting flags for %s" % (__file__, filename))
    root = os.path.realpath(filename);
    compilation_db_flags = FlagsFromCompilationDatabase(root, filename)
    if compilation_db_flags:
        final_flags = compilation_db_flags
    else:
        final_flags = BASE_FLAGS
        extra_flags = FlagsFromClangComplete(root, filename)
        if extra_flags:
            final_flags += extra_flags
    # remove -m flags: not relevant for parsing and cause libclang errors when cross-compiling
    final_flags = [ flag for flag in final_flags if not flag.startswith("-m") ]
    logging.info("%s: Flags = [\n\t\t%s\n]"
                 % (os.path.basename(filename), "\n\t\t".join(final_flags)))
    return {
        'flags': final_flags,
        'do_cache': True
    }

def FlagsFromClangComplete(root, filename):
    try:
        clang_complete_path = FindNearest(root, '.clang_complete', filename)
        clang_complete_flags = open(clang_complete_path, 'r').read().splitlines()
        logging.info("%s: Using %s" % (os.path.basename(filename), clang_complete_path))
        return clang_complete_flags
    except:
        return None

def FlagsFromCompilationDatabase(root, filename):
    try:
        compilation_db_path = FindNearest(root, 'compile_commands.json', filename)
        compilation_info = GetFileFlagsFromDb(compilation_db_path, filename)
        if not compilation_info:
            logging.info("%s: No compilation info for %s in compilation database"
                         % (os.path.basename(filename), filename))
            return None
        return MakeRelativePathsInFlagsAbsolute(compilation_info.compiler_flags_,
                                                compilation_info.compiler_working_dir_)
    except Exception, e:
        logging.info("%s: Could not get compilation flags from db: %s"
                     % (os.path.basename(filename), e))
        return None

# In case of a header file, we assume that if its path is in a source file's
# flags then its flags are most likely relevant
# Todo: this might not work if the paths in compile_commands.json are relative.
# Todo: in case of a header file, parse source files to find one including our
#       header and get compilation flags from it.
def GetFileFlagsFromDb(database_path, filename):
    database = ycm_core.CompilationDatabase(os.path.dirname(database_path))
    if not database:
        logging.info("%s: Compilation database file found but unable to load"
                     % os.path.basename(filename))
        return None
    extension = os.path.splitext(filename)[1]
    if extension in ['.h', '.hxx', '.hpp', '.hh']:
        with open(database_path, 'r') as f:
            jsonDatabase = json.load(f)
        for entry in jsonDatabase:
            if entry['command'].find(os.path.dirname(filename)) != -1:
                return database.GetCompilationInfoForFile(entry['file'])
        return None
    else:
        return database.GetCompilationInfoForFile(filename)

def FindNearest(path, target, filename):
    candidate = os.path.join(path, target)
    if(os.path.isfile(candidate) or os.path.isdir(candidate)):
        logging.info("%s: Found nearest %s at %s"
                     % (os.path.basename(filename), target, candidate))
        return candidate;
    else:
        parent = os.path.dirname(os.path.abspath(path));
        if(parent == path):
            raise RuntimeError("could not find %s"
                               % target);
        return FindNearest(parent, target, filename)

def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    for flag in flags:
        new_flag = flag
        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)
        for path_flag in [ '-isystem', '-I', '-iquote', '--sysroot=' ]:
            if flag == path_flag:
                make_next_absolute = True
                break
            if flag.startswith(path_flag):
                path = flag[ len(path_flag): ]
                new_flag = path_flag + os.path.join(working_directory, path)
                break
        if new_flag:
            new_flags.append(new_flag)
    return new_flags
