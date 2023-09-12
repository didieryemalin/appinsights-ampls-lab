param environmentName string

param location string 

module applicationInsights 'applicationinsights.bicep' ={
  name: 'appInsightsdeployment'
  params: {
    environmentName: environmentName
    location: location
    laworkspaceId: logAnalyticsWorkspce.outputs.laworkspaceId
  }
}

module logAnalyticsWorkspce 'loganalytics.bicep' = {
  name: 'laWorkspacedeployment'
  params: {
    environmentName: environmentName
    location: location
  }
}

module dataCollectionEndpoint 'datacollectionendpoint.bicep' ={
  name: 'dcedeployment'
  params: {
    environmentName: environmentName
    location: location
  }
}

output appInsightsId string = applicationInsights.outputs. appInsightsId
output appInsightsName string = applicationInsights.outputs.appInsightsName
output appinsihgtsConnectionString string = applicationInsights.outputs.appInsightsConnectionString

output laworkspaceId string = logAnalyticsWorkspce.outputs.laworkspaceId
output laworkspaceName string = logAnalyticsWorkspce.outputs.laworkspaceName

output dceEndpointId string = dataCollectionEndpoint.outputs.dceEndpointId
output dceName string= dataCollectionEndpoint.outputs.dceName

