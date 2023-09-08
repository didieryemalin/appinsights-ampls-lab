param environmentName string

param location string

param privateEndpointSubnetId string

param privateLinkId string

var abbrs = loadJsonContent('../abbreviations.json')
var tags = { 'azd-env-name': environmentName }

//Creating Private Endpoint 
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: '${abbrs.networkPrivateEndpoint}${environmentName}'
  tags: tags
  location: location
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name:'${abbrs.networkPrivateLinkServices}${environmentName}'
        properties: {
          privateLinkServiceId: privateLinkId
          groupIds: [
            'azuremonitor'
          ]
        }
      }
    ]
  }
}

output privateEndpointName string = privateEndpoint.name
