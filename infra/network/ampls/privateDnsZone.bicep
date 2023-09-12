param name string

param environmentName string

var tags = { 'azd-env-name': environmentName }

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: name
  tags : tags
  location: 'global'
  properties: {}
}

output privateDnsZoneId string = privateDnsZone.id
output privateDNsZoneName string = privateDnsZone.name
