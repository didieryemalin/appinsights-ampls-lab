param environmentName string
param location string = resourceGroup().location
param vmSubnetId string

var abbrs = loadJsonContent('../abbreviations.json')
var vmName = '${abbrs.computeVirtualMachines}${environmentName}'

module vm 'virtualmachine.bicep' = {
  name: 'virtualmachinedeploy'
  params: {
    vmName: vmName
    adminUsername: 'amplsworkshop'
    adminPassword: 'amplsiseasyas123!'
    environmentName: environmentName
    location: location
    iaasSubnetId: vmSubnetId
  }
}
