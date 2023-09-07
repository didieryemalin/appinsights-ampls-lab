param name string

resource privateDNSzone 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: name
  location: 'global'
  tags: {}
  properties: {}
}

output privateDNSZoneId string = privateDNSzone.id
