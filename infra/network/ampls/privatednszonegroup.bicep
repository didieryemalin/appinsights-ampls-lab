
param privateEndpointName string

param privateDnsZoneMonitorId string

param privateDnsZoneOmsId string

param privateDnsZoneOdsId string

param privateDnsZoneAgentsvcId string

param privateDnsZoneBlobCoreId string

resource privateEndpointDnsGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-05-01' = {
  name: '${privateEndpointName}/privateEndpointDnsGroup'
   properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-monitor-azure-com'
        properties: {
          privateDnsZoneId: privateDnsZoneMonitorId
        }
      }
      {
        name: 'privatelink-oms-opinsights-azure-com'
        properties: {
          privateDnsZoneId: privateDnsZoneOmsId
        }
      }
      {
        name: 'privatelink-ods-opinsights-azure-com'
        properties: {
          privateDnsZoneId: privateDnsZoneOdsId
        }
      }
      {
        name: 'privatelink-agentsvc-azure-automation-net'
        properties: {
          privateDnsZoneId: privateDnsZoneAgentsvcId
        }
      }
      {
        name: 'privatelink-blob-core-windows-net'
        properties: {
          privateDnsZoneId: privateDnsZoneBlobCoreId
        }
      }
    ]
  }
}
