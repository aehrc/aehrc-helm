Ontoserver Helm Chart - Scalable, Read-write
==========================================

This chart deploys a scalable cluster of Ontoserver instances that supports both 
read and write. You must provide a PostgreSQL database for the cluster to use.

Here is a list of the supported values:

| Value                                             | Description                                                                                                                                                                                                                              |
|---------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `ontoserver.hostName`                             | The hostname that will be used to access the Ontoserver instance. This will be used in the Ingress resource, and also for configuring the URLs that Ontoserver returns in responses.                                                     |
| `ontoserver.image`                                | The Docker image that will be pulled down and deployed. Note that if the image is in a protected repository, you will need to point to the credentials using the `imagePullSecrets` value.                                               |
| `ontoserver.imagePullPolicy`                      | See [Kubernetes documentation  - Image pull policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy).                                                                                                           |
| `ontoserver.imagePullSecrets`                     | See [Kubernetes documentation - Specifying imagePullSecrets on a pod](https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod).                                                                      |
| `ontoserver.timeZone`                             | The timezone that will be configured for the container.                                                                                                                                                                                  |
| `ontoserver.language`                             | The language that will be configured for the container.                                                                                                                                                                                  |
| `ontoserver.deployment.replicas`                             | The number of Ontoserver instances that will be deployed.                                                                                                                                                                                |
| `ontoserver.resources.ontoserver.requests`        | The resource requests that will be applied to the Ontoserver container. See [Kubernetes documentation - Resource management for pods and containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)     |
| `ontoserver.resources.ontoserver.limits`          | The resource limits that will be applied to the Ontoserver container. See [Kubernetes documentation - Resource management for pods and containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)       |
| `ontoserver.resources.ontoserver.initialHeapSize` | The initial heap size that will be configured for the Ontoserver JVM.                                                                                                                                                                    |
| `ontoserver.resources.ontoserver.maxHeapSize`     | The max heap size that will be configured for the Ontoserver JVM.                                                                                                                                                                        |
| `ontoserver.healthCheckOption`                    | Option to pass to the healtch check script. Use `-s` to  wait for the preload to complete successfully before reporting that the container is ready. Or `-l`  and the preload will run in the background.                                |
| `ontoserver.deploymentStrategy`                   | The deployment strategy that will be used for the Ontoserver deployment. See [Kubernetes documentation - Deployment strategies](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy).                         |
| `ontoserver.ingressClass`                         | The ingress class that will be used for the Ingress resource. By default, the [NGINX ingress controller](https://docs.nginx.com/nginx-ingress-controller/) will be used.                                                                 |
| `ontoserver.ingressAnnotations`                   | The annotations that will be applied to the Ingress resource. See [Kubernetes documentation - Ingress annotations](https://kubernetes.io/docs/concepts/services-networking/ingress/#annotations).                                        |
| `ontoserver.ingressTlsEnabled`                    | If set to `true`, the Ingress resource will be configured to use TLS.                                                                                                                                                                    |
| `ontoserver.tolerations`                          | The tolerations that will be applied to the Ontoserver deployment. See [Kubernetes documentation - Taints and tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/).                               |
| `ontoserver.storageClass`                         | The storage class that will be used for the persistent volume claim.                                                                                                                                                                     |
| `ontoserver.customization`                        | The name of a ConfigMap containing custom logo and CSS files to be deployed with the application. See [Customization](#customization) for more information.                                                                              |
| `ontoserver.config`                               | Additional configuration values that will be passed to the Ontoserver instance. See [Ontoserver documentation - configuration properties](https://ontoserver.csiro.au/docs/6/config-all.html) for more information.                      |
| `ontoserver.secretConfig`                         | Additional configuration values that should be stored within a Secret resource.                                                                                                                                                          |

### Configuring a database

You can use the Spring Boot datasource configuration properties to configure the
connection details for the PostgreSQL database that you provide. The most
commonly used properties are:

- `spring.datasource.url`
- `spring.datasource.username`
- `spring.datasource.password`

See [Spring Boot documentation - Data source configuration](https://docs.spring.io/spring-boot/docs/current/reference/html/data.html#data.sql.datasource.configuration)
for more information.

### Customization

Ontoserver can be configured to serve up custom CSS and logo files under the 
`/fhir/.well-known` path. This is used to customize the appearance of client 
applications such as [Shrimp](https://ontoserver.csiro.au/shrimp).

There are the three files that can be customized:

- `logo.png` - A logo that is used to advertise the Ontoserver application 
  itself.
- `organisation_logo.png` - A logo that is used to advertise the organization 
  that is associated with the Ontoserver instance.
- `organisation.css` - A CSS file with styling overrides that can be used to 
 customize the appearance of the client application.

You need to create a ConfigMap that contains these files, and then pass the name 
of the ConfigMap to the `ontoserver.customization` value. An example of how to 
create the ConfigMap using `kubectl` is shown below:

```bash
kubectl create configmap ontoserver-customization \
  --from-file=logo.png \
  --from-file=organisation_logo.png \
  --from-file=organisation.css
```

See [Kubernetes documentation - Configure a pod to use a ConfigMap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/) 
for more information.

Copyright © 2023, Commonwealth Scientific and Industrial Research Organisation
(CSIRO) ABN 41 687 119 230. All rights reserved.
