---
layout: default
title: topics
parent: Services
nav_order: 2
---

# topics

{: .no_toc }

#### Summary

The topics service creates SEA Tool data topics in CMS Bigmac. These topics are later used by the connector service, and are what hold the SEA Tool business data.

#### Notes

- The topics service is deployed for all branches/stages, without exception.
- the service builds a lambda function, which has access to a CMS Bigmac environment. **The seatool-connectors master branch, as well as all seatool-connectors dev branches, connect to the shared Bigmac master cluster. The seatool-connectors val branch connects to the Bigmac val cluster. The seatool-connectors production branch connects to the production cluster**
- This lambda is invoked just after the service's deployment. It connects to Bigmac and creates the data topics as defined in [createTopics.js](link src/services/topics/handlers/createTopics.js).
- To support 'n' number of dev branches connecting to the shared Bigmac master cluster, all seatool dev branches create their topics with a prefix: `--seatool--branchname--`. So the topics service for the 'foo' branch in the seatool repository will create all of its topics with `--seatool-foo--` as a topic prefix. The seatool 'master', 'val', and 'production' branches do not have such a prefix.
