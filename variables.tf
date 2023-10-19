#########################
## Global
#########################
variable "apm_application_name" {
  description = "The name of the New Relic apm application to monitor"
  type        = string
}

variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "env" {
  description = "The hosting environment of the application"
  type        = string
}

#########################
## Google Chat
#########################
variable "google_chat_url" {
  description = "The webhook url of the google chat space to send notifications to"
  type        = string
}

variable "google_chat_notification_triggers" {
  description = "The issue events to notify on for google chat notifications. Valid values are ACTIVATED, ACKNOWLEDGED, PRIORITY_CHANGED, CLOSED or OTHER_UPDATES"
  type        = list(string)
  default     = ["ACTIVATED", "ACKNOWLEDGED", "PRIORITY_CHANGED", "CLOSED", "OTHER_UPDATES"]
}

#########################
## Mobile Push
#########################
variable "mobile_push_destination_ids" {
  description = "(Optional) The ids of mobile push destinations to send notifications to"
  type        = list(string)
  default     = []
}

variable "mobile_push_notification_triggers" {
  description = "The issue events to notify on for mobile push notifications. Valid values are ACTIVATED, ACKNOWLEDGED, PRIORITY_CHANGED, CLOSED or OTHER_UPDATES"
  type        = list(string)
  default     = ["ACTIVATED", "ACKNOWLEDGED", "PRIORITY_CHANGED", "CLOSED", "OTHER_UPDATES"]
}

#########################
## Policy
#########################
variable "incident_preference" {
  description = "The rollup strategy for the alert policy. Valid values are PER_POLICY, PER_CONDITION, and PER_CONDITION_AND_TARGET"
  type        = string
  default     = "PER_POLICY"
}

#########################
## Apdex
#########################
variable "apdex_warning_threshold" {
  description = "The threshold below which a warning violation will be triggered for the Apdex condition (percentage satisfied users)"
  type        = number
  default     = 0.8
}

variable "apdex_critical_threshold" {
  description = "The threshold below which a critical violation will be triggered for the Apdex condition (percentage satisfied users)"
  type        = number
  default     = 0.7
}

variable "apdex_duration" {
  description = "The evaluation window length of the Apdex condition (seconds). Value must be a multiple of 60 and within 60-86400 seconds"
  type        = number
  default     = 300
}

variable "apdex_t" {
  description = "The response time (seconds) above which a transaction is considered tolerable"
  type        = number
  default     = 0.5
}

#########################
## Error
#########################
variable "error_rate_warning_threshold" {
  description = "The threshold above which a warning violation will be triggered for the error rate condition (percentage)"
  type        = number
  default     = 2
}

variable "error_rate_critical_threshold" {
  description = "The threshold above which a critical violation will be triggered for the error rate condition (percentage)"
  type        = number
  default     = 5
}

variable "error_rate_duration" {
  description = "The evaluation window length of the error rate condition (seconds). Value must be a multiple of 60 and within 60-86400 seconds"
  type        = number
  default     = 300
}

#########################
## Synthetics
#########################
variable "synthetics_monitor_url" {
  description = "The URL to use when configuring a synthetics monitor for this application"
  type        = string
}

variable "synthetics_monitor_period" {
  description = "The interval at which this monitor should run. Valid values are EVERY_MINUTE, EVERY_5_MINUTES, EVERY_10_MINUTES, EVERY_15_MINUTES, EVERY_30_MINUTES, EVERY_HOUR, EVERY_6_HOURS, EVERY_12_HOURS, or EVERY_DAY"
  type        = string
  default     = "EVERY_MINUTE"
}

variable "synthetics_monitor_public_locations" {
  description = "The public locations to run synthetics checks from. Valid values are AP_EAST_1, AP_SOUTH_1, AP_SOUTHEAST_1, AP_NORTHEAST_2, AP_NORTHEAST_1, AP_SOUTHEAST_2, US_WEST_1, US_WEST_2, US_EAST_2, US_EAST_1, CA_CENTRAL_1, SA_EAST_1, EU_WEST_1, EU_WEST_2, EU_WEST_3, EU_CENTRAL_1, EU_NORTH_1, EU_SOUTH_1, ME_SOUTH_1, or AF_SOUTH_1. At least one of either `synthetics_monitor_locations_public` or `synthetics_monitor_location_private` is required."
  type        = list(string)
  default     = []
}

variable "synthetics_monitor_private_locations" {
  description = "The private locations to run synthetics checks from. Accepts a list of private location GUIDs. At least one of either `synthetics_monitor_locations_public` or `synthetics_monitor_location_private` is required."
  type        = list(string)
  default     = []
}

variable "synthetics_monitor_validation_string" {
  description = "An optional validation text to search for, when running synthetics checks"
  type        = string
  default     = null
}

variable "synthetics_monitor_verify_ssl" {
  description = "If true, verifies SSL chain when running synthetics checks"
  type        = bool
  default     = true
}

variable "synthetics_monitor_treat_redirect_as_failure" {
  description = "If true, categorize redirects during a monitor job as a failure when running synthetics checks"
  type        = bool
  default     = true
}

variable "synthetics_monitor_bypass_head_request" {
  description = "If true, skip default HEAD request and instead use GET verb when running synthetics checks"
  type        = bool
  default     = true
}

variable "synthetics_condition_threshold" {
  description = "The threshold above which a critical violation will be triggered for the Synthetics condition (failure count)"
  type        = number
  default     = 0
}

variable "synthetics_condition_duration" {
  description = "The evaluation window length of the synthetics condition (seconds). Value must be a multiple of 60 and within 60-86400 seconds"
  type        = number
  default     = 60
}

#########################
## Response Time
#########################
variable "response_time_warning_threshold" {
  description = "The threshold above which a warning violation will be triggered for the response time condition (seconds)"
  type        = number
  default     = 2
}

variable "response_time_critical_threshold" {
  description = "The threshold above which a critical violation will be triggered for the response time condition (seconds)"
  type        = number
  default     = 5
}

variable "response_time_duration" {
  description = "The evaluation window length of the response time condition (seconds). Value must be a multiple of 60 and within 60-86400 seconds"
  type        = number
  default     = 300
}

#########################
## Throughput
#########################
variable "throughput_warning_threshold" {
  description = "The threshold above which a warning violation will be triggered for the throughput condition (requests per minute)"
  type        = number
  default     = 200
}

variable "throughput_critical_threshold" {
  description = "The threshold above which a critical violation will be triggered for the throughput condition (requests per minute)"
  type        = number
  default     = 500
}

variable "throughput_duration" {
  description = "The evaluation window length of the throughput condition (seconds). Value must be a multiple of 60 and within 60-86400 seconds"
  type        = number
  default     = 300
}