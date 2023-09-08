// vnet.bicep
param location string

param environmentName string

param vnetAddressPrefix string

var abbrs = loadJsonContent('../abbreviations.json')
var tags = { 'azd-env-name': environmentName }

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: '${abbrs.networkVirtualNetworksSubnets}${environmentName}'
  tags: tags
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
  }
}

output vnetName string = vnet.name

output ventId string = vnet.id
