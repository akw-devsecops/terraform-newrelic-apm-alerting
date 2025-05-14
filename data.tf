# use accounnd_id in terraform newrelic provider block
data "newrelic_account" "account_id" {}

data "newrelic_entity" "apm_application" {
  count = var.enable_service_level ? 1 : 0
  
  account_id = data.newrelic_account.account_id
  name       = var.apm_application_name
  domain     = "APM"
  type       = "APPLICATION"
}
