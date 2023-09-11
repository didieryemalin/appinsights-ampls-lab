param environmentName string

module privatelink_monitor_azure_com 'privatedns.bicep' ={
  name:'privatelink.monitor.azure.com'
  params: {
    name: 'privatelink.monitor.azure.com'
    environmentName: environmentName
  }
}

module privatelink_oms_opinsights_azure_com 'privatedns.bicep' ={
  name: 'privatelink.oms.opinsights.azure.com'
  params: {
    name: 'privatelink.oms.opinsights.azure.com'
    environmentName: environmentName
  }
}

module privatelink_ods_opinsights_azure_com 'privatedns.bicep'={
  name: 'privatelink.ods.opinsights.azure.com'
  params: {
    name: 'privatelink.ods.opinsights.azure.com'
    environmentName: environmentName
  }
}

module privatelink_agentsvc_azure_automation_net 'privatedns.bicep' ={
  name: 'privatelink.agentsvc.azure.automation.net'
  params: {
    name: 'privatelink.agentsvc.azure.automation.net'
    environmentName:environmentName
  }
}

module privatelink_blob_core_windows_net 'privatedns.bicep' ={
  name: 'privatelink.blob.core.windows.net'
  params: {
    name: 'privatelink.blob.core.windows.net'
    environmentName: environmentName
  }
}

output privateDnsMonitorId string = privatelink_monitor_azure_com.outputs.privateDnsZoneId
output privateDnsMonitorName string = privatelink_monitor_azure_com.outputs.privateDNsZoneName

output privateDnsOmsId string = privatelink_oms_opinsights_azure_com.outputs.privateDnsZoneId
output privateDnsOmsName string = privatelink_oms_opinsights_azure_com.outputs.privateDNsZoneName

output privateDnsOdsId string = privatelink_ods_opinsights_azure_com.outputs.privateDnsZoneId
output privateDnsOdsName string = privatelink_ods_opinsights_azure_com.outputs.privateDNsZoneName

output privateDnsAgentSvcId string = privatelink_agentsvc_azure_automation_net.outputs.privateDnsZoneId
output rivateDnsAgentSvcName string = privatelink_agentsvc_azure_automation_net.outputs.privateDNsZoneName

output privateDnsblobCoreId string= privatelink_blob_core_windows_net.outputs.privateDnsZoneId
output privateDnsblobCoreName string = privatelink_blob_core_windows_net.outputs.privateDNsZoneName
