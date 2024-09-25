{{/*
Expand the name of the chart.
*/}}
{{- define "weecuba-dotnet-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "weecuba-dotnet-service.namespace" -}}
  {{- default .Release.Namespace .Values.forceNamespace -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "weecuba-dotnet-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "weecuba-dotnet-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "weecuba-dotnet-service.labels" -}}
helm.sh/chart: {{ include "weecuba-dotnet-service.chart" . }}
{{ include "weecuba-dotnet-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/organization: {{ .Values.organization }}
app.kubernetes.io/environment: {{ .Values.environmentName }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "weecuba-dotnet-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "weecuba-dotnet-service.fullname" . }}
app.kubernetes.io/release: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "weecuba-dotnet-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "weecuba-dotnet-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
