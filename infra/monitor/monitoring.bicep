
param environmentName string
param location string 

module applicationInsights 'applicationinsights.bicep' = {
  name: 'applicationInsights'
  params: {
    environmentName: environmentName
    location: location
    laworkspaceId: logAnalyticsWorkspce.outputs.laworkspaceId
  }
}

module logAnalyticsWorkspce 'loganalytics.bicep' = {
  name: 'loganalytics'
  params: {
    environmentName: environmentName
    location: location
  }
}

output appInsightsId string = applicationInsights.outputs.appInsightsId
output appinsightsConnectionString string = applicationInsights.outputs.appinsightsConnectionString
output laworkspaceId string = logAnalyticsWorkspce.outputs.laworkspaceId
