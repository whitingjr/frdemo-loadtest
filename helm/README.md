# Helm Chart for the first-responder-demo application

The Helm chart for deploy the backend of [frdemo](https://github.com/wildfly-extras/first-responder-demo) application on OpenShift.

## Overview

This helm chart mainly uses the helm dependencies to install the PostgreSql Database and Kafka Server which 
this demo application needs. This is executed/tested against openshif dev sandbox, but it possibley has other
issues when deploy to K8s cluster or other Openshift cluster.

To install this backend applicaiton, git clone this repo and simply run this command under this directory after login openshift:
```
helm dependency update frdemo 
helm install frdemo-backedn frdemo
```

## Image in this helm chart

The default image is based on quay.io/wildfly/wildfly:26.1.1.Final-2 and copied into
frdemo-backend.war and postgresql-42.5.0.jar:
```
FROM quay.io/wildfly/wildfly:26.1.1.Final-2
WORKDIR /opt/jboss
RUN chmod -R 755 /opt/jboss
RUN mkdir /opt/jboss/app
COPY frdemo-backend.war  /opt/jboss/app
COPY postgresql-42.5.0.jar /opt/jboss/app
COPY configure-wildfly.cli  /opt/jboss/app
USER jboss
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/opt/jboss/app/configure-wildfly.cli
RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin# --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

```

## The postgresql and kafka configuration
The PostgreSql Database name , username, password can be configured with helm `-set` or 
a value.yaml like :
```
postgresql:
  enabled: false
  auth:
    username: frdemo
    password: frdemo
    database: frdemo
  service:
    type: ClusterIP
    name: frdemo-backend-postgresql
```




