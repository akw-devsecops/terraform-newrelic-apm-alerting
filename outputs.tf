output "policy_id" {
  description = "The ID of the provisioned alert policy."
  value       = newrelic_alert_policy.policy.id
}

output "apdex_condition_id" {
  description = "The ID of the provisioned apdex condition."
  value       = newrelic_nrql_alert_condition.apdex.id
}

output "error_rate_condition_id" {
  description = "The ID of the provisioned error rate condition."
  value       = newrelic_nrql_alert_condition.error_rate.id
}

output "synthetics_condition_id" {
  description = "The ID of the provisioned synthetics condition."
  value       = newrelic_nrql_alert_condition.synthetics.id
}

output "response_time_condition_id" {
  description = "The ID of the provisioned response time condition."
  value       = newrelic_nrql_alert_condition.response_time.id
}

output "throughput_condition_id" {
  description = "The ID of the provisioned throughput condition."
  value       = newrelic_nrql_alert_condition.throughput.id
}

output "synthetics_monitor_id" {
  description = "The ID of the provisioned synthetics monitor."
  value       = newrelic_synthetics_monitor.synthetics_monitor.id
}

output "notification_destination_id" {
  description = "The ID of the provisioned notification destination."
  value       = newrelic_notification_destination.google_chat.id
}

output "notification_channel_google_chat_id" {
  description = "The ID of the provisioned google chat notification channel."
  value       = newrelic_notification_channel.google_chat.id
}

output "notification_channel_mobile_push_ids" {
  description = "A list of the IDs of the provisioned mobile push notification channels."
  value       = values(newrelic_notification_channel.mobile_push)[*].id
}

output "workflow_id" {
  description = "The ID of the provisioned workflow."
  value       = newrelic_workflow.apm_notification.id
}