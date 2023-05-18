---
layout: default
title: Kafka Connect UI
parent: Developer Guide
nav_order: 10
---

## Kafka Connect UI
{: .no_toc }


## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}
---

## Why do I need this?
Kafka Connect UI is user interface that will allow the team to now manage and monitoring Apache Kafka Connect. It will allow you to configure and monitor Kafka Connect connectors, tasks, and workers through a graphical interface. With Kafka Connect UI, you can easily create, edit, and delete connectors, view metrics and logs for the connectors and their associated tasks and workers, and monitor the status and performance of their connectors and tasks. 

## Getting Started
To connect to the UI, get the aws token and authenticate the terminal.
Go to the connector repo in your local directory and run the following command, run connect --stage <stage name> --service connector. 
The command will spit out the UI connector command that will initiate port forwarding to you local host. 
Note: Copy the command to forward the connector's Kafka Connect Ui to your localhost:8000 
Run the command, and after a successful response go to a web browser and type localhost:8000