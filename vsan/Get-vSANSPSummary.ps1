function Get-vSANSPSummary {
    <#
    .SYNOPSIS
        Export vSAN Storage Policy Information.
    .DESCRIPTION
        Export vSAN Storage Policies from vCenter showing FTT & Stripe information and amount of amount of VM's using each.
    .PARAMETER ExportPath
        Path the export the output HTML file.
    .NOTES
        Tags: VMware, vCenter, SPBM, PowerCLI, API
        Author: Stephan McTighe
        Website: stephanmctighe.com
    .LINK
        https://github.com/TheSmallHumanCloud/vmware-cloud-foundation
    .EXAMPLE
        PS C:\> Get-vSANSPSummary -ExportPath "C:\report\vSAN-Storage-Policy-Summary.html"
        Outputs a HTML file containing the Storage Policy Information for vSAN Storage Policies to a specified location.

#>
    [CmdletBinding()]
    param (        
        [Parameter(Mandatory)]
        [string] $ExportFilePath)

    Begin {}

    Process {
        try {
            $Output = @()
            $vSANstoragepolicies = Get-SpbmStoragePolicy -Namespace "VSAN"
            $SPBM = $vSANstoragepolicies | Select-Object Name, AnyOfRuleSets
            ForEach ($SP in $SPBM) {
                $Attributes = @( $SP | ForEach-Object { $_.AnyOfRuleSets } | Select-Object -ExpandProperty AllofRules)
                $object = [PSCustomObject]@{
                    SPName         = $SP.Name
                    ObjectCount    = $ObjectCount = (Get-SpbmEntityConfiguration -StoragePolicy "$($SP.name)").count
                    VMCount        = $VMCount = (Get-SpbmEntityConfiguration -StoragePolicy "$($SP.Name)" | Where-Object {$_.Entity -notlike "hard*"}).count
                    RAID           = $attributes | Where-Object { $_.Capability -like "*VSAN.replicaPreference*" } | Select-Object -ExpandProperty Value
                    FTT            = $attributes | Where-Object { $_.Capability -like "*VSAN.hostFailuresToTolerate*" } | Select-Object -ExpandProperty Value
                    SubFTT         = $attributes | Where-Object { $_.Capability -like "*VSAN.subFailuresToTolerate*" } | Select-Object -ExpandProperty Value
                    Stripes        = $attributes | Where-Object { $_.Capability -like "*VSAN.stripeWidth*" } | Select-Object -ExpandProperty Value
                    ForceProvision = $attributes | Where-Object { $_.Capability -like "*VSAN.forceProvisioning*" } | Select-Object -ExpandProperty Value
                    StorageType    = $attributes | Where-Object { $_.Capability -like "*VSAN.storageType*" } | Select-Object -ExpandProperty Value
                    IOPSLimit      = $attributes | Where-Object { $_.Capability -like "*VSAN.iopsLimit*" } | Select-Object -ExpandProperty Value
        
                }
                $Output += $object

            }
            $Output | ConvertTo-Html -Property SPName, VMCount, ObjectCount, RAID, FTT, SubFTT, Stripes, ForceProvision, StorageType, IOPSLimit | Out-File $ExportFilePath
        }
        catch {
            Write-Host "An error occurred!" -ForegroundColor Red
            Write-Host $_ -ForegroundColor Red
        }

    }  
}         