param vnetId string

param privateDnsZoneName string

param vnetLinkName string

resource privatelink_monitor_azure_com_vnetlink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  name: '${privateDnsZoneName}/${vnetLinkName}'
  location: 'global'
  properties: {
    virtualNetwork: {
      id: vnetId
    }
    registrationEnabled: false
  }
}
