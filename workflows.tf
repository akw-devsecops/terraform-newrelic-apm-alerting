resource "newrelic_workflow" "apm_notification" {
  name                  = "${local.env_short}-${var.app_name}-workflow"
  muting_rules_handling = "NOTIFY_ALL_ISSUES"

  issues_filter {
    name = "${local.env_short}-${var.app_name}-filter-policy"

    # 'type' will be deprecated in the future
    type = "FILTER"

    predicate {
      attribute = "labels.policyIds"
      operator  = "EXACTLY_MATCHES"
      values    = [newrelic_alert_policy.policy.id]
    }
  }

  destination {
    channel_id            = newrelic_notification_channel.google_chat.id
    notification_triggers = var.google_chat_notification_triggers
  }

  dynamic "destination" {
    for_each = toset(var.mobile_push_destination_ids)

    content {
      channel_id            = newrelic_notification_channel.mobile_push[destination.value].id
      notification_triggers = var.mobile_push_notification_triggers
    }
  }
}