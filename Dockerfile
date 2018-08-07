#Builds Ubuntu Jekyll image

FROM ubuntu:16.04

MAINTAINER mrlesmithjr@gmail.com

#Install Ansible
RUN apt-get update && \
    apt-get install --no-install-recommends -y software-properties-common && \
    apt-add-repository ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible sudo

#Install packages
RUN apt-get update && \
    apt-get install -y git

#Create Ansible Folder
RUN mkdir -p /opt/ansible-playbooks/roles

#Clone GitHub Repo
RUN git clone https://github.com/emanuelhouse/ansible-jekyll.git /opt/ansible-playbooks/roles/ansible-jekyll && \
    git clone https://github.com/mrlesmithjr/ansible-nginx.git /opt/ansible-playbooks/roles/ansible-nginx

#Copy Ansible playbooks
COPY playbook.yml /opt/ansible-playbooks/

#Run Ansible playbook
RUN ansible-playbook -i "localhost," -c local /opt/ansible-playbooks/playbook.yml

# Cleanup
RUN apt-get clean -y && \
    apt-get autoremove -y

# Cleanup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Expose ports
EXPOSE 80 4000

CMD ["nginx", "-g", "daemon off;"]
