#!bin/sh

INSTALLATION_BASE=$HOME/installaton
ANACONDA_VERSION=5.2.0
PYTHON_VERSION=3.6.2
GO_VERSION=1.12.9
QT_MAJOR_VERSION=5.12
QT_MINOR_VERSION=${QT_MAJOR_VERSION}.6

sudo apt update
sudo apt upgrade

mkdir -p ${INSTALLATION_BASE};

# Git
sudo apt install git

### User config
git config --global user.email "r.shimizu18020@gmail.com"
git config --global user.name "ora1027"

### Create SSH key (To avoid having to confirm your password every time)

# Python
### Anaconda
mkdir -p ${INSTALLATION_BASE}/anaconda_installation/${ANACONDA_VERSION}
cd ${INSTALLATION_BASE}/anaconda_installation/${ANACONDA_VERSION};
curl -O https://repo.anaconda.com/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh; 
# chmod +x Anaconda3-5.2.0-Linux-x86_64.sh; ./Anaconda3-5.2.0-Linux-x86_64.sh;

### Python
mkdir -p ${INSTALLATION_BASE}/python_installation/${PYTHON_VERSION};
cd ${INSTALLATION_BASE}/python_installation/${PYTHON_VERSION};
curl -O https://www.python.org/ftp/python/3.6.2/Python-${PYTHON_VERSION}.tar.xz
xz -dc Python-3.6.2.tar.xz | tar xfv -;

##Create Anaconda virtual env
conda update --all

conda create -n python36 python=3.6 spyder pandas jupyter matplotlib numpy
conda create -n python37 python=3.7 spyder pandas jupyter matplotlib numpy

### OR
git clone https://github.com/ora1027/Python_env.git
### file name is temporary
conda env create --file ~/Python_env/myenv.yaml

# Go
mkdir -p ${INSTALLATION_BASE}/go/${GO_VERSION};
cd ${INSTALLATION_BASE}/go/${GO_VERSION};
curl -O https://storage.googleapis.com/golang/go${GO_VERSION=}.linux-amd64.tar.gz;
tar zxvf go${GO_VERSION}.linux-amd64.tar.gz;

# Qt [https://qiita.com/chlochan/items/53f1276522d03f460a81]
mkdir -p ${INSTALLATION_BASE}/Qt/${QT_MINOR_VERSION};
cd ${INSTALLATION_BASE}/Qt/${QT_MINOR_VERSION};
wget http://download.qt.io/official_releases/qt/${QT_MAJOR_VERSION}/${QT_MINOR_VERSION}/qt-opensource-linux-x64-${QT_MINOR_VERSION}.run
chmod +x qt-opensource-linux-x64-${QT_MINOR_VERSION}.run
./qt-opensource-linux-x64-${QT_MINOR_VERSION}.run

### insall g++
sudo apt install build-essential
### insall font library
sudo apt install libfontconfig1
### insall OpenGL library
sudo apt install mesa-common-dev
### insall additional package
sudo apt install libglu1-mesa-dev -y

QT_CREATOR_DESKTOP="
[Desktop Entry]\n
Version=1.0\n
Encoding=UTF-8\n
Type=Application\n
Name=QtCreator\n
Comment=QtCreator\n
NoDsiplay=true\n
Exec=$HOME/"${QT_MINOR_VERSION}"/Tools/QtCreator/bin/qtcreator %f\n
Icon=$HOME/Qt"${QT_MINOR_VERSION}"/"${QT_MINOR_VERSION}"/Src/qtdoc/doc/images/landing/icon_QtCreator_78x78px.png\n
Name[en_US]=Qt-Creator\n
"

echo -e ${QT_CREATOR_DESKTOP} > ~/.local/share/applications/Qt-Creator.desktop

sudo update-mime-database /usr/share/mime

# VSCode https://qiita.com/yoshiyasu1111/items/e21a77ed68b52cb5f7c8
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

