#!/bin/bash

fanout_queue() {
 rabbitmqadmin declare exchange name='announcement.exchange' type='fanout'
 rabbitmqadmin declare queue name='news.bbc' durable=true
 rabbitmqadmin declare queue name='news.npr' durable=true
 rabbitmqadmin declare binding source='announcement.exchange' destination_type='queue' destination='news.bbc' routing_key='news'
 rabbitmqadmin declare binding source='announcement.exchange' destination_type='queue' destination='news.npr' routing_key='news'
}

direct_queue() {
 rabbitmqadmin declare exchange name='reporter.freelance' type='direct'
 rabbitmqadmin declare queue name='freelance.npr' durable=true
 rabbitmqadmin declare queue name='freelance.bbc' durable=true
 rabbitmqadmin declare binding source='reporter.freelance' destination_type='queue' destination='freelance.npr' routing_key='npr'
 rabbitmqadmin declare binding source='reporter.freelance' destination_type='queue' destination='freelance.bbc' routing_key='bbc'
}


dummy_data() {
 rabbitmqadmin publish exchange='announcement.exchange' routing_key='news' payload='Hello world'
 rabbitmqadmin publish exchange='announcement.exchange' routing_key='news' payload='Lorem Ipsum'
 rabbitmqadmin publish exchange='announcement.exchange' routing_key='news' payload='foobar'
 rabbitmqadmin publish exchange='reporter.freelance' routing_key='bbc' payload='BBC around the world'
}

fanout_queue
direct_queue
dummy_data
