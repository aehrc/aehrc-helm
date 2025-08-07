# Ontocloak Helm chart

Helm chart for Ontocloak [https://ontoserver.csiro.au/site/our-solutions/ontocloak/](https://ontoserver.csiro.au/site/our-solutions/ontocloak/)

## Parameters

### Server settings

| Name                       | Description                                                       | Value                |
| -------------------------- | ----------------------------------------------------------------- | -------------------- |
| `ontocloak.serverName`     | Server hostname for Ontocloak service                             | `localhost`          |
| `ontocloak.hostNames`      | List of hostnames for ingress/gateway                             | `["localhost"]`      |
| `ontocloak.timeZone`       | Time zone for realm (e.g., Australia/Brisbane)                    | `Australia/Brisbane` |
| `ontocloak.admin.user`     | Admin username - provide it on command line, do not commit to git | `admin`              |
| `ontocloak.admin.password` | Admin password - provide it on command line, do not commit to git | `password`           |

### Deployment

| Name                                                                                             | Description                                                    | Value                       |
| ------------------------------------------------------------------------------------------------ | -------------------------------------------------------------- | --------------------------- |
| `ontocloak.deployment.kc_sh_path`                                                                | Full path to kc.sh script within Keycloak image                | `/opt/keycloak/bin/kc.sh`   |
| `ontocloak.deployment.annotations`                                                               | Controller manifest annotations                                | `{}`                        |
| `ontocloak.deployment.labels`                                                                    | Controller manifest labels                                     | `{}`                        |
| `ontocloak.deployment.podAnnotations`                                                            | Ontocloak pod annotations                                      | `{}`                        |
| `ontocloak.deployment.podLabels`                                                                 | Ontocloak pod labels                                           | `{}`                        |
| `ontocloak.deployment.image`                                                                     | Container image for Ontocloak                                  | `quay.io/aehrc/ontocloak:4` |
| `ontocloak.deployment.imagePullPolicy`                                                           | Image pull policy                                              | `Always`                    |
| `ontocloak.deployment.imagePullSecrets`                                                          | Secrets for pulling image                                      | `[]`                        |
| `ontocloak.deployment.replicas`                                                                  | Number of replicas (max 1, set 0 to disable deployment)        | `1`                         |
| `ontocloak.deployment.deploymentStrategy`                                                        | K8s update strategy for Ontocloak Pod                          | `RollingUpdate`             |
| `ontocloak.deployment.resources.requests.cpu`                                                    | CPU request for Ontocloak Pod (in millicores)                  | `500m`                      |
| `ontocloak.deployment.resources.requests.memory`                                                 | Memory request for Ontocloak Pod                               | `1Gi`                       |
| `ontocloak.deployment.resources.limits.cpu`                                                      | CPU limits for Ontocloak Pod (in millicores)                   | `500m`                      |
| `ontocloak.deployment.resources.limits.memory`                                                   | Memory limits for Ontocloak Pod                                | `1Gi`                       |
| `ontocloak.deployment.tolerations`                                                               | Enable Pod tolerations                                         | `[]`                        |
| `ontocloak.deployment.db.user`                                                                   | DB user (provided at runtime)                                  | `username`                  |
| `ontocloak.deployment.db.password`                                                               | DB password (provided at runtime)                              | `password`                  |
| `ontocloak.deployment.db.database`                                                               | Database name                                                  | `ontocloak`                 |
| `ontocloak.deployment.db.external.enabled`                                                       | Enable external Postgres instead of provided                   | `false`                     |
| `ontocloak.deployment.db.external.hostName`                                                      | External DB host name                                          | `""`                        |
| `ontocloak.deployment.db.provided.deploymentStrategy`                                            | Update strategy for provided Postgres Pod                      | `RollingUpdate`             |
| `ontocloak.deployment.db.provided.postgresVersion`                                               | Postgres version for provided database                         | `12`                        |
| `ontocloak.deployment.db.provided.resources.requests.cpu`                                        | CPU request for Ontocloak Pod (in millicores)                  | `500m`                      |
| `ontocloak.deployment.db.provided.resources.requests.memory`                                     | Memory request for Ontocloak Pod                               | `1Gi`                       |
| `ontocloak.deployment.db.provided.resources.limits.cpu`                                          | CPU limits for Ontocloak Pod (in millicores)                   | `500m`                      |
| `ontocloak.deployment.db.provided.resources.limits.memory`                                       | Memory limits for Ontocloak Pod                                | `1Gi`                       |
| `ontocloak.deployment.db.provided.tolerations`                                                   | Enable Pod tolerations                                         | `[]`                        |
| `ontocloak.deployment.db.provided.persistence.enabled`                                           | Enable PVC for databse files - Ignored if database is external | `true`                      |
| `ontocloak.deployment.db.provided.persistence.config.diskSize`                                   | Size of DB disk                                                | `10Gi`                      |
| `ontocloak.deployment.db.provided.persistence.config.existingVolume.enabled`                     | Bind to existing PV                                            | `false`                     |
| `ontocloak.deployment.db.provided.persistence.config.existingVolume.name`                        | Name of existing PV                                            | `""`                        |
| `ontocloak.deployment.db.provided.persistence.config.storageClass.name`                          | StorageClass name                                              | `default`                   |
| `ontocloak.deployment.db.provided.persistence.config.storageClass.provided.enabled`              | Use provided StorageClass                                      | `false`                     |
| `ontocloak.deployment.db.provided.persistence.config.storageClass.provided.storageProvisioner`   | CSI driver name                                                | `disk.csi.azure.com`        |
| `ontocloak.deployment.db.provided.persistence.config.storageClass.provided.reclaimPolicy`        | Reclaim policy (Retain/Delete)                                 | `Retain`                    |
| `ontocloak.deployment.db.provided.persistence.config.storageClass.provided.allowVolumeExpansion` | Enable volume expansion                                        | `true`                      |

### Migration/Server initialisation

| Name                                                 | Description                                                                            | Value             |
| ---------------------------------------------------- | -------------------------------------------------------------------------------------- | ----------------- |
| `ontocloak.migration.skipCheck`                      | Skip Database Check during startup - Leave it false if you run migration on startup    | `false`           |
| `ontocloak.migration.realmName`                      | Keycloak realm name (URL-safe)                                                         | `ontocloak-realm` |
| `ontocloak.migration.authoringServer.base`           | Base URL for authoring server                                                          | `""`              |
| `ontocloak.migration.authoringServer.fhir`           | FHIR API endpoint for authoring server                                                 | `""`              |
| `ontocloak.migration.productionServer.base`          | Base URL for production server                                                         | `""`              |
| `ontocloak.migration.productionServer.fhir`          | FHIR API endpoint for production server                                                | `""`              |
| `ontocloak.migration.syndicationServer.base`         | Base URL for syndication server                                                        | `""`              |
| `ontocloak.migration.clientSecrets.releasePromotion` | Secret for release promotion client - provide it on command line, do not commit to git | `password`        |
| `ontocloak.migration.clientSecrets.shrimp`           | Secret for shrimp client - provide it on command line, do not commit to git            | `password`        |
| `ontocloak.migration.clientSecrets.syndicationRead`  | Secret for syndication read client - provide it on command line, do not commit to git  | `password`        |
| `ontocloak.migration.clientSecrets.indexSyndication` | Secret for index syndication client - provide it on command line, do not commit to git | `password`        |
| `ontocloak.migration.clientSecrets.bundleImport`     | Secret for bundle import client - provide it on command line, do not commit to git     | `password`        |
| `ontocloak.migration.clientSecrets.ontoUi`           | Secret for OntoUI client - provide it on command line, do not commit to git            | `password`        |

### Configuration to include in the ontocloak.properties file

| Name                                                             | Description                | Value                          |
| ---------------------------------------------------------------- | -------------------------- | ------------------------------ |
| `ontocloak.config.ontocloak.action.agreement.enduser.version`    | Enduser Agreement Version  | `1.0`                          |
| `ontocloak.config.ontocloak.action.agreement.enduser.title`      | Enduser Agreement Title    | `Acme End User Agreement v1.0` |
| `ontocloak.config.ontocloak.action.agreement.enduser.group`      | Enduser Group              | `End users`                    |
| `ontocloak.config.ontocloak.action.agreement.enduser.html_text`  | Enduser Agreement Text     | `example`                      |
| `ontocloak.config.ontocloak.action.agreement.customer.version`   | Customer Agreement Version | `1.0`                          |
| `ontocloak.config.ontocloak.action.agreement.customer.title`     | Customer Agreement Title   | `Acme Customer Agreement v1.0` |
| `ontocloak.config.ontocloak.action.agreement.customer.group`     | Customer Agreement Group   | `Customers`                    |
| `ontocloak.config.ontocloak.action.agreement.customer.html_text` | Customer Agreement Text    | `example`                      |

### Server Environment variables

| Name            | Description                                | Value |
| --------------- | ------------------------------------------ | ----- |
| `ontocloak.env` | Additional Ontocloak environment variables | `{}`  |

### Cert-Manager

| Name                                      | Description                                       | Value                 |
| ----------------------------------------- | ------------------------------------------------- | --------------------- |
| `ontocloak.certmanager.enabled`           | Enable cert-manager                               | `true`                |
| `ontocloak.certmanager.clusterIssuerName` | ClusterIssuer name or prefix for Geteway's Issuer | `letsencrypt`         |
| `ontocloak.certmanager.email`             | Notification email for ACME                       | `noreply@example.com` |

### TLS settings

| Name                    | Description                         | Value           |
| ----------------------- | ----------------------------------- | --------------- |
| `ontocloak.tls.enabled` | Enable TLS Termination              | `true`          |
| `ontocloak.tls.certRef` | Reference to TLS certificate secret | `ontocloak-tls` |

### Gateway API settings

| Name                                          | Description                                                            | Value                 |
| --------------------------------------------- | ---------------------------------------------------------------------- | --------------------- |
| `ontocloak.gateway.enabled`                   | Enable Gateway API                                                     | `true`                |
| `ontocloak.gateway.listenerPortSecure`        | Secure listener port -  Depends on the gateway class - Traefik is 8443 | `443`                 |
| `ontocloak.gateway.annotations`               | Gateway annotations                                                    | `{}`                  |
| `ontocloak.gateway.infrastructureAnnotations` | Infrastructure annotations                                             | `{}`                  |
| `ontocloak.gateway.className`                 | GatewayClass name                                                      | `envoy-gateway-class` |
| `ontocloak.gateway.requestTimeout`            | Request timeout duration                                               | `5s`                  |

### Ingress resource settings

| Name                            | Description                           | Value             |
| ------------------------------- | ------------------------------------- | ----------------- |
| `ontocloak.ingress.enabled`     | Enable ingress for Ontocloak          | `false`           |
| `ontocloak.ingress.annotations` | Ingress resource annotations          | `{}`              |
| `ontocloak.ingress.className`   | Ingress class name (e.g., nginx, alb) | `ontocloak-nginx` |

### Prometheus metrics

| Name                        | Description               | Value   |
| --------------------------- | ------------------------- | ------- |
| `ontocloak.metrics.enabled` | Enable Prometheus Metrics | `false` |
| `ontocloak.metrics.port`    | Prometheus Metrics port   | `9000`  |

### Include Envoy Gateway controller specific manifests

| Name                                          | Description                                                                      | Value                  |
| --------------------------------------------- | -------------------------------------------------------------------------------- | ---------------------- |
| `envoygateway.healthAndMetrics.hideEndpoints` | Hide health and metrics endpoints via HTTPRouteFilter otherwise they are exposed | `false`                |
| `envoygateway.healthAndMetrics.metricsPath`   | Metrics endpoint url path                                                        | `/auth/metrics`        |
| `envoygateway.healthAndMetrics.healhPath`     | Health endpoint url path                                                         | `/auth/health`         |
| `envoygateway.controlPlaneNamespace`          | Envoy Gateway controller's namespace                                             | `envoy-gateway-system` |
| `envoygateway.servicemonitor.enabled`         | Enable Envoy Gateway Prometheus ServiceMonitor custom resource                   | `false`                |
| `envoygateway.servicemonitor.port`            | Envoy Gateway pod's metrics port - usually 9000 or named metrics                 | `metrics`              |
| `envoygateway.servicemonitor.path`            | Envoy Gateway pod's Prometheus metrics url path                                  | `/stats/prometheus`    |
| `envoygateway.servicemonitor.interval`        | Prometheus metrics update interval                                               | `15s`                  |
| `envoygateway.rateLimit.enabled`              | Enable rate limiting for the gateway via BackendTrafficPolicy                    | `false`                |
| `envoygateway.rateLimit.requests`             | Envoy dataplane rate limit - amount of requests per unit                         | `10`                   |
| `envoygateway.rateLimit.unit`                 | Envoy dataplane rate limit unit Second/Minute/Hour/Day/Month/Year                | `Second`               |

### F5 nginx-ingress-controller settings

| Name                    | Description                        | Value   |
| ----------------------- | ---------------------------------- | ------- |
| `nginx-ingress.enabled` | Enable F5 nginx-ingress-controller | `false` |

-------------------------------------------------------------------------------------------------
Table genareted with Readme Generator For Helm: [https://github.com/bitnami/readme-generator-for-helm](https://github.com/bitnami/readme-generator-for-helm)
