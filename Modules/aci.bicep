// Publish this to azure container registry.
// Publish-AzBicepModule -FilePath ./aci.bicep -Target br:registry1305.azurecr.io/bicep/modules/aci:1.0.0

param name string
param image string
param location string

@minValue(2)
@maxValue(4)
param cpu int

@minValue(2)
@maxValue(4)
param memory int

var port = 80

resource aci 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: name
  location: location
  properties: {
    osType: 'Linux'
    containers: [
      {
        name: 'con1'
        properties: {
          image: image
          ports: [
            {
              port: port
            }
          ]
          resources: {
            requests: {
              cpu: cpu
              memoryInGB: memory
            }
          }
        }
      }
    ]
    ipAddress: {
      type: 'Public'
      dnsNameLabel: name
      ports: [
        {
          port: port
        }
      ]
    }
  }
}
