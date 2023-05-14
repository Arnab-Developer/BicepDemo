// Publish this to azure container registry.
// Publish-AzBicepModule -FilePath ./sa.bicep -Target br:registry1305.azurecr.io/bicep/modules/sa:1.0.0

param name string
param location string

@allowed([ 'Standard_LRS', 'Premium_LRS' ])
param sku string

resource sa 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: name
  location: location
  sku: {
    name: sku
  }
  kind: 'StorageV2'
}
