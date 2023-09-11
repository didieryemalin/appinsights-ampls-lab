
param privateEndpointName string

param privateDnsMonitorId string

param privateDnsOmsId string

param privateDnsOdsId string

param privateDnsAgentsvcId string

param privateDnsBlobCoreId string

resource privateEndpointDnsGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-05-01' = {
  name: '${privateEndpointName}/privateEndpointDnsGroup'
   properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-monitor-azure-com'
        properties: {
          privateDnsZoneId: privateDnsMonitorId
        }
      }
      {
        name: 'privatelink-oms-opinsights-azure-com'
        properties: {
          privateDnsZoneId: privateDnsOmsId
        }
      }
      {
        name: 'privatelink-ods-opinsights-azure-com'
        properties: {
          privateDnsZoneId: privateDnsOdsId
        }
      }
      {
        name: 'privatelink-agentsvc-azure-automation-net'
        properties: {
          privateDnsZoneId: privateDnsAgentsvcId
        }
      }
      {
        name: 'privatelink-blob-core-windows-net'
        properties: {
          privateDnsZoneId: privateDnsBlobCoreId
        }
      }
    ]
  }
}
