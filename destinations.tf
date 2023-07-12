resource "newrelic_notification_destination" "google_chat" {
  name = "${local.env_short}-${var.app_name}-google-chat-destination"
  type = "WEBHOOK"

  property {
    key   = "url"
    value = var.google_chat_url
  }
}