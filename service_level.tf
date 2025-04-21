resource "newrelic_service_level" "service_level_indicator" {
  count = var.enable_service_level ? 1 : 0

  guid = data.newrelic_entity.apm_application_name.guid
  name = "${var.apm_application_name} latency"

  events {
    account_id = data.newrelic_account.account_id
    valid_events {
      from  = "Transaction"
      where = "appName = '${var.apm_application_name}' AND (transactionType='Web')"
    }
    good_events {
      from  = "Transaction"
      where = "appName = '${var.apm_application_name}' AND (transactionType= 'Web') AND duration < '${var.service_level_latency}'"
    }
  }

  objective {
    target = var.sli_target
    time_window {
      rolling {
        count = 7
        unit  = "DAY"
      }
    }
  }
}