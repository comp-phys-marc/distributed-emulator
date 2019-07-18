# General Development

A container for all the services' repositories which are registered as submodules. This repo provides a simple way to pull and update all the others by simply pulling this repo and updating submodules.

## Developer Setup

### Install Git

```
apt-get install git
```

## Repository

### Cloning

```
git clone https://gitlab.com/QuantumEmulator/distributedemulator.git --recurse-submodules
```

### Submodules

### Updating submodules

```
git submodule update --init --recursive
```

## Local development

### Install PSQL Client

Mac

```
brew install postgresql
pg_ctl -D /usr/local/var/postgres start && brew services start postgresql
```

Ubuntu

```
sudo apt-get update
sudo apt-get install postgresql-client
```

### Setup the virtualenv

```
pip install virtualenv
pip install virtualenvwrapper
cd venv
virtualenv . --python=python3
```

### Activate the virtualenv

```
source venv/bin/activate
```

### Install and start RabbitMQ

```
sudo apt-get update
sudo apt-get upgrade
cd ~
sudo apt-get install erlang
echo "deb https://dl.bintray.com/rabbitmq/debian xenial main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install rabbitmq-server

sudo systemctl start rabbitmq-server.service
sudo systemctl enable rabbitmq-server.service

sudo rabbitmq-plugins enable rabbitmq_management
sudo chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/

sudo rabbitmqctl add_user SA tercesdeqmis
sudo rabbitmqctl set_user_tags SA administrator
sudo rabbitmqctl set_permissions -p / SA ".*" ".*" ".*"
```
