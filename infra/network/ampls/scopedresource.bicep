param scopedResourceId string

param amplsName string

param ScopedResourceName string

resource scopedResource 'Microsoft.Insights/privateLinkScopes/scopedResources@2021-07-01-preview' = {
  name: '${amplsName}/${ScopedResourceName}'
  properties: {
    linkedResourceId: scopedResourceId
  }
}
