param environmentName string
param location string = resourceGroup().location

module host 'host/host.bicep' = {
  name: 'host'
  params:{
    environmentName: environmentName
    location: location
    appplicationInsightsConnectionString: monitoring.outputs.appinsightsConnectionString
  }
}

module monitoring 'monitor/monitoring.bicep' = {
  name: 'monitoring'
  params:{
    environmentName: environmentName
    location: location
  }
}

// module networking 'network/networking.bicep' = {
//   name: 'networking'
//   params:{
//     environmentName: environmentName
//     location: location
//   }
// }
