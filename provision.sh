#!/bin/bash
sudo apt-get update
sudo apt-get install -y git python-pip python-dev
sudo pip install jinja2
sudo pip install ansible
sudo mkdir -p /opt/ansible-playbooks/roles
sudo git clone https://github.com/mrlesmithjr/ansible-jekyll.git /opt/ansible-playbooks/roles/ansible-jekyll
sudo cp /vagrant/playbook.yml /opt/ansible-playbooks
ansible-playbook -i "localhost," -c local /opt/ansible-playbooks/playbook.yml