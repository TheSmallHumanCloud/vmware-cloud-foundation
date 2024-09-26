#Acquire Authentication Token
$Splat = @{
    "URI"     = "https://<IP or FQDN>/SAAS/API/1.0/REST/auth/system/login"
    "Headers" = @{
        'Content-Type' = "application/json"
        'Accept'       = "application/json"
    }
    "Method"  = "POST"
    "body"    = @{
        #Authentication credentials
        username = "<username>"
        password = "<password>"
    } | ConvertTo-JSON -Depth 6
}
$token = Invoke-RestMethod @Splat -SkipCertificateCheck | Select-Object -expandproperty sessionToken

#Search for Target User
$Splat = @{
    "URI"     = "https://<IP or FQDN>/SAAS/jersey/manager/api/scim/Users/.search"
    "Headers" = @{
        'Content-Type'  = "application/json"
        'Accept'        = "application/json"
        'Authorization' = "Bearer $($token)"
    }
    "Method"  = "POST"
    "body"    = @{
    } | ConvertTo-JSON -Depth 6

}
# Edit the username for which you are looking to edit an attribute for
$id = (Invoke-RestMethod @splat -SkipCertificateCheck).Resources | Where-Object { $_.userName -eq "< search username>" } | Select-Object -expandproperty id

#Modify User Property - Password
$Splat = @{
    "URI"     = "https://<IP or FQDN>/SAAS/jersey/manager/api/scim/Users/$($id)"
    "Headers" = @{
        'Content-Type'  = "application/json"
        'Accept'        = "application/json"
        'Authorization' = "Bearer $($token)"
    }
    "Method"  = "PATCH"
    "body"    = @{
        # Pass in the new attribute key and value, in this case the password in a secure fashion
        password = "<new password>"
    } | ConvertTo-JSON -Depth 6
}

Invoke-RestMethod @splat -SkipCertificateCheck
