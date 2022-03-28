
# App-Containerization

The following is a demonstration of containerizing an application, Apache Guacamole, in this case. Vagrant will be used initially to spawn a temporary server for testing and capturing the steps for application configuration. Once application is well tested, the same steps can be tested again in a temporary Docker container.

---

## Apache Guacamole

Apache Guacamole is an example of shell-in-a-box, where remote terminal can be controlled in a web browser. Apache Guacamole contains many extensions which supports various features to strengthen the connectivity and can connect SSH, RDP, VNC and many remote protocols.


## Vagrant

Vagrant is an application used for building and maintaining virtual software development environment. In a nutshell, vagrant can be integrated with VMware, Virtualbox and many other providers, and the process of deploying virtual machines are simplified.


## Docker

Docker is a well known software to run containers. Containers are stripped-down version of virtual machines, running only specific process/workload required.

---

## Process

To begin with containerizing any application, its internals and working should be tested. It is a best practice to test the application in stages, beginning with manual to automated deployment and deploying to virtual machine to container.

- Manual application deployment and testing in virtual machine deployed through vagrant
- Automated application deployment in virtual machine stack deployed through vagrant
- Manual application deployment and testing in container deployed through docker
- Automated application deployment in container deployed through docker

---

## Prerequisites

- Install `Virtualbox` from the [link](https://www.virtualbox.org/wiki/Downloads)
- Create a `virtual network`, which will have subnet as `192.168.56.0/24`
- Install `Vagrant` from the [link](https://www.vagrantup.com/docs/installation)
- Install `Vagrant plugin for Virtualbox` from the [link](https://github.com/dotless-de/vagrant-vbguest)
- Install `Docker` from the [link](https://docs.docker.com/engine/install/)
  - If the testing and application is simple, whole simulation can be done in local desktop/laptop and `Docker Desktop` can be used.
- Steps to install `Apache Guacamole` from the [link](https://www.linode.com/docs/guides/installing-apache-guacamole-on-ubuntu-and-debian/)

---

## Manual application deployment and testing in virtual machine deployed through vagrant

Deploy a simple virtual machine using `Vagrant`. Navigate to the location `vagrant/init` and deploy the virtual machine.
```bash
vagrant up
```

Once the VM is deployed, connectivity can be established via `Vagrant`.
```bash
vagrant ssh
```

From here, all necessary steps for deploying `Apache Guacamole` can be tested out. The final working steps are to be documented and/or to be prepared in a `shell script` format.


## Automated application deployment in virtual machine stack deployed through vagrant

Once the testing is complete, a complete automated deployment in virtual machine stack can be done.


Navigate to the location `vagrant` to deploy the next version of `Vagrantfile`, which creates a dedicated VM for guacamole and an SSH client VM for connection. It hardly takes `10 mins` for the VM environment to be built.
```bash
vagrant up
vagrant ssh
```

The `Vagrantfile` has hardcoded IP for both the machines. The `Guacamole` server can be reached at `http://192.168.56.101:8080`. The default credential for this simulation is `guacamole/guacamole`. This can be changed in the file `user-mapping.xml`. The password in the file is in md5 format and the hash of any password can be generated using
```bash
echo -n <password> | openssl md5
```


## Manual application deployment and testing in container deployed through docker

The next stage is to test the application in a containerized environment. The steps recorded earlier works for VM environment, but the same cannot be expected to work in a containerized environment out-of-the-box. There are separate docker images built by `Apache` for running `Guacamole`, but the following steps highlights how to build a custom container image if there is no vendor provided image.


A temporary `Ubuntu` container can be spawned using
```bash
docker run --rm -it ubuntu:focal /bin/bash
```

From here, all necessary steps for deploying `Apache Guacamole` can be tested out. The final working steps are to be documented for building a custom image.


## Automated application deployment in container deployed through docker

Once the recorded steps for application in containerized environment is avaiable, a custom docker image can be built, which when started will have `Apache Guacamole` running out-of-the-box.


Navigate to the location `docker`, which contains `Dockerfile`. The file is a set of instructions for docker to build our application. It hardly takes `15 mins` for the docker image to be built.
```bash
docker build -t guacamole-server .
```

Once the image is built successfully, it can be run using
```bash
docker run --rm -p 10880:8080 --mount type=bind,source=${PWD}/scripts/init.sh,target=/mnt/init.sh guacamole-server /bin/bash -c "/mnt/init.sh"
```

This is a simple simulation of containerizing any application. The implementation can be extended further and orchestrated using `docker swarm` or `kubernetes`.
