param environmentName string

param location string

var abbrs = loadJsonContent('../abbreviations.json')
var tags = { 'azd-env-name': environmentName }

//Creating Log Analytics Workspace
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
  name: '${abbrs.operationalInsightsWorkspaces}${environmentName}'
  tags: tags
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
 }
}

output laworkspaceId string = logAnalyticsWorkspace.id
output laworkspaceName string = logAnalyticsWorkspace.name
