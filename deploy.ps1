param(
    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [ValidateSet("Dev", "Prd")]
    [string]
    $Environment
)

$paramFile = switch ($Environment) {
    "Dev" { ".\Params\dev.json" }
    "Prd" { ".\Params\prd.json" }
}

New-AzResourceGroupDeployment `
    -Name $(New-Guid) `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile ".\main.bicep" `
    -TemplateParameterFile $paramFile `
    -Mode Complete

Remove-Item -Path ".\main.json"