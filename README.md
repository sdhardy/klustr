# README

# Table of contents
- [Introduction](#introduction)
- [Rabbit MQ lab](#rabbitmq)

## Introduction
<div id="introduction" />
The playbooks are meant to create minimal clustered environments based on LXC for learning purposes.

Clustered technologies to be looked into initially include:
- Rabbit MQ
- Galera

Only the rabbit MQ, portion is implemented at this time.

## Rabbit MQ lab
<div id="rabbitmq" />

To build a three-node vanilla Rabbit MQ cluster for learning purposes, follow the steps below:

1. Generate SSH key for the deployment host and add the key to known_hosts and authorized_keys

```
~# ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
~# cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
~# ssh-keyscan -H 192.168.1.112 >> ~/ssh/known_hosts
```

2. Clone the klustr repository to your deployment
```
~# git clone https://github.com/OchiengEd/klustr /opt/klustr
```

3.  Create inventory file inside inventory directory, e.g.

```
~# cd /opt/klustr/playbooks
/opt/klustr/playbooks# vim inventory/hosts
[lab]
192.168.1.112
```

4. Run playbooks

```
/opt/klustr/playbooks# ansible-playbook main.yml 
```
5. Once the playbooks have run successfully, verify the cluster is up and running
```
/opt/klustr/playbooks# ansible rabbit -m shell -a 'rabbitmqctl cluster_status' -f 3
node2_rabbit_mq_container | SUCCESS | rc=0 >>
Cluster status of node rabbit@node2_rabbit_mq_container ...
[{nodes,[{disc,[rabbit@node1_rabbit_mq_container,
                rabbit@node2_rabbit_mq_container,
                rabbit@node3_rabbit_mq_container]}]},
 {running_nodes,[rabbit@node3_rabbit_mq_container,
                 rabbit@node1_rabbit_mq_container,
                 rabbit@node2_rabbit_mq_container]},
 {partitions,[]}]
...done.

node1_rabbit_mq_container | SUCCESS | rc=0 >>
Cluster status of node rabbit@node1_rabbit_mq_container ...
[{nodes,[{disc,[rabbit@node1_rabbit_mq_container,
                rabbit@node2_rabbit_mq_container,
                rabbit@node3_rabbit_mq_container]}]},
 {running_nodes,[rabbit@node3_rabbit_mq_container,
                 rabbit@node2_rabbit_mq_container,
                 rabbit@node1_rabbit_mq_container]},
 {partitions,[]}]
...done.

node3_rabbit_mq_container | SUCCESS | rc=0 >>
Cluster status of node rabbit@node3_rabbit_mq_container ...
[{nodes,[{disc,[rabbit@node1_rabbit_mq_container,
                rabbit@node2_rabbit_mq_container,
                rabbit@node3_rabbit_mq_container]}]},
 {running_nodes,[rabbit@node1_rabbit_mq_container,
                 rabbit@node2_rabbit_mq_container,
                 rabbit@node3_rabbit_mq_container]},
 {partitions,[]}]
...done.

/opt/klustr/playbooks# 
```
