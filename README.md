# Parent Repository (Python)

A container for all the services' repositories which are registered as submodules. This repo provides a simple way to pull and update all the others by simply pulling this repo and updating submodules.

# Setup

Setup ODBC for Python:

```
wget https://gallery.technet.microsoft.com/ODBC-Driver-13-for-Ubuntu-b87369f0/file/154097/2/installodbc.sh
sh installodbc.sh
```

Setup the virtualenv:

```
pip install virtualenv
pip install virtualenvwrapper
cd venv
virtualenv .
```

Activate the virtualenv:

```
source venv/bin/activate
```

Install and start RabbitMQ:

```
brew install rabbitmq
export PATH=$PATH:/usr/local/sbin
rabbitmq-server
```

## Repository

Cloning:

```
git clone https://gitlab.com/QuantumEulator/distributedemulator.git --recurse-submodules
```

### Submodules

Updating submodules:

```
git submodule update --init --recursive
```
