# README

# Table of contents
- [Introduction](#introduction)
- [Creating your Lab](#prep)
- [Additional playbooks](#additional)


## Introduction
<div id="introduction" />
The playbooks are meant to create minimal clustered environments based on LXC for learning purposes.

Clustered technologies to be looked into initially include:
- Rabbit MQ
- Galera

Only the rabbit MQ, portion is implemented at this time.

## Creating your Lab
<div id="prep">

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

4. Choose which clusters you would like to have setup

```
/opt/klustr/playbooks# cat lab_overrides.yml 

install_rabbit_mq: true

install_galera: true
``` 

5. Run playbooks

```
/opt/klustr/playbooks# ansible-playbook main.yml 
```

6. Once the playbooks are done, ensure the desired clusters are up and running

```
/opt/klustr/playbooks# ansible galera -m shell -a "mysql -e \"show status like 'wsrep_cluster_%'\""
node1_galera_container | SUCCESS | rc=0 >>        
Variable_name   Value                               
wsrep_cluster_conf_id   2
wsrep_cluster_size      3
wsrep_cluster_state_uuid        85563195-9a43-11e8-9a09-7b7fb8465a9c
wsrep_cluster_status    Primary   

node2_galera_container | SUCCESS | rc=0 >>
Variable_name   Value
wsrep_cluster_conf_id   2
wsrep_cluster_size      3
wsrep_cluster_state_uuid        85563195-9a43-11e8-9a09-7b7fb8465a9c
wsrep_cluster_status    Primary

node3_galera_container | SUCCESS | rc=0 >>
Variable_name   Value
wsrep_cluster_conf_id   2
wsrep_cluster_size      3
wsrep_cluster_state_uuid        85563195-9a43-11e8-9a09-7b7fb8465a9c
wsrep_cluster_status    Primary

/opt/klustr/playbooks# ansible rabbit -m shell -a 'rabbitmqctl cluster_status'
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

## Additional Playbooks
<div id="additional" />

The `rabbitmq-breakfix.yml` playbook  has two tags  - dummy-data and breakfix-1. The former will inject dummy data into message queues while the latter will break the cluster for you to fix.

```
/opt/klustr/playbooks# ansible-playbook rabbitmq-breakfix.yml --list-tags

playbook: rabbitmq-breakfix.yml

  play #1 (rabbit): Rabbit MQ breakfix  TAGS: []
      TASK TAGS: [breakfix-1, dummy-data]
/opt/klustr/playbooks#
```
