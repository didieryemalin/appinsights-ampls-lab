param location string 
param environmentName string

param appInsightsId string
param appinsihgtsName string
param dceEndpointId string
param dceName string
param laworkspaceId string
param laworkspaceName string

param vnetAddressPrefix string = '10.0.0.0/16'

param subnet1AddressPrefix string = '10.0.1.0/24'

param subnet2AddressPrefix string = '10.0.2.0/24'

param subnet3AddressPrefix string = '10.0.3.0/24'

module vnet './vnet.bicep' = {
  name: 'vnetdeployment'
  params: {
    location: location
    environmentName: environmentName
    vnetAddressPrefix: vnetAddressPrefix
  }
}

module desaultSubnet './subnets.bicep' = {
  name: 'IaaSsubnet'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: 'IaaS'
    subnetAddressPrefix: subnet1AddressPrefix
  }
  dependsOn: [
    vnet
  ]
}

module webAppSubnet './subnets.bicep' = {
  name: 'PaaSsubnet'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: 'PaaS'
    subnetAddressPrefix: subnet2AddressPrefix
    delegateToAppService: true
  }
  dependsOn: [
    vnet
    desaultSubnet
  ]
}

module peSubnet './subnets.bicep' = {
  name: 'MgmtSubnet'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: 'Mgmt'
    subnetAddressPrefix: subnet3AddressPrefix
  }
  dependsOn: [
   vnet
   webAppSubnet
  ]
}

module amplsdeployment 'ampls/amplsdeploy.bicep' ={
  name: 'amplsenvironmentdeployment'
  params: {
    location: location
    appInsightsId: appInsightsId
    appInsightsName:appinsihgtsName 
    dceEndpointId: dceEndpointId
    dceName: dceName
    environmentName: environmentName
    laworkspaceId: laworkspaceId
    laworkspaceName: laworkspaceName
    privateEndpointSubnetId: peSubnet.outputs.subNetId
    ventId: vnet.outputs.ventId 
  }
}
