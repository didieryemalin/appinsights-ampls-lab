param environmentName string

module privatelink_monitor_azure_com 'privateDnsZone.bicep'={
  name:'privatelink.monitor.azure.com'
  params: {
    name: 'privatelink.monitor.azure.com'
    environmentName: environmentName
  }
}

module privatelink_oms_opinsights_azure_com 'privateDnsZone.bicep'={
  name: 'privatelink.oms.opinsights.azure.com'
  params: {
    name: 'privatelink.oms.opinsights.azure.com'
    environmentName: environmentName
  }
}

module privatelink_ods_opinsights_azure_com 'privateDnsZone.bicep'={
  name: 'privatelink.ods.opinsights.azure.com'
  params: {
    name: 'privatelink.ods.opinsights.azure.com'
    environmentName: environmentName
  }
}

module privatelink_agentsvc_azure_automation_net 'privateDnsZone.bicep'={
  name: 'privatelink.agentsvc.azure.automation.net'
  params: {
    name: 'privatelink.agentsvc.azure.automation.net'
    environmentName:environmentName
  }
}

module privatelink_blob_core_windows_net 'privateDnsZone.bicep'={
  name: 'privatelink.blob.core.windows.net'
  params: {
    name: 'privatelink.blob.core.windows.net'
    environmentName: environmentName
  }
}

output privateDnsZoneMonitorId string = privatelink_monitor_azure_com.outputs.privateDnsZoneId
output privateDnsZoneMonitorName string = privatelink_monitor_azure_com.outputs.privateDNsZoneName

output privateDnsZoneOmsId string = privatelink_oms_opinsights_azure_com.outputs.privateDnsZoneId
output privateDnsZoneOmsName string = privatelink_oms_opinsights_azure_com.outputs.privateDNsZoneName

output privateDnsZoneOdsId string = privatelink_ods_opinsights_azure_com.outputs.privateDnsZoneId
output privateDnsZoneOdsName string = privatelink_ods_opinsights_azure_com.outputs.privateDNsZoneName

output privateDnsZoneAgentSvcId string = privatelink_agentsvc_azure_automation_net.outputs.privateDnsZoneId
output privateDnsZoneAgentSvcName string = privatelink_agentsvc_azure_automation_net.outputs.privateDNsZoneName

output privateDnsZoneBlobCoreId string= privatelink_blob_core_windows_net.outputs.privateDnsZoneId
output privateDnsZoneBlobCoreName string = privatelink_blob_core_windows_net.outputs.privateDNsZoneName
