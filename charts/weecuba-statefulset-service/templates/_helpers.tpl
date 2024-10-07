{{/*
Expand the name of the chart.
*/}}
{{- define "weecuba-statefulset-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Version
*/}}
{{- define "weecuba-statefulset-service.version" -}}
{{- .Values.statefulset.image.tag | default .Chart.AppVersion }}
{{- end }}

{{- define "weecuba-statefulset-service.namespace" -}}
  {{- default .Release.Namespace .Values.forceNamespace -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "weecuba-statefulset-service.fullname" -}}
{{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else if .Values.nameOverride }}
    {{- .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
    {{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "weecuba-statefulset-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "weecuba-statefulset-service.labels" -}}
helm.sh/chart: {{ include "weecuba-statefulset-service.chart" . }}
{{ include "weecuba-statefulset-service.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/release: {{ .Release.Name }}
app.kubernetes.io/version: {{ include "weecuba-statefulset-service.version" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "weecuba-statefulset-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "weecuba-statefulset-service.fullname" . }}
app.kubernetes.io/organization: {{ .Values.organization }}
app.kubernetes.io/environment: {{ .Values.environmentName }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "weecuba-statefulset-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "weecuba-statefulset-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}