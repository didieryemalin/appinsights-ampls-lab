param environmentName string
param location string = resourceGroup().location

//module host 'host/host.bicep' = {
//  name: 'host'
//  params:{
//    environmentName: environmentName
//    location: location
//  }
//}

module monitoring 'monitor/monitoring.bicep' = {
  name: 'monitoring'
  params:{
    environmentName: environmentName
    location: location
  }
}

module networking 'network/networking.bicep' = {
  name: 'networking'
  params: {
    location: location
    appInsightsId: monitoring.outputs.appInsightsId
    appinsihgtsName: monitoring.outputs.appInsightsName
    dceEndpointId: monitoring.outputs.dceEndpointId
    dceName: monitoring.outputs.dceName
    environmentName: environmentName
    laworkspaceId: monitoring.outputs.laworkspaceId
    laworkspaceName: monitoring.outputs.laworkspaceName
  }
  }
