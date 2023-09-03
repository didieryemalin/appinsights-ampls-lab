param environmentName string
param location string = resourceGroup().location
param appplicationInsightsConnectionString string

module storage 'storage.bicep' = {
  name: 'storageaccount'
  params: {
    location: location
    environmentName: environmentName
    purpose: 'functionapp'
  }
}

module appserviceplan 'appserviceplan.bicep' = {
  name: 'functionappserviceplan'
  params: {
    sku: {
      name: 'S1'
      tier: 'Standard'
      size: 'S1'
      family: 'S'
      capacity: 1
    }
    kind: 'app'
    environmentName: environmentName
    purpose: 'functionapp'
    location: location
  }
}

module functionapp 'functionapp.bicep' = {
  name: 'functionapp'
  params: {
    environmentName: environmentName
    location: location
    purpose: 'ai-datagenerator'
    appServicePlanId: appserviceplan.outputs.appServicePlanId
    appplicationInsightsConnectionString: appplicationInsightsConnectionString
    storageConnectionString: storage.outputs.connectionstring
  }
}
