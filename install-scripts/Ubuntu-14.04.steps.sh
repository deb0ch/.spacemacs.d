
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install curl git htop silversearcher-ag tree vim zsh
[ -e ~/.spacemacs.d ] || git clone https://deb0ch@github.com/deb0ch/.spacemacs.d -b master ~/.spacemacs.d
[ -e ~/.emacs.d ] || git clone https://deb0ch@github.com/deb0ch/spacemacs -b perso ~/.emacs.d

# Compile Emacs
git clone https://github.com/mirrors/emacs.git ~/emacs
sudo apt-get -y build-dep emacs
sudo apt-get -y install build-essential automake texinfo libjpeg-dev libncurses5-dev libtiff5-dev libgif-dev libpng-dev libxpm-dev libgtk-3-dev libgnutls28-dev
cd ~/emacs ; git checkout emacs-26.1.92
cd ~/emacs ; ./autogen.sh
cd ~/emacs ; ./configure --with-modules
cd ~/emacs ; make -j8
cd ~/emacs ; sudo make install

# Install font Source Code Pro
cd /tmp && wget --no-verbose -O source-code-pro.zip https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip
cd /tmp && unzip source-code-pro.zip -d source-code-pro
mkdir -p ~/.fonts
cp -v /tmp/source-code-pro/*/OTF/*.otf ~/.fonts/
fc-cache -fv
rm -rf /tmp/source-code-pro{,.zip}

# Install up-to-date git for Magit
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get -y install git

# Install up-to-date cmake for vterm
sudo add-apt-repository -s -y ppa:george-edison55/cmake-3.x
sudo apt-get update
sudo apt-get -y remove cmake --purge
sudo apt-get -y install cmake

# Install emacs-libvterm <3
sudo apt-get -y install libtool
cd /tmp && git clone https://github.com/neovim/libvterm
cd /tmp/libvterm && make -j4 && sudo make install
rm -rf /tmp/libvterm
cd ~/.emacs.d/private/local || mkdir -p ~/.emacs.d/private/local
cd ~/.emacs.d/private/local && git clone https://github.com/akermu/emacs-libvterm
mkdir -p ~/.emacs.d/private/local/emacs-libvterm/build
cd ~/.emacs.d/private/local/emacs-libvterm/build && cmake ..
cd ~/.emacs.d/private/local/emacs-libvterm/build && make -j 4
