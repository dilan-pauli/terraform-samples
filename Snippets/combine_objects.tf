variable "client_config" {
  type = list(object({
    client_id    = string
    display_name = string
    topic        = string
  }))
}

locals {
    const_app_settings = tomap({
    ApplicationInsightsAgent_EXTENSION_VERSION      = "~2"
    APPINSIGHTS_PROFILERFEATURE_VERSION             = "disabled"
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION             = "disabled"
    DiagnosticServices_EXTENSION_VERSION            = "disabled"
    InstrumentationEngine_EXTENSION_VERSION         = "disabled"
    SnapshotDebugger_EXTENSION_VERSION              = "disabled"
    XDT_MicrosoftApplicationInsights_BaseExtensions = "disabled"
    XDT_MicrosoftApplicationInsights_Java           = "1"
    XDT_MicrosoftApplicationInsights_Mode           = "recommended"
    XDT_MicrosoftApplicationInsights_NodeJS         = "1"
    XDT_MicrosoftApplicationInsights_PreemptSdk     = "disabled"
  })

  # Do some manipulation to get the client configuration in the correct format.
  client_configuration = merge(
    { for f in var.client_config : "ClientConfiguration__${f.client_id}__DisplayName" => "${f.display_name}" },
    { for f in var.client_config : "ClientConfiguration__${f.client_id}__Topic" => "${f.topic}" }
  )

  # Merge the const app settings with the inputed client config setting map this will be added to the App Service
  app_settings = merge(local.client_configuration, local.const_app_settings)
}