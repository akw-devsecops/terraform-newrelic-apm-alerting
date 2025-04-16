resource "newrelic_nrql_alert_condition" "apdex" {
  count     = var.enable_apdex_alert == true ? 1 : 0
  policy_id = newrelic_alert_policy.policy.id
  name      = "${upper(var.env)} - Apdex (Low)"

  violation_time_limit_seconds = 86400

  warning {
    operator              = "below"
    threshold             = var.apdex_warning_threshold
    threshold_duration    = var.apdex_duration
    threshold_occurrences = "all"
  }

  critical {
    operator              = "below"
    threshold             = var.apdex_critical_threshold
    threshold_duration    = var.apdex_duration
    threshold_occurrences = "all"
  }

  nrql {
    query = "SELECT apdex(apm.service.apdex) FROM Metric WHERE appName = '${var.apm_application_name}'"
  }
}

resource "newrelic_nrql_alert_condition" "error_rate" {
  policy_id = newrelic_alert_policy.policy.id
  name      = "${upper(var.env)} - Error rate (High)"

  violation_time_limit_seconds = 86400

  warning {
    operator              = "above"
    threshold             = var.error_rate_warning_threshold
    threshold_duration    = var.error_rate_duration
    threshold_occurrences = "all"
  }

  critical {
    operator              = "above"
    threshold             = var.error_rate_critical_threshold
    threshold_duration    = var.error_rate_duration
    threshold_occurrences = "all"
  }

  nrql {
    query = "SELECT (count(apm.service.error.count) / count(apm.service.transaction.duration)) * 100 AS 'Error rate (%)' FROM Metric WHERE appName = '${var.apm_application_name}'"
  }
}

resource "newrelic_nrql_alert_condition" "synthetics" {
  count = var.synthetics_monitor_url != null ? 1 : 0

  policy_id = newrelic_alert_policy.policy.id
  name      = "${upper(var.env)} - Synthetics monitor (Failure)"

  violation_time_limit_seconds = 86400

  critical {
    operator              = "above_or_equals"
    threshold             = var.synthetics_condition_threshold
    threshold_duration    = var.synthetics_condition_duration
    threshold_occurrences = "all"
  }

  nrql {
    query = "SELECT filter(count(*), WHERE result = 'FAILED') AS 'Failures' FROM SyntheticCheck WHERE entityGuid = '${newrelic_synthetics_monitor.synthetics_monitor[0].id}' FACET monitorName"
  }
}

resource "newrelic_nrql_alert_condition" "response_time" {
  policy_id = newrelic_alert_policy.policy.id
  name      = "${upper(var.env)} - Response time (High)"

  violation_time_limit_seconds = 86400

  warning {
    operator              = "above"
    threshold             = var.response_time_warning_threshold
    threshold_duration    = var.response_time_duration
    threshold_occurrences = "all"
  }

  critical {
    operator              = "above"
    threshold             = var.response_time_critical_threshold
    threshold_duration    = var.response_time_duration
    threshold_occurrences = "all"
  }

  nrql {
    query = "SELECT average(apm.service.transaction.duration) AS 'Response time (s)' FROM Metric WHERE appName = '${var.apm_application_name}'"
  }
}

resource "newrelic_nrql_alert_condition" "throughput" {
  policy_id = newrelic_alert_policy.policy.id
  name      = "${upper(var.env)} - Throughput (High)"

  violation_time_limit_seconds = 86400

  warning {
    operator              = "above"
    threshold             = var.throughput_warning_threshold
    threshold_duration    = var.throughput_duration
    threshold_occurrences = "all"
  }

  critical {
    operator              = "above"
    threshold             = var.throughput_critical_threshold
    threshold_duration    = var.throughput_duration
    threshold_occurrences = "all"
  }

  nrql {
    query = "SELECT count(apm.service.transaction.duration) AS 'Throughput' FROM Metric WHERE appName = '${var.apm_application_name}'"
  }
}

resource "newrelic_nrql_alert_condition" "error_logs" {
  count = var.enable_error_logs_alert ? 1 : 0

  policy_id = newrelic_alert_policy.policy.id
  name      = "${upper(var.env)} - Error Count (Logs)"

  violation_time_limit_seconds = 86400

  aggregation_method = "event_timer"
  aggregation_timer  = 60

  critical {
    operator              = "above_or_equals"
    threshold             = 1
    threshold_duration    = 60
    threshold_occurrences = "at_least_once"
  }

  nrql {
    query = "SELECT count(*) FROM Log WHERE entity.name = '${var.apm_application_name}' AND ( level = 'ERROR' OR level = 'FATAL' )"
  }
}
