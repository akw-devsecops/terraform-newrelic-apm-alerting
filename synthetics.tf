resource "newrelic_synthetics_monitor" "synthetics_monitor" {
  count = var.synthetics_monitor_url != null ? 1 : 0
  
  status            = "ENABLED"
  name              = "${local.env_short}-${var.app_name}-simple-synthetics-monitor"
  period            = var.synthetics_monitor_period
  type              = "SIMPLE"
  locations_public  = var.synthetics_monitor_public_locations
  locations_private = var.synthetics_monitor_private_locations
  uri               = var.synthetics_monitor_url

  validation_string         = var.synthetics_monitor_validation_string
  verify_ssl                = var.synthetics_monitor_verify_ssl
  treat_redirect_as_failure = var.synthetics_monitor_treat_redirect_as_failure
  bypass_head_request       = var.synthetics_monitor_bypass_head_request
}