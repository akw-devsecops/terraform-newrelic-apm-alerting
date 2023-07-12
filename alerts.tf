resource "newrelic_nrql_alert_condition" "apdex" {
  policy_id = newrelic_alert_policy.policy.id
  name      = "Apdex (Low)"

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
    query = "SELECT apdex(duration, t: ${var.apdex_t}) FROM Transaction WHERE appName = '${var.apm_application_name}'"
  }
}

resource "newrelic_nrql_alert_condition" "error_rate" {
  policy_id = newrelic_alert_policy.policy.id
  name      = "Error rate (High)"

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
    query = "SELECT percentage(count(*), WHERE error IS TRUE) FROM Transaction WHERE appName = '${var.apm_application_name}'"
  }
}

resource "newrelic_nrql_alert_condition" "synthetics" {
  policy_id = newrelic_alert_policy.policy.id
  name      = "Synthetics monitor (Failure)"

  violation_time_limit_seconds = 86400

  critical {
    operator              = "above"
    threshold             = var.synthetics_condition_threshold
    threshold_duration    = var.synthetics_condition_duration
    threshold_occurrences = "all"
  }

  nrql {
    query = "SELECT count(*) FROM SyntheticCheck WHERE result != 'SUCCESS' WHERE monitorId = '${newrelic_synthetics_monitor.synthetics_monitor.id}'"
  }
}

resource "newrelic_nrql_alert_condition" "response_time" {
  policy_id = newrelic_alert_policy.policy.id
  name      = "Response time (High)"

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
    query = "SELECT average(duration) FROM Transaction WHERE appName = '${var.apm_application_name}'"
  }
}

resource "newrelic_nrql_alert_condition" "throughput" {
  policy_id = newrelic_alert_policy.policy.id
  name      = "Throughput (High)"

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
    query = "SELECT rate(count(*), 1 minute) FROM Transaction WHERE appName = '${var.apm_application_name}'"
  }
}