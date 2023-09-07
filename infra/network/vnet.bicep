// vnet.bicep
param location string
param vnetName string
param vnetAddressPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetName
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
