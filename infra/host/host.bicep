param environmentName string
param location string = resourceGroup().location
param appplicationInsightsConnectionString string
param vnetIntegrationSubnetResourceId string
param iaasSubnetId string

module storage 'storage.bicep' = {
  name: 'storageaccountdeploy'
  params: {
    location: location
    environmentName: environmentName
    purpose: 'functionapp'
  }
}

module appserviceplan 'appserviceplan.bicep' = {
  name: 'appserviceplandeploy'
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
  name: 'functionappdeploy'
  params: {
    environmentName: environmentName
    location: location
    purpose: 'aidatagenerator'
    appServicePlanId: appserviceplan.outputs.appServicePlanId
    appplicationInsightsConnectionString: appplicationInsightsConnectionString
    storageConnectionString: storage.outputs.connectionstring
    vnetIntegrationSubnetResourceId: vnetIntegrationSubnetResourceId
  }
}

module virtualmachinewithama 'vmwithama.bicep' = {
  name: 'virtualmachinewithamadeploy'
  params: {
    environmentName: environmentName
    location: location
    vmSubnetId: iaasSubnetId
  }
}
