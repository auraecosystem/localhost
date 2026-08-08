{{- range .Files -}}
  {{- $file := .Path -}}

  {{- range .Alerts -}}
    {{- $line := .Line -}}
    {{- $check := .Check -}}
    {{- $severity := .Severity -}}

    {{- $col := 1 -}}
    {{- if .Span -}}
      {{- $col = index .Span 0 -}}
    {{- end -}}

    {{- /*
      Ignore Vale's readability diagnostics.
    */ -}}
    {{- if not (hasPrefix $check "Readability") -}}

      {{- /*
        Ignore the synthetic first-position diagnostic.
      */ -}}
      {{- if or (ne $line 1) (ne $col 1) -}}

        {{- $title := $check | quote -}}

        {{- /*
          Normalize severity into GitHub's annotation levels.
        */ -}}

        {{- if eq $severity "error" -}}
::error file={{ $file }},line={{ $line }},col={{ $col }},title={{ $title }}::{{ .Message }}
        {{- else if eq $severity "warning" -}}
::warning file={{ $file }},line={{ $line }},col={{ $col }},title={{ $title }}::{{ .Message }}
        {{- else -}}
::notice file={{ $file }},line={{ $line }},col={{ $col }},title={{ $title }}::{{ .Message }}
        {{- end -}}

      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
