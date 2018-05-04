# README

The playbooks are meant to create minimal clustered environments based on LXC for learning purposes.

Clustered technologies to be looked into initially include:
- RabbitMQ
- Galera
- HA Proxy

To test the Rabbit Clustering functionality,

1. Create inventory file in playboks inventory, e.g.

```
[lab]
192.168.1.1
```

2) Run playbooks

```
 # ansible-playbook main.yml 
```
