param location string 
param environmentName string

param vnetAddressPrefix string = '10.0.0.0/16'

param subnet1AddressPrefix string = '10.0.1.0/24'

param subnet2AddressPrefix string = '10.0.2.0/24'

param subnet3AddressPrefix string = '10.0.3.0/24'

module vnet './vnet.bicep' = {
  name: 'vnetModule'
  params: {
    location: location
    environmentName: environmentName
    vnetAddressPrefix: vnetAddressPrefix
  }
}

module subnet1 './subnets.bicep' = {
  name: 'IaaSsubnet'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: 'IaasSubnet'
    subnetAddressPrefix: subnet1AddressPrefix
  }
  dependsOn: [
    vnet
  ]
}

module subnet2 './subnets.bicep' = {
  name: 'PaaSsubnet'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: 'PaaSsubnet'
    subnetAddressPrefix: subnet2AddressPrefix
    delegateToAppService: true
  }
  dependsOn: [
    vnet
    subnet1
  ]
}

module subnet3 './subnets.bicep' = {
  name: 'MgmtSubnet'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: 'MgmtSubnet'
    subnetAddressPrefix: subnet3AddressPrefix
  }
  dependsOn: [
    vnet
    subnet2
  ]
}
