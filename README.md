# New Relic APM Alerting Terraform module

Terraform module which creates alerting and notification for apm monitoring in New Relic.

This module is capable of creating an alert policy, a simple Synthetics monitor, and alert conditions (Apdex (Low),
Response time (High), Throughput (High), Error rate (High), Error Count (Logs), Synthetics monitor (Failure)) for a
given application reporting data into APM.

## Usage

```hcl
module "dummy_app_alerting" {
  source  = "akw-devsecops/apm-alerting/newrelic"
  version = "~>2.0"

  ##############
  ## Required ##
  ##############
  apm_application_name = "Dummy App APM Name (DEV)"
  app_name             = "ak-dummy-app"
  env                  = "dev"
  google_chat_url      = "https://chat.googleapis.com/v1/spaces/XXXXXXXXXXX/messages?key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&token=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

  synthetics_monitor_url = "https://example.com/ready-check"

  ##############
  ## Optional ##
  ##############
  google_chat_notification_triggers = ["ACTIVATED", "ACKNOWLEDGED", "PRIORITY_CHANGED", "CLOSED", "OTHER_UPDATES"]

  mobile_push_destination_ids       = ["aabb1122-33cc-44dd-ee55-ffgg6677hh88"]
  mobile_push_notification_triggers = ["ACTIVATED", "ACKNOWLEDGED", "PRIORITY_CHANGED", "CLOSED", "OTHER_UPDATES"]

  incident_preference = "PER_CONDITION"

  apdex_duration           = 60
  apdex_warning_threshold  = 0.9
  apdex_critical_threshold = 0.8

  synthetics_condition_duration                = 300
  synthetics_monitor_bypass_head_request       = true
  synthetics_monitor_treat_redirect_as_failure = true
  synthetics_monitor_verify_ssl                = true
  synthetics_monitor_validation_string         = "{\"status\":\"ready\"}"
  synthetics_monitor_period                    = "EVERY_5_MINUTES"

  synthetics_monitor_public_locations  = ["EU_WEST_1"]
  # OR
  synthetics_monitor_private_locations = ["286ae84e-594d-4282-853d-31d64725e61f"]

  error_rate_duration           = 120
  error_rate_warning_threshold  = 10
  error_rate_critical_threshold = 15

  response_time_duration           = 300
  response_time_warning_threshold  = 2
  response_time_critical_threshold = 5

  throughput_duration           = 180
  throughput_warning_threshold  = 400
  throughput_critical_threshold = 500

  enable_error_logs_alert = true
}
```

## Notes

1. This module does not create a google chat space.
2. You can optionally send notifications to a mobile push destination. Then the ID of the destination must be provided.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_newrelic"></a> [newrelic](#requirement\_newrelic) | >= 3.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_newrelic"></a> [newrelic](#provider\_newrelic) | >= 3.18 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [newrelic_alert_policy.policy](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_policy) | resource |
| [newrelic_notification_channel.google_chat](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/notification_channel) | resource |
| [newrelic_notification_channel.mobile_push](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/notification_channel) | resource |
| [newrelic_notification_destination.google_chat](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/notification_destination) | resource |
| [newrelic_nrql_alert_condition.apdex](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.error_logs](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.error_rate](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.response_time](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.synthetics](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.throughput](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_synthetics_monitor.synthetics_monitor](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/synthetics_monitor) | resource |
| [newrelic_workflow.apm_notification](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/workflow) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apm_application_name"></a> [apm\_application\_name](#input\_apm\_application\_name) | The name of the New Relic apm application to monitor | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | The name of the application | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | The hosting environment of the application | `string` | n/a | yes |
| <a name="input_google_chat_url"></a> [google\_chat\_url](#input\_google\_chat\_url) | The webhook url of the google chat space to send notifications to | `string` | n/a | yes |
| <a name="input_synthetics_monitor_url"></a> [synthetics\_monitor\_url](#input\_synthetics\_monitor\_url) | The URL to use when configuring a synthetics monitor for this application | `string` | n/a | yes |
| <a name="input_apdex_critical_threshold"></a> [apdex\_critical\_threshold](#input\_apdex\_critical\_threshold) | The threshold below which a critical violation will be triggered for the Apdex condition (percentage satisfied users) | `number` | `0.7` | no |
| <a name="input_apdex_duration"></a> [apdex\_duration](#input\_apdex\_duration) | The evaluation window length of the Apdex condition (seconds). Value must be a multiple of 60 and within 60-86400 seconds | `number` | `300` | no |
| <a name="input_apdex_warning_threshold"></a> [apdex\_warning\_threshold](#input\_apdex\_warning\_threshold) | The threshold below which a warning violation will be triggered for the Apdex condition (percentage satisfied users) | `number` | `0.8` | no |
| <a name="input_enable_error_logs_alert"></a> [enable\_error\_logs\_alert](#input\_enable\_error\_logs\_alert) | Enable alerts for logs with an log severity of `error` or higher. Log in context must be enabled in the apm agent | `bool` | `false` | no |
| <a name="input_error_rate_critical_threshold"></a> [error\_rate\_critical\_threshold](#input\_error\_rate\_critical\_threshold) | The threshold above which a critical violation will be triggered for the error rate condition (percentage) | `number` | `5` | no |
| <a name="input_error_rate_duration"></a> [error\_rate\_duration](#input\_error\_rate\_duration) | The evaluation window length of the error rate condition (seconds). Value must be a multiple of 60 and within 60-86400 seconds | `number` | `300` | no |
| <a name="input_error_rate_warning_threshold"></a> [error\_rate\_warning\_threshold](#input\_error\_rate\_warning\_threshold) | The threshold above which a warning violation will be triggered for the error rate condition (percentage) | `number` | `2` | no |
| <a name="input_google_chat_notification_triggers"></a> [google\_chat\_notification\_triggers](#input\_google\_chat\_notification\_triggers) | The issue events to notify on for google chat notifications. Valid values are ACTIVATED, ACKNOWLEDGED, PRIORITY\_CHANGED, CLOSED or OTHER\_UPDATES | `list(string)` | <pre>[<br>  "ACTIVATED",<br>  "ACKNOWLEDGED",<br>  "PRIORITY_CHANGED",<br>  "CLOSED",<br>  "OTHER_UPDATES"<br>]</pre> | no |
| <a name="input_incident_preference"></a> [incident\_preference](#input\_incident\_preference) | The rollup strategy for the alert policy. Valid values are PER\_POLICY, PER\_CONDITION, and PER\_CONDITION\_AND\_TARGET | `string` | `"PER_POLICY"` | no |
| <a name="input_mobile_push_destination_ids"></a> [mobile\_push\_destination\_ids](#input\_mobile\_push\_destination\_ids) | (Optional) The ids of mobile push destinations to send notifications to | `list(string)` | `[]` | no |
| <a name="input_mobile_push_notification_triggers"></a> [mobile\_push\_notification\_triggers](#input\_mobile\_push\_notification\_triggers) | The issue events to notify on for mobile push notifications. Valid values are ACTIVATED, ACKNOWLEDGED, PRIORITY\_CHANGED, CLOSED or OTHER\_UPDATES | `list(string)` | <pre>[<br>  "ACTIVATED",<br>  "ACKNOWLEDGED",<br>  "PRIORITY_CHANGED",<br>  "CLOSED",<br>  "OTHER_UPDATES"<br>]</pre> | no |
| <a name="input_response_time_critical_threshold"></a> [response\_time\_critical\_threshold](#input\_response\_time\_critical\_threshold) | The threshold above which a critical violation will be triggered for the response time condition (seconds) | `number` | `5` | no |
| <a name="input_response_time_duration"></a> [response\_time\_duration](#input\_response\_time\_duration) | The evaluation window length of the response time condition (seconds). Value must be a multiple of 60 and within 60-86400 seconds | `number` | `300` | no |
| <a name="input_response_time_warning_threshold"></a> [response\_time\_warning\_threshold](#input\_response\_time\_warning\_threshold) | The threshold above which a warning violation will be triggered for the response time condition (seconds) | `number` | `2` | no |
| <a name="input_synthetics_condition_duration"></a> [synthetics\_condition\_duration](#input\_synthetics\_condition\_duration) | The evaluation window length of the synthetics condition (seconds). Value must be a multiple of 60 and within 60-86400 seconds | `number` | `60` | no |
| <a name="input_synthetics_condition_threshold"></a> [synthetics\_condition\_threshold](#input\_synthetics\_condition\_threshold) | The threshold at which a critical violation will be triggered for the Synthetics condition (failure count) | `number` | `1` | no |
| <a name="input_synthetics_monitor_bypass_head_request"></a> [synthetics\_monitor\_bypass\_head\_request](#input\_synthetics\_monitor\_bypass\_head\_request) | If true, skip default HEAD request and instead use GET verb when running synthetics checks | `bool` | `true` | no |
| <a name="input_synthetics_monitor_period"></a> [synthetics\_monitor\_period](#input\_synthetics\_monitor\_period) | The interval at which this monitor should run. Valid values are EVERY\_MINUTE, EVERY\_5\_MINUTES, EVERY\_10\_MINUTES, EVERY\_15\_MINUTES, EVERY\_30\_MINUTES, EVERY\_HOUR, EVERY\_6\_HOURS, EVERY\_12\_HOURS, or EVERY\_DAY | `string` | `"EVERY_MINUTE"` | no |
| <a name="input_synthetics_monitor_private_locations"></a> [synthetics\_monitor\_private\_locations](#input\_synthetics\_monitor\_private\_locations) | The private locations to run synthetics checks from. Accepts a list of private location GUIDs. At least one of either `synthetics_monitor_locations_public` or `synthetics_monitor_location_private` is required. | `list(string)` | `null` | no |
| <a name="input_synthetics_monitor_public_locations"></a> [synthetics\_monitor\_public\_locations](#input\_synthetics\_monitor\_public\_locations) | The public locations to run synthetics checks from. Valid values are AP\_EAST\_1, AP\_SOUTH\_1, AP\_SOUTHEAST\_1, AP\_NORTHEAST\_2, AP\_NORTHEAST\_1, AP\_SOUTHEAST\_2, US\_WEST\_1, US\_WEST\_2, US\_EAST\_2, US\_EAST\_1, CA\_CENTRAL\_1, SA\_EAST\_1, EU\_WEST\_1, EU\_WEST\_2, EU\_WEST\_3, EU\_CENTRAL\_1, EU\_NORTH\_1, EU\_SOUTH\_1, ME\_SOUTH\_1, or AF\_SOUTH\_1. At least one of either `synthetics_monitor_locations_public` or `synthetics_monitor_location_private` is required. | `list(string)` | `null` | no |
| <a name="input_synthetics_monitor_treat_redirect_as_failure"></a> [synthetics\_monitor\_treat\_redirect\_as\_failure](#input\_synthetics\_monitor\_treat\_redirect\_as\_failure) | If true, categorize redirects during a monitor job as a failure when running synthetics checks | `bool` | `true` | no |
| <a name="input_synthetics_monitor_validation_string"></a> [synthetics\_monitor\_validation\_string](#input\_synthetics\_monitor\_validation\_string) | An optional validation text to search for, when running synthetics checks | `string` | `null` | no |
| <a name="input_synthetics_monitor_verify_ssl"></a> [synthetics\_monitor\_verify\_ssl](#input\_synthetics\_monitor\_verify\_ssl) | If true, verifies SSL chain when running synthetics checks | `bool` | `true` | no |
| <a name="input_throughput_critical_threshold"></a> [throughput\_critical\_threshold](#input\_throughput\_critical\_threshold) | The threshold above which a critical violation will be triggered for the throughput condition (requests per minute) | `number` | `500` | no |
| <a name="input_throughput_duration"></a> [throughput\_duration](#input\_throughput\_duration) | The evaluation window length of the throughput condition (seconds). Value must be a multiple of 60 and within 60-86400 seconds | `number` | `300` | no |
| <a name="input_throughput_warning_threshold"></a> [throughput\_warning\_threshold](#input\_throughput\_warning\_threshold) | The threshold above which a warning violation will be triggered for the throughput condition (requests per minute) | `number` | `200` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apdex_condition_id"></a> [apdex\_condition\_id](#output\_apdex\_condition\_id) | The ID of the provisioned apdex condition. |
| <a name="output_error_count_logs_condition_id"></a> [error\_count\_logs\_condition\_id](#output\_error\_count\_logs\_condition\_id) | The ID of the provisioned error count logs condition. |
| <a name="output_error_rate_condition_id"></a> [error\_rate\_condition\_id](#output\_error\_rate\_condition\_id) | The ID of the provisioned error rate condition. |
| <a name="output_notification_channel_google_chat_id"></a> [notification\_channel\_google\_chat\_id](#output\_notification\_channel\_google\_chat\_id) | The ID of the provisioned google chat notification channel. |
| <a name="output_notification_channel_mobile_push_ids"></a> [notification\_channel\_mobile\_push\_ids](#output\_notification\_channel\_mobile\_push\_ids) | A list of the IDs of the provisioned mobile push notification channels. |
| <a name="output_notification_destination_id"></a> [notification\_destination\_id](#output\_notification\_destination\_id) | The ID of the provisioned notification destination. |
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | The ID of the provisioned alert policy. |
| <a name="output_response_time_condition_id"></a> [response\_time\_condition\_id](#output\_response\_time\_condition\_id) | The ID of the provisioned response time condition. |
| <a name="output_synthetics_condition_id"></a> [synthetics\_condition\_id](#output\_synthetics\_condition\_id) | The ID of the provisioned synthetics condition. |
| <a name="output_synthetics_monitor_id"></a> [synthetics\_monitor\_id](#output\_synthetics\_monitor\_id) | The ID of the provisioned synthetics monitor. |
| <a name="output_throughput_condition_id"></a> [throughput\_condition\_id](#output\_throughput\_condition\_id) | The ID of the provisioned throughput condition. |
| <a name="output_workflow_id"></a> [workflow\_id](#output\_workflow\_id) | The ID of the provisioned workflow. |
<!-- END_TF_DOCS -->

## Docs

To update the docs just run

```shell
$ terraform-docs .
```