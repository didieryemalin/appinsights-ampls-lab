param privateEndpointSubnetId string
param privateLinkId string
param location string
module privateEndpoint 'privateendpoint.bicep' ={
  name: 'PrivateEndpoint'
  params: {
    name: 'PrivateEndpoint'
    location: location
    privateEndpointSubnetId: privateEndpointSubnetId
    privateLinkId: privateLinkId
  }
}

module privateDNSZones 'privatednsdeploy.bicep' = {
  name: 'priavateDnsZones'
  params: {
    
  }
}

module vnetlinks 'virtualnetworklinks.bicep' = {
  name = 'vnetlinks'
  
}

