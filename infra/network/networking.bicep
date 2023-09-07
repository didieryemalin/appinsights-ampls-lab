param location string 
param vnetName string = 'ampls-vnet'
param vnetAddressPrefix string = '10.0.0.0/16'
param subnet1Name string = 'default'
param subnet1AddressPrefix string = '10.0.1.0/24'
param subnet2Name string = 'appServiceSubnet'
param subnet2AddressPrefix string = '10.0.2.0/24'
param subnet3Name string = 'PESubnet'
param subnet3AddressPrefix string = '10.0.3.0/24'

module vnet './vnet.bicep' = {
  name: 'vnetModule'
  params: {
    location: location
    vnetName: vnetName
    vnetAddressPrefix: vnetAddressPrefix
  }
}

module subnet1 './subnets.bicep' = {
  name: 'subnet1Module'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: subnet1Name
    subnetAddressPrefix: subnet1AddressPrefix
  }
  dependsOn: [
    vnet
  ]
}

module subnet2 './subnets.bicep' = {
  name: 'subnet2Module'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: subnet2Name
    subnetAddressPrefix: subnet2AddressPrefix
    delegateToAppService: true
  }
  dependsOn: [
    vnet
    subnet1
  ]
}

module subnet3 './subnets.bicep' = {
  name: 'subnet3Module'
  params: {
    vnetName: vnet.outputs.vnetName
    subnetName: subnet3Name
    subnetAddressPrefix: subnet3AddressPrefix
  }
  dependsOn: [
    vnet
    subnet2
  ]
}
