resource "newrelic_notification_channel" "google_chat" {
  name           = "${local.env_short}-${var.app_name}-google-chat-notification-channel"
  type           = "WEBHOOK"
  destination_id = newrelic_notification_destination.google_chat.id
  product        = "IINT" // (Workflows)

  property {
    key   = "payload"
    value = local.google_chat_template
    label = "Payload Template"
  }
}

resource "newrelic_notification_channel" "mobile_push" {
  for_each = toset(var.mobile_push_destination_ids)

  name           = "${local.env_short}-${var.app_name}-mobile-push-notification-channel-${index(var.mobile_push_destination_ids, each.value)}"
  type           = "MOBILE_PUSH"
  destination_id = each.value
  product        = "IINT" // (Workflows)

  property {
    key   = ""
    value = ""
  }
}