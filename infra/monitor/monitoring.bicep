
param location string 

param appInsightsName string

param laWorkspaceName string


module applicationInsights 'applicationinsights.bicep' ={
  name: appInsightsName
  params: {
    name: appInsightsName
    location: location
    laworkspaceId: logAnalyticsWorkspce.outputs.laworkspaceId
  }
}

module logAnalyticsWorkspce 'loganalytics.bicep' = {
  name: laWorkspaceName
  params: {
    name: laWorkspaceName
    location: location
  }
}

output appInsightsId string = applicationInsights.outputs. appInsightsId
output appinsightsConnectionString string = applicationInsights.outputs.appinsightsConnectionString
output laworkspaceId string = logAnalyticsWorkspce.outputs.laworkspaceId
