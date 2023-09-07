param name string

param location string

param laworkspaceId string

//creating Application Insights
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: name
  location: location
  kind:'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: laworkspaceId
  }
}

output appInsightsId string = appInsights.id
output appinsightsConnectionString string = appInsights.properties.ConnectionString
