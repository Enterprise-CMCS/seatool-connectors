---
layout: default
title: Overview
nav_order: 2
---

# Overview

{: .no_toc }

The 10,000ft view
{: .fs-6 .fw-300 }

## Table of contents

{: .no_toc .text-delta }

1. TOC
   {:toc}

---

## Overview

The seatool-connectors project is a microservice that sends CMS SEA Tool data to CMS Bigmac. Alerting is leveraged through [AWS Cloudwatch](https://aws.amazon.com/cloudwatch/).

## Archtecture

![Architecture Diagram](../../../assets/architecture.svg)

## View Metrics

[Metrics](https://Enterprise-CMCS.github.io/seatool-connectors/dora/)

We programmatically publish a set of Development metrics that align to the DevOps Research and Assesment (DORA) standards.  Those metrics can be viewed [here]({{ site.url }}{{ site.repo.name }}/metrics/dora).

## AWS Resources

You can view and download a list of all aws resources this project uses for higher environments [here]({{ site.url }}{{ site.repo.name }}/metrics/aws).