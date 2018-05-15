# README

The playbooks are meant to create minimal clustered environments based on LXC for learning purposes.

Clustered technologies to be looked into initially include:
- RabbitMQ
- Galera
- HA Proxy

Only the rabbit MQ, portion is implemented at this time.

To test the Rabbit Clustering functionality,

1. Create inventory file inside inventory directory, e.g.

```
$ vim inventory/hosts
[lab]
192.168.1.1
```

2) Run playbooks

```
 # ansible-playbook main.yml 
```
