#if not imported 
#Import-Module ActiveDirectory
$rouUsers = Get-ADUser -SearchBase "OU=Users,OU=ROU,OU=EU,DC=grouphc,DC=net" -filter * | select SamAccountName
foreach($user in $rouUsers)
{
    $groups=Get-ADPrincipalGroupMembership $user.SamAccountName | select SamAccountName
    if($groups.ForEach() -eq "Cisco EMEA Jabber Client")
    {
        
    }
}