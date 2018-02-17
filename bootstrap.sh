# Install development tools & other packages we need when compiling Python
sudo apt-get update
sudo apt-get -y install build-essential git zlib1g-dev libssl-dev openssl libffi-dev libsqlite3-dev

# Install Heroku CLI
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Install RabbitMQ
apt-get -y install rabbitmq-server
service rabbitmq-server start

# Download & install Python 2.7.14 as "python2.7"
wget http://python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz --progress=bar:force
tar xf Python-2.7.14.tar.xz
cd Python-2.7.14
./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
sudo make altinstall

# Install pip2.7 for Python 2.7.14
python2.7 -m ensurepip 

# Install pipenv
pip2.7 install pipenv