function Get-UserName-Domain ($userName)
{
    $strUserName=$userName
    $strDomainDNS = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().Name
    $domain = New-Object DirectoryServices.DirectoryEntry
    $search = [System.DirectoryServices.DirectorySearcher]$strDomainDNS
    $search.Filter = "(&(objectClass=user)(sAMAccountname=$strUserName))"
    $user = $search.FindOne().GetDirectoryEntry()
    #$user | Select department , name, displayName, mail | Format-List
    return $user
}

<# Como chamar: 
    
   Get-UserName-Domain -userName LOGIN 

#>


