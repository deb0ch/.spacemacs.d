
sudo apt-get -y install git htop silversearcher-ag tree vim zsh
[ -e ~/.spacemacs.d ] || git clone https://deb0ch@github.com/deb0ch/.spacemacs.d -b master ~/.spacemacs.d
[ -e ~/.oh-my-zsh ] || sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://deb0ch@github.com/deb0ch/spacemacs -b perso ~/.emacs.d
git clone https://github.com/mirrors/emacs.git ~/emacs
sudo apt-get -y build-dep emacs
sudo apt-get -y install build-essential automake texinfo libjpeg-dev libncurses5-dev libtiff5-dev libgif-dev libpng-dev libxpm-dev libgtk-3-dev libgnutls28-dev
cd ~/emacs ; git checkout emacs-26.1.92
cd ~/emacs ; ./autogen.sh
cd ~/emacs ; ./configure
cd ~/emacs ; make -j8
cd ~/emacs ; sudo make install
