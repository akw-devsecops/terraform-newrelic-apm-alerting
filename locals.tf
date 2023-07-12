locals {
  env_short = substr(upper(var.env), 0, 1)
}

locals {
  google_chat_template = jsonencode({
    "cardsV2" : [
      {
        "cardId" : "unique-card-id",
        "card" : {
          "header" : {
            "title" : "NewRelic Incident",
            "subtitle" : "{{#eq 'HIGH' priority}}WARNING{{else}}{{priority}}{{/eq}} - {{#if issueClosedAtUtc}}{{#eq 'USER_ACTION' triggerEvent}}closed by user {{owner}}{{else}}automatically closed{{/eq}}{{else if issueAcknowledgedAt}}acknowledged by {{owner}}{{else}}open{{/if}}",
            "imageUrl" : "https://www.jenkins.io/doc/book/resources/blueocean/dashboard/{{#if issueClosedAt}}status-passed{{else if (eq priority 'CRITICAL')}}status-failed{{else}}status-unstable{{/if}}.png",
            "imageType" : "SQUARE"
          },
          "sections" : [
            {
              "widgets" : [
                {
                  "decoratedText" : {
                    "topLabel" : "Condition",
                    "text" : "{{#each accumulations.conditionName}}{{this}}\n{{/each}}",
                    "wrapText" : true
                  }
                },
                {
                  "decoratedText" : {
                    "topLabel" : "Policy",
                    "text" : "{{#each accumulations.policyName}}{{this}}\n{{/each}}",
                    "wrapText" : true
                  }
                },
                {
                  "decoratedText" : {
                    "topLabel" : "Details",
                    "text" : "{{#each annotations.title}}{{this}}\n{{/each}}",
                    "wrapText" : true
                  }
                },
                {
                  "image" : {
                    "imageUrl" : "{{#if issueClosedAt}}null{{else if issueAcknowledgedAt}}null{{else}}{{#replace 'config.legend.enabled=false&width=400&height=210' violationChartUrl}}width=400&height=250{{/replace}}{{/if}}",
                    "onClick" : {
                      "openLink" : {
                        "url" : "{{issuePageUrl}}"
                      }
                    }
                  }
                }
              ]
            },
            {
              "widgets" : [
                {
                  "buttonList" : {
                    "buttons" : [
                      {
                        "text" : "Open",
                        "onClick" : {
                          "openLink" : {
                            "url" : "{{issuePageUrl}}"
                          }
                        }
                      },
                      {
                        "text" : "Acknowledge",
                        "onClick" : {
                          "openLink" : {
                            "url" : "{{issueAckUrl}}"
                          }
                        }
                      },
                      {
                        "text" : "Close",
                        "onClick" : {
                          "openLink" : {
                            "url" : "{{issueCloseUrl}}"
                          }
                        }
                      }
                    ]
                  }
                }
              ]
            }
          ]
        }
      }
    ]
  })
}