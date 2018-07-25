# README

The playbooks are meant to create minimal clustered environments based on LXC for learning purposes.

Clustered technologies to be looked into initially include:
- RabbitMQ
- Galera
- HA Proxy

Only the rabbit MQ, portion is implemented at this time.

To test the Rabbit Clustering functionality,

1. Generate SSH key for the deployment host and add the key to known_hosts and authorized_keys

```
# ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
# cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# ssh-keyscan -H 192.168.1.112 >> ~/ssh/known_hosts
```

2. Create inventory file inside inventory directory, e.g.

```
# vim inventory/hosts
[lab]
192.168.1.112
```

3. Run playbooks

```
 # ansible-playbook main.yml 
```
