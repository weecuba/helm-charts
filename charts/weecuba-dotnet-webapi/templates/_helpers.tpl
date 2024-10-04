{{/*
Expand the name of the chart.
*/}}
{{- define "weecuba-dotnet-webapi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Version
*/}}
{{- define "weecuba-dotnet-webapi.version" -}}
{{- .Values.deployment.image.tag | default .Chart.AppVersion }}
{{- end }}

{{- define "weecuba-dotnet-webapi.namespace" -}}
  {{- default .Release.Namespace .Values.forceNamespace -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "weecuba-dotnet-webapi.fullname" -}}
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
{{- define "weecuba-dotnet-webapi.chart" -}}
{{- $fullname := include "weecuba-dotnet-webapi.fullname" . -}}
{{- $version := include "weecuba-dotnet-webapi.version" . -}}
{{- printf "%s-%s" $fullname $version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "weecuba-dotnet-webapi.labels" -}}
helm.sh/chart: {{ include "weecuba-dotnet-webapi.chart" . }}
{{ include "weecuba-dotnet-webapi.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/release: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "weecuba-dotnet-webapi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "weecuba-dotnet-webapi.fullname" . }}
app.kubernetes.io/organization: {{ .Values.organization }}
app.kubernetes.io/environment: {{ .Values.environmentName }}
app.kubernetes.io/version: {{ include "weecuba-dotnet-webapi.version" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "weecuba-dotnet-webapi.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "weecuba-dotnet-webapi.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
