Get-ADGroupMember -Identity "GRP SCCM Security Scopes DEU" -Recursive |
Where objectclass -eq 'user' |
Get-ADUser -Properties Displayname,Title,Department |
Select DistinguishedName,samAccountName,Name,Displayname,Title,Department | Out-File C:\users\pflorian\Documents\knowledge\powershell\GRP_SCCM_SC_SCOPES_DEU\users.txt
