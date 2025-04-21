# use accounnd_id in terraform newrelic provider block
data "newrelic_account" "account_id" {}

data "newrelic_entity" "apm_application" {
  account_id = data.newrelic_account.account_id
  name       = var.apm_application_name
  domain     = "APM"
  type       = "APPLICATION"
}
