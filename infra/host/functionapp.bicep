param environmentName string
param location string = resourceGroup().location
param purpose string
param appServicePlanId string
param appplicationInsightsConnectionString string
param storageConnectionString string

var abbrs = loadJsonContent('../abbreviations.json')
var tags = { 'azd-env-name': environmentName, 'azd-service-name': 'api' }
var functionAppName = '${abbrs.webSitesFunctions}${environmentName}-${purpose}'

resource functionapp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppName
  location: location
  tags: tags
  kind: 'functionapp'
  properties: {
    serverFarmId: appServicePlanId
    siteConfig: {
      appSettings: [
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appplicationInsightsConnectionString
        }
        {
          name: 'AzureWebJobsStorage'
          value: storageConnectionString
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: storageConnectionString
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(functionAppName)
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }
}

output url string = 'https://${functionapp.properties.defaultHostName}'
