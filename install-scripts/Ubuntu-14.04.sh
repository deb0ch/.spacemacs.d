
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://deb0ch@github.com/deb0ch/spacemacs -b perso ~/.emacs.d
git clone https://github.com/mirrors/emacs.git ~/emacs
sudo apt-get build-dep emacs
sudo apt install build-essential automake texinfo libjpeg-dev libncurses5-dev libtiff5-dev libgif-dev libpng-dev libxpm-dev libgtk-3-dev libgnutls28-dev
cd ~/emacs ; git checkout emacs-26.1.92
cd ~/emacs ; ./autogen.sh
cd ~/emacs ; ./configure
cd ~/emacs ; make -j8
cd ~/emacs ; sudo make install
