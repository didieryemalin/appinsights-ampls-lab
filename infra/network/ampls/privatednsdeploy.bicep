module privatelink_monitor_azure_com 'privatednszone.bicep' = {
  name:'privatelink.monitor.azure.com'
  params: {
    name: 'privatelink.monitor.azure.com'
  }
}

module privatelink_oms_opinsights_azure_com 'privatednszone.bicep' = {
  name: 'privatelink.oms.opinsights.azure.com'
  params: {
    name: 'privatelink.oms.opinsights.azure.com'
  }
}

module privatelink_ods_opinsights_azure_com 'privatednszone.bicep' = {
  name: 'privatelink.ods.opinsights.azure.com'
  params: {
    name: 'privatelink.ods.opinsights.azure.com'
  }
}

module privatelink_agentsvc_azure_automation_net 'privatednszone.bicep' = {
  name: 'privatelink.agentsvc.azure.automation.net'
  params: {
    name: 'privatelink.agentsvc.azure.automation.net'
  }
}

module privatelink_blob_core_windows_net 'privatednszone.bicep' = {
  name: 'privatelink.blob.core.windows.net'
  params: {
    name: 'privatelink.blob.core.windows.net'
  }
}

output privateDnsMonitorId string = privatelink_monitor_azure_com.outputs.privateDNSZoneId
output privateDnsOmsId string = privatelink_oms_opinsights_azure_com.outputs.privateDNSZoneId
output privateDnOodsId string = privatelink_ods_opinsights_azure_com.outputs.privateDNSZoneId
output privateDnsAgentsveId string = privatelink_agentsvc_azure_automation_net.outputs.privateDNSZoneId
output privateDnsBlobId string = privatelink_blob_core_windows_net.outputs.privateDNSZoneId
