param location string 

param environmentName string

param dceName string
param dceEndpointId string

param laworkspaceId string
param laworkspaceName string

param appInsightsName string
param appInsightsId string

param privateEndpointSubnetId string

param vnetId string

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
module privateDnsZones 'privateDnsZonedeploy.bicep'={
  name: 'priavteDnsDeployment'
  params: {
    environmentName: environmentName
  }
}

//Adding vnetlink to private DNS Zone 
module vnetLinkMonitor 'vnetlink.bicep' ={
  name: 'ventLinkMonitor'
  params: {
    privateDnsZoneName: privateDnsZones.outputs.privateDnsZoneMonitorName
    vnetId: vnetId
    vnetLinkName: '${privateDnsZones.outputs.privateDnsZoneMonitorName}.vnetlink'
  }
}

//Adding vnetlink to private DNS Zone 
module vnetLinkOMS 'vnetlink.bicep'={
  name: 'vnetLinkOMS'
  params: {
    privateDnsZoneName: privateDnsZones.outputs.privateDnsZoneOmsName
    vnetId: vnetId
    vnetLinkName: '${privateDnsZones.outputs.privateDnsZoneOmsName}.vnetlink'
  }
}

//Adding vnetlink to private DNS Zone 
module vnetLinkODS 'vnetlink.bicep'={
  name: 'vnetLinkODS'
  params: {
    privateDnsZoneName: privateDnsZones.outputs.privateDnsZoneOdsName
    vnetId: vnetId
    vnetLinkName: '${privateDnsZones.outputs.privateDnsZoneOdsName}.vnetlink'
  }
}

//Adding vnetlink to private DNS Zone 
module vnetLinkAgentsvc 'vnetlink.bicep'={
  name: 'vnetLinkAgentsvc'
  params: {
    privateDnsZoneName: privateDnsZones.outputs.privateDnsZoneAgentSvcName
    vnetId: vnetId
    vnetLinkName: '${privateDnsZones.outputs.privateDnsZoneAgentSvcName}.vnetlink'
  }
}

//Adding vnetlink to private DNS Zone 
module vnetLinkBlobCore 'vnetlink.bicep' ={
  name: 'vnetLinkBlobCore'
  params: {
    privateDnsZoneName: privateDnsZones.outputs.privateDnsZoneBlobCoreName
    vnetId: vnetId
    vnetLinkName: '${privateDnsZones.outputs.privateDnsZoneBlobCoreName}.vnetlink'
  }
}

//Adding Private DNS Zone configuration for Private Endpoint
module privateDnsZoneGroupDeplyment  'privatednszonegroup.bicep'={
  name: 'privateDnsZoneGroupDeployment'
  params: {
    privateDnsZoneAgentsvcId: privateDnsZones.outputs.privateDnsZoneAgentSvcId
    privateDnsZoneBlobCoreId: privateDnsZones.outputs.privateDnsZoneBlobCoreId
    privateDnsZoneMonitorId: privateDnsZones.outputs.privateDnsZoneMonitorId
    privateDnsZoneOdsId: privateDnsZones.outputs.privateDnsZoneOdsId
    privateDnsZoneOmsId: privateDnsZones.outputs.privateDnsZoneOmsId
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
