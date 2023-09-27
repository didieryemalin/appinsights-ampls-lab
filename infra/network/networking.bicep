param location string 
param environmentName string

param appInsightsId string
param appInsightsName string
param dceEndpointId string
param dceName string
param laworkspaceId string
param laworkspaceName string

param vnetAddressPrefix string = '10.0.0.0/16'

param iaasSubnetAddressPrefix string = '10.0.1.0/24'

param appSubnetAddressPrefix string = '10.0.2.0/24'

param mgmtSubnetAddressPrefix string = '10.0.3.0/24'

module vnet './vnet.bicep' = {
  name: 'vnetdeployment'
  params: {
    location: location
    environmentName: environmentName
    vnetAddressPrefix: vnetAddressPrefix
  }
}

module iaasSubnet './subnets.bicep' = {
  name: 'iaaSsubnet'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: 'IaaS'
    subnetAddressPrefix: iaasSubnetAddressPrefix
  }
  dependsOn: [
    vnet
  ]
}

module appServiceSubnet './subnets.bicep' = {
  name: 'appsubnet'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: 'app'
    subnetAddressPrefix: appSubnetAddressPrefix
    delegateToAppService: true
  }
  dependsOn: [
    vnet
    iaasSubnet
  ]
}

module peSubnet './subnets.bicep' = {
  name: 'mgmtSubnet'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: 'mgmt'
    subnetAddressPrefix: mgmtSubnetAddressPrefix
  }
  dependsOn: [
   vnet
   appServiceSubnet
  ]
}

module amplsdeployment 'ampls/amplsdeploy.bicep' ={
  name: 'amplsenvironmentdeployment'
  params: {
    location: location
    appInsightsId: appInsightsId
    appInsightsName:appInsightsName 
    dceEndpointId: dceEndpointId
    dceName: dceName
    environmentName: environmentName
    laworkspaceId: laworkspaceId
    laworkspaceName: laworkspaceName
    privateEndpointSubnetId: peSubnet.outputs.subNetId
    vnetId: vnet.outputs.vnetId
  }
}

output appServiceSubnetId string = appServiceSubnet.outputs.subNetId
