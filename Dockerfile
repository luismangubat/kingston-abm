# Image contains all the basic tools needed to run experiments

FROM ubuntu:20.04


# Install Python 3

RUN apt update 
RUN apt install python3 \
                python3-pip -y  # We will use pip3 to install Ansible


# Install Ansible

# Ansible will run our startup commands
# https://github.com/ansible/ansible/issues/68645

RUN pip3 install ansible


# Install Miniconda

# https://conda.io/projects/conda/en/latest/user-guide/install/rpm-debian.html

RUN apt install curl -y
RUN curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
RUN install -o root -g root -m 644 conda.gpg /usr/share/keyrings/conda-archive-keyring.gpg
RUN gpg --keyring /usr/share/keyrings/conda-archive-keyring.gpg --no-default-keyring --fingerprint 34161F5BF5EB1D4BFBBB8F0A8AEB4F8B29D82806
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" > /etc/apt/sources.list.d/conda.list
RUN apt update
RUN apt install conda -y
ENV PATH="/opt/conda/bin:${PATH}"
RUN /opt/conda/bin/conda init bash


# Install GNU Parallel

RUN apt install parallel -y 


# Install Git

RUN apt install git -y


RUN mkdir /src

CMD ansible-playbook -v --extra-vars "host=localhost" /src/ansible/playbooks/covid19sim.yml && sleep infinity
#CMD sleep infinity
