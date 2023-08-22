param name string

param location string

param privateEndpointSubnetId string

param privateLinkId string

//Creating Private Endpoint 
resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: name
  location: location
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: name
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
