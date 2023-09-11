param location string 

param environmentName string

param dceName string
param dceEndpointId string

param laworkspaceId string
param laworkspaceName string

param appInsightsName string
param appInsightsId string

param privateEndpointSubnetId string

param ventId string

//deploying AMPLS
module ampls 'ampls.bicep' = {
  name : 'amplsdeployment'
  params: {
    environmentName: environmentName
  }
}

//Creating Private Endpoint
module privateEndpoint 'privateendpoint.bicep'={
  name: 'privateEndpointDeployment'
  params: {
    environmentName: environmentName
    location: location
    privateEndpointSubnetId: privateEndpointSubnetId
    privateLinkId: ampls.outputs.privateLinkId 
  }
}

//deploying Private DNS Zones
module privateDnsZones 'privatednsdeploy.bicep'={
  name: 'priavteDnsDeployment'
  params: {
    environmentName: environmentName
  }
}

//Adding vnetlink to private DNS Zone 
module vnetLinkMonitor 'vnetlink.bicep' ={
  name: 'ventLinkMonitor'
  params: {
    privateDnsName: privateDnsZones.outputs.privateDnsMonitorName
    vnetId: ventId
    vnetLinkName: '${privateDnsZones.outputs.privateDnsMonitorName}.vnetlink'
  }
}

//Adding vnetlink to private DNS Zone 
module vnetLinkOMS 'vnetlink.bicep'={
  name: 'vnetLinkOMS'
  params: {
    privateDnsName: privateDnsZones.outputs.privateDnsOmsName
    vnetId: ventId
    vnetLinkName: '${privateDnsZones.outputs.privateDnsOmsName}.vnetlink'
  }
}

//Adding vnetlink to private DNS Zone 
module vnetLinkODS 'vnetlink.bicep'={
  name: 'vnetLinkODS'
  params: {
    privateDnsName: privateDnsZones.outputs.privateDnsOdsName
    vnetId: ventId
    vnetLinkName: '${privateDnsZones.outputs.privateDnsOdsName}.vnetlink'
  }
}

//Adding vnetlink to private DNS Zone 
module vnetLinkAgentsvc 'vnetlink.bicep'={
  name: 'vnetLinkAgentsvc'
  params: {
    privateDnsName: privateDnsZones.outputs.rivateDnsAgentSvcName
    vnetId: ventId
    vnetLinkName: '${privateDnsZones.outputs.rivateDnsAgentSvcName}.vnetlink'
  }
}

//Adding vnetlink to private DNS Zone 
module vnetLinkBlobCore 'vnetlink.bicep' ={
  name: 'vnetLinkBlobCore'
  params: {
    privateDnsName: privateDnsZones.outputs.privateDnsblobCoreName
    vnetId: ventId
    vnetLinkName: '${privateDnsZones.outputs.privateDnsblobCoreName}.vnetlink'
  }
}

//Adding Private DNS Zone configuration for Private Endpoint
module privateDnsZoneGroupDeplyment  'privatednszonegroup.bicep'={
  name: 'privateDnsZoneGroupDeployment'
  params: {
    privateDnsAgentsvcId: privateDnsZones.outputs.privateDnsAgentSvcId
    privateDnsBlobCoreId: privateDnsZones.outputs.privateDnsblobCoreId
    privateDnsMonitorId: privateDnsZones.outputs.privateDnsMonitorId
    privateDnsOdsId: privateDnsZones.outputs.privateDnsOdsId
    privateDnsOmsId: privateDnsZones.outputs.privateDnsOmsId
    privateEndpointName: privateEndpoint.outputs.privateEndpointName
  }
  dependsOn:[
    privateEndpoint
  ]
}

//Adding AppInsihgts to AMPLS
module scopedAI 'scopedresource.bicep' = {
  name: 'appInsightPrivatelink'
  params: {
    ScopedResourceName: appInsightsName
    amplsName: ampls.outputs.privateLinkScopeName
    scopedResourceId: appInsightsId
  }
  dependsOn: [
    privateEndpoint
  ]
}

//Adding LAW to AMPLS
module scopedlaw 'scopedresource.bicep' = {
  name: 'laworkspacePrivatelink'
  params: {
    ScopedResourceName: laworkspaceName
    amplsName: ampls.outputs.privateLinkScopeName
    scopedResourceId: laworkspaceId
  }
  dependsOn:[
    privateEndpoint
  ]
}
//Adding DCE to AMPLS
module scopeddce 'scopedresource.bicep' = {
  name: 'dceprivatelink'
  params: {
    ScopedResourceName: dceName
    amplsName: ampls.outputs.privateLinkScopeName
    scopedResourceId: dceEndpointId
  }
  dependsOn: [
    privateEndpoint
  ]
}
