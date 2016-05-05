
The code in this repo is intended to demonstrate a Round Robin load balancer configuration using nginx and a go lang web application.

Running the vagrant cluster will result in launching a single web node running nginx, and will also launch two back-end servers running a very simple go-lang app using the net/http package.

The number and ip of nodes in each tier is configured in the `Vagrantfile` in the root of the repo. Installation of the packages for nginx and go lang, and some basic configuration is performed by recipes in the `app_cluster` cookbook, located in the cookbooks directory.

## Prerequisite packages
This demo was developed on fedora release 21 using the following package versions;
* VirtualBox 4.3.30
* vagrant 1.7.2

The equivalent to these two packages on your distribution will need to be installed before proceding. This demo also assumes that git and bash are available, and the user is on some mainstream Linux OS.

The documentation for installing vagrant is here;
https://docs.vagrantup.com/v2/installation/

The documentation for installing VirtualBox is here;
https://www.virtualbox.org/manual/ch01.html#intro-installing

## Download the vagrant image

The Vagrant configuration requires the ubuntu/trusty64 vagrant box, and this can be installed using the following command

```
$ vagrant box add ubuntu/trusty64
```

## Obtain a local copy of this repository
You can checkout this repository using the following command;

```
$ git clone https://github.com/RajuMadishetti/tech_test.git
```

## Start the vagrant cluster

```
$ cd tech_test
$ vagrant up
```


Wait until the vagrant file has reported that the instances have come up;
```
==> web: [2016-05-05T13:27:39+00:00] INFO: Report handlers complete
```

## Access the load balanced application
Then the load balancer instance can be accesed via a port forwarded to the localhost here;

```
http://localhost:18080/
```
You can then use wget to test that the load balancer is in round robin configuration;

```
$ for i in {1..10}; do wget -qO- http://localhost:18080; echo; done
Hi there, I'm served from app2!
Hi there, I'm served from app1!
Hi there, I'm served from app2!
Hi there, I'm served from app1!
Hi there, I'm served from app2!
Hi there, I'm served from app1!
Hi there, I'm served from app2!
Hi there, I'm served from app1!
Hi there, I'm served from app2!
Hi there, I'm served from app1!
```

## Shutdown the cluster
Use the following command to shutdown the 3 nodes and remove any local storage they might have been using.
```
# vagrant destroy
```

