param environmentName string

param location string

param laworkspaceId string

var abbrs = loadJsonContent('../abbreviations.json')
var tags = { 'azd-env-name': environmentName }

//creating Application Insights
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${abbrs.insightsComponents}${environmentName}'
  location: location
  tags: tags
  kind:'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: laworkspaceId
  }
}

output appInsightsId string = appInsights.id
output appInsightsConnectionString string = appInsights.properties.ConnectionString
output appInsightsName string = appInsights.name
