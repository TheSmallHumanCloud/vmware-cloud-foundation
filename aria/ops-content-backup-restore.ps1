#Acquire Token
$Splat = @{
    "URI"     = "https://vrops01.my-sddc.vcd/suite-api/api/auth/token/acquire"
    "Headers" = @{
        'Content-Type' = "application/json"
        'Accept'       = "application/json"
    }
    "Method"  = "POST"
    "body"    = @{
        username   = "$($user)"
        authSource = "vIDMAuthSource"
        password   = "$($password)"
    } | ConvertTo-JSON -Depth 6
}
$token = Invoke-RestMethod @Splat -SkipCertificateCheck | Select-Object -expandproperty token

#Export Content
$Splat = @{
    "URI"     = "https://vrops01.my-sddc.vcd/suite-api/api/content/operations/export"
    "Headers" = @{
        'Content-Type' = "application/json"
        'Accept'       = "application/json"
        Authorization  = "vRealizeOpsToken $($token)"
    }
    "Method"  = "POST"
    "body"    = @{
        scope        = "ALL"
        contentTypes = "DASHBOARDS", "CUSTOM_GROUPS", "SUPER_METRICS"
    } | ConvertTo-JSON -Depth 6
}
Invoke-RestMethod @Splat -SkipCertificateCheck

#Download Content
$Splat = @{
    "URI"     = "https://vrops01.my-sddc.vcd/suite-api/api/content/operations/export/zip"
    "Headers" = @{
        'Content-Type' = "application/json"
        'Accept'       = "application/json"
        Authorization  = "vRealizeOpsToken $($token)"
    }
    "Method"  = "GET"
}
Invoke-RestMethod @Splat -SkipCertificateCheck -OutFile "content.zip"

$File = @{
    contentFile = Get-Item -Path "C:\Users\Administrator\content.zip"
}

#Restore Content
$Splat = @{
    "URI"     = "https://vrops01.my-sddc.vcd/suite-api/api/content/operations/import"
    "Headers" = @{
        'Content-Type' = "multipart/form-data"
        'Accept'       = "*/*"
        Authorization  = "vRealizeOpsToken $($token)"
    }
    "Method"  = "POST"
}
Invoke-RestMethod @Splat -SkipCertificateCheck -Form $File

