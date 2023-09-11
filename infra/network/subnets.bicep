// subnet.bicep
@description('name if the virtual network')
param vnetName string

@description('subnet name')
param subnetName string

@description('Subnet address prefix in CIDR')
param subnetAddressPrefix string

@description('checking if this subnet should be delegated to AppService')
param delegateToAppService bool = false

var abbrs = loadJsonContent('../abbreviations.json')

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-06-01' = {
  name: '${vnetName}/${abbrs.networkVirtualNetworksSubnets}${subnetName}'
  properties: {
    addressPrefix: subnetAddressPrefix
    delegations: delegateToAppService ? [
      {
        name: 'appServiceDelegation'
        properties: {
          serviceName: 'Microsoft.Web/serverFarms'
        }
      }
    ] : []
  }
}

output subNetId string = subnet.id
