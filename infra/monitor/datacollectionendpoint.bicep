param environmentName string

param location string

var abbrs = loadJsonContent('../abbreviations.json')
var tags = { 'azd-env-name': environmentName }

resource datacollectionendpoint 'Microsoft.Insights/dataCollectionEndpoints@2021-09-01-preview' = {
  name: '${abbrs.datacollectionEndpoints}${environmentName}'
  tags: tags
  location: location
  kind: 'Windows'
  properties: {
    configurationAccess: {}
    logsIngestion: {}
    networkAcls: {
      publicNetworkAccess: 'Enabled'
    }
  }
}

output dceEndpointId string = datacollectionendpoint.id
output dceName string= datacollectionendpoint.name
