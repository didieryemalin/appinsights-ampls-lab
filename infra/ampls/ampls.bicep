@description('Name of Azure Monitor Private Link Scope')
param name string

resource ampls 'microsoft.insights/privateLinkScopes@2021-07-01-preview' = {
  name: name
  location: 'global'
  properties: {
    accessModeSettings: {
      ingestionAccessMode: 'Open'
      queryAccessMode: 'Open'
    }
  }
}

output privateLinkScopeName string = ampls.name
output privateLinkId string = ampls.id
