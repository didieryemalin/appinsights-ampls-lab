param environmentName string

var abbrs = loadJsonContent('../../abbreviations.json')
var tags = { 'azd-env-name': environmentName }

resource ampls 'microsoft.insights/privateLinkScopes@2021-07-01-preview' = {
  name: '${abbrs.networkAzureMonitorPrivateLinkScope}${environmentName}'
  location: 'global'
  tags: tags
  properties: {
    accessModeSettings: {
      ingestionAccessMode: 'Open'
      queryAccessMode: 'Open'
    }
  }
}

output privateLinkScopeName string = ampls.name
output privateLinkId string = ampls.id
