
sudo apt-get -y install curl git htop silversearcher-ag tree vim zsh
[ -e ~/.spacemacs.d ] || git clone https://deb0ch@github.com/deb0ch/.spacemacs.d -b master ~/.spacemacs.d

# Compile Emacs
git clone https://deb0ch@github.com/deb0ch/spacemacs -b perso ~/.emacs.d
git clone https://github.com/mirrors/emacs.git ~/emacs
sudo apt-get -y build-dep emacs
sudo apt-get -y install build-essential automake texinfo libjpeg-dev libncurses5-dev libtiff5-dev libgif-dev libpng-dev libxpm-dev libgtk-3-dev libgnutls28-dev
cd ~/emacs ; git checkout emacs-26.1.92
cd ~/emacs ; ./autogen.sh
cd ~/emacs ; ./configure
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
