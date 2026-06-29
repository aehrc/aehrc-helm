{{- define "ontocloak.adminSecretName" -}}
{{- if .Values.ontocloak.admin.existingSecret.enabled -}}
{{- .Values.ontocloak.admin.existingSecret.name -}}
{{- else -}}
{{- .Release.Name }}-ontocloak-keycloak-password
{{- end -}}
{{- end -}}

{{- define "ontocloak.adminUserKey" -}}
{{- .Values.ontocloak.admin.secretKeys.user -}}
{{- end -}}

{{- define "ontocloak.adminPasswordKey" -}}
{{- .Values.ontocloak.admin.secretKeys.password -}}
{{- end -}}

{{- define "ontocloak.dbSecretName" -}}
{{- if .Values.ontocloak.deployment.db.existingSecret.enabled -}}
{{- .Values.ontocloak.deployment.db.existingSecret.name -}}
{{- else -}}
{{- .Release.Name }}-ontocloak-db-secret
{{- end -}}
{{- end -}}

{{- define "ontocloak.dbUserKey" -}}
{{- .Values.ontocloak.deployment.db.secretKeys.user -}}
{{- end -}}

{{- define "ontocloak.dbPasswordKey" -}}
{{- .Values.ontocloak.deployment.db.secretKeys.password -}}
{{- end -}}
