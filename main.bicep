targetScope = 'resourceGroup'

param location string = resourceGroup().location
param saName string
param aciName string
param aciImage string

@allowed([ 'Standard_LRS', 'Premium_LRS' ])
param saSku string

@minValue(2)
@maxValue(4)
param aciCpu int

@minValue(2)
@maxValue(4)
param aciMemory int

var deploymentName = deployment().name

module storages 'br:registry1305.azurecr.io/bicep/modules/sa:1.0.0' = [for i in range(1, 3): {
  name: '${deploymentName}-saDeploy-${i}'
  params: {
    name: '${saName}${i}'
    location: location
    sku: saSku
  }
}]

module instances 'br:registry1305.azurecr.io/bicep/modules/aci:1.0.0' = [for i in range(1, 2): {
  name: '${deploymentName}-aciDeploy-${i}'
  params: {
    name: '${aciName}${i}'
    location: location
    image: aciImage
    cpu: aciCpu
    memory: aciMemory
  }
}]
