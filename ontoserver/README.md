# Ontoserver Helm Chart - Single/Scaled deployments ReadOnly/ReadWrite with or without persistence

This chart deploys Ontoserver instances in Kubernetes in either single or scaled modes, supports both read-only and read-write operations, and can be configured with or without persistent storage (PVC or existing volumes). It can optionally include a Postgres sidecar and expose services via the Gateway API or standard Ingress with or without a bundled [F5 Nginx Ingress Controller](https://docs.nginx.com/nginx-ingress-controller/).

## Values

| Value                                                                          | Description                                                                                   |
| ------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| **ontoserver.image**                                                           | Container image for Ontoserver (e.g. `quay.io/aehrc/ontoserver:ctsa-6`).                      |
| **ontoserver.imagePullPolicy**                                                 | Kubernetes image pull policy (`Always`, `IfNotPresent`, etc.).                                |
| **ontoserver.imagePullSecrets**                                                | Array of Secrets for pulling a private image.                                                 |
| **ontoserver.deployment.kind**                                                 | Controller kind: `Deployment` or `StatefulSet`.                                               |
| **ontoserver.deployment.type**                                                 | Topology type: `single` (standalone) or `scaled` (requires shared database cluster).          |
| **ontoserver.deployment.isReadOnly**                                           | Read‑only mode flag; should remain `true` for scaled clusters as read/write is experimental.  |
| **ontoserver.deployment.replicas**                                             | Number of replicas (`1` for single, ≥ 2 for scaled, `0` to disable).                          |
| **ontoserver.deployment.deploymentStrategy**                                   | K8s update strategy when using Deployment kind (`RollingUpdate` or `Recreate`).               |
| **ontoserver.deployment.persistence.enabledForDeployment**                     | Enable a PVC on Deployment (read‑only storage).                                               |
| **ontoserver.deployment.persistence.existingVolume.enabled**                   | Bind to an existing PersistentVolume instead of provisioning.                                 |
| **ontoserver.deployment.persistence.existingVolume.name**                      | Name of the existing PersistentVolume to bind.                                                |
| **ontoserver.deployment.persistence.storageClass.name**                        | StorageClass to use if not using the built‑in provisioner.                                    |
| **ontoserver.deployment.persistence.storageClass.provided.enabled**            | Enable the built‑in CSI StorageClass with reclaimPolicy=Retain.                               |
| **ontoserver.deployment.persistence.storageClass.provided.storageProvisioner** | CSI driver name (e.g. `disk.csi.azure.com`).                                                  |
| **ontoserver.deployment.persistence.storageClass.provided.storageParameters**  | Parameters for the CSI driver (e.g. SKU, kind).                                               |
| **ontoserver.deployment.podDisruptionBudget.enabled**                          | Enable PodDisruptionBudget (only when `type: scaled`).                                        |
| **ontoserver.deployment.podDisruptionBudget.minAvailable**                     | Minimum pods that must remain available.                                                      |
| **ontoserver.deployment.podDisruptionBudget.maxUnavailable**                   | Maximum pods allowed unavailable (alternative to `minAvailable`).                             |
| **ontoserver.deployment.podDisruptionBudget.unhealthyPodEvictionPolicy**       | Policy for evicting unhealthy pods (`IfHealthyBudget` or `AlwaysAllow`).                      |
| **ontoserver.deployment.db.enabled**                                           | Enable the embedded Postgres sidecar.                                                         |
| **ontoserver.deployment.db.postgresVersion**                                   | Postgres image tag (e.g. `12`).                                                               |
| **ontoserver.serverName**                                                      | Hostname used by Ontoserver to generate URLs (must match one entry in `hostNames`).           |
| **ontoserver.hostNames**                                                       | Array of hostnames for Gateway/Ingress routing.                                               |
| **ontoserver.timeZone**                                                        | Container time zone (e.g. `UTC`).                                                             |
| **ontoserver.language**                                                        | Locale for the container (`en_US`, etc.).                                                     |
| **ontoserver.resources.ontoserver.requests**                                   | CPU, memory and storage requests for the Ontoserver container.                                |
| **ontoserver.resources.ontoserver.limits**                                     | CPU and memory limits for the Ontoserver container.                                           |
| **ontoserver.resources.ontoserver.initialHeapSize**                            | JVM initial heap size (e.g. `2800m`).                                                         |
| **ontoserver.resources.ontoserver.maxHeapSize**                                | JVM maximum heap size (e.g. `2800m`).                                                         |
| **ontoserver.resources.db.requests**                                           | CPU and memory requests for the Postgres sidecar.                                             |
| **ontoserver.resources.db.limits**                                             | CPU and memory limits for the Postgres sidecar.                                               |
| **ontoserver.healthCheckOption**                                               | Flags for the healthcheck script (`-p`, `-s`, `-f`).                                          |
| **ontoserver.certmanager.enabled**                                             | Enable cert-manager resources.                                                                |
| **ontoserver.certmanager.clusterIssuerName**                                   | ClusterIssuer name (or prefix) for Gateway/Ingress certificates.                              |
| **ontoserver.certmanager.email**                                               | Email for ACME registration.                                                                  |
| **ontoserver.gateway.enabled**                                                 | Enable Gateway API resources.                                                                 |
| **ontoserver.gateway.listenerPortSecure**                                      | Secure listener port for HTTPS routes.                                                        |
| **ontoserver.gateway.annotations**                                             | Annotations to apply to the Gateway resource.                                                 |
| **ontoserver.gateway.infrastructureAnnotations**                               | Annotations for the underlying infrastructure (service, LoadBalancer, etc.).                  |
| **ontoserver.gateway.className**                                               | GatewayClass name.                                                                            |
| **ontoserver.gateway.requestTimeout**                                          | Request timeout duration (e.g. `120s`).                                                       |
| **ontoserver.gateway.tlsEnabled**                                              | Enable TLS termination on the Gateway listeners.                                              |
| **ontoserver.ingress.enabled**                                                 | Enable standard Kubernetes Ingress instead of Gateway API.                                    |
| **ontoserver.ingress.annotations**                                             | Annotations to apply to the Ingress resource.                                                 |
| **ontoserver.ingress.className**                                               | IngressClass to use for the Ingress resource.                                                 |
| **ontoserver.ingress.tlsEnabled**                                              | Enable TLS on the Ingress resource.                                                           |
| **ontoserver.tolerations**                                                     | Pod tolerations for node scheduling.                                                          |
| **ontoserver.customization**                                                   | Name of a `ConfigMap` containing custom CSS/logo files (see [Customization](#customization)). |
| **ontoserver.config**                                                          | Arbitrary Ontoserver configuration entries (plain-text).                                      |
| **ontoserver.secretConfig**                                                    | Secret-backed Ontoserver configuration entries (in a generated `Secret`).                     |
| **nginx-ingress.enabled**                                                      | Enable the bundled nginx-ingress controller.                                                  |
| **nginx-ingress.controller.ingressClass.create**                               | Create a custom IngressClass for the bundled controller.                                      |
| **nginx-ingress.controller.ingressClass.name**                                 | Name of the custom IngressClass.                                                              |
| **nginx-ingress.controller.ingressClassByName**                                | Lookup IngressClasses by name rather than annotation.                                         |
| ------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------- |

## Configuring an external database

If you disable the embedded sidecar (`ontoserver.deployment.db.enabled: false`), you must supply the following in `ontoserver.config`:

```yaml
spring.datasource.url: "jdbc:postgresql://<host>:<port>/<db>"
spring.datasource.username: "<user>"
spring.datasource.password: "<password>"
```

See the [Spring Boot DataSource configuration guide](https://docs.spring.io/spring-boot/docs/current/reference/html/data.html#data.sql.datasource.configuration).

## Customization

To override the default CSS and logos under `/fhir/.well-known`, create a `ConfigMap`:

```bash
kubectl create configmap ontoserver-customization \
  --from-file=logo.png \
  --from-file=organisation_logo.png \
  --from-file=organisation.css
```

Then set:

```yaml
ontoserver.customization: "ontoserver-customization"
```

## Gateway API vs Ingress

* **Gateway API** (default when `ontoserver.gateway.enabled: true`): requires a compatible GatewayClass (e.g. Envoy) and will create `Gateway`, `HTTPRoute`, and optionally `Issuer` resources.
* **Ingress** (when `ontoserver.ingress.enabled: true`): creates a standard `networking.k8s.io/v1` Ingress with optional TLS via cert-manager.

---

Copyright © 2025 Commonwealth Scientific and Industrial Research Organisation (CSIRO) ABN 41 687 119 230. All rights reserved.
