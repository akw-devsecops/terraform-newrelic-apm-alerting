resource "newrelic_alert_policy" "policy" {
  name                = "${local.env_short}-${var.app_name}-alert-policy"
  incident_preference = var.incident_preference
}