#ziskanie login id kalendaru
Get-ADUser -Filter {name -like "*OneIT*Bike*1*-*CEMENT*-*1869*(Heidelberg)*" -or 
   name -like "*OneIT*Bike*2*-*AGGREGATES*-*1963*(Heidelberg)*" -or
   name -like "*OneIT*Bike*3*-*CONCRETE*-*1977*(Heidelberg)*" -or
   name -like "*OneIT*Bike*4*-*ASPHALT*-*1999*(Heidelberg)*" -or
   name -like "*OneIT*Bike*5*-*CLINKER*-*2018*(Heidelberg)*"
} | select samAccountName

#permissions na kalendar

$user="kohare";
$target ="usapurchasetopay"
$targets="deuoneitbike5","deuoneitbike3","deuoneitbike2","deuoneitbike4","deuoneitbike1";
#nastavenie reviewera, len ak userovi idem pridelit prava a este ziadne prava na folder nema, pokial by tam bol a chcel zmenit typ napr. aby mohol aj daco editovat, tak set-mailbox folder perms
foreach($t in $targets)
{
    Add-MailboxFolderPermission -Identity "$($t):\calendar" -User $user -AccessRights Reviewer
}
#get perms pre kontrolu
foreach($t in $targets)
{
    Get-MailboxFolderPermission -Identity "$($t):\calendar" 
}

#powershell page size
Get-WmiObject Win32_PageFileusage | Select-Object Name, AllocatedBaseSize

#ziskaj nazov groupy a kym je managed
$grpSet = 'GBR ARS Users',
'GBR Drive Encryption Administrators',
'GBR Workstation Admins',
'GRP CAPPM Clarity Stakeholders',
'GRP Company Cloud Storage User',
'GRP CTX A Local Administrators Password Solution',
'GRP EMEA ASC Neo Chipping IT SD',
'GRP GBR Airwatch Admins',
'GRP GBR Citrix Level 1 Support',
'GRP GBR Citrix Service Desk Country Admin',
'GRP GBR Ivanti Service Desk Country Admin',
'GRP PhoneFactor GBR Group Membership Admins',
'GRP SCCM Service Desk GBR',
'GRP SCCM SW Distribution GBR',
'GRP Solarwinds GBR',
'GRP Solarwinds EMEA Non-Data Center Reader',
'UK ServiceDesk Shadow Users'

$grpSet2='ACS Lobby Ambassadors',
'DEU Lobby Ambassadors',
'GRP CTX A ActiveRoles Server Console',
'GRP IPAM GBR Readers'

#vypise ludi aj groupy
foreach($g in $grpset2)
{
    Get-ADGroup -Filter {name -like $g} -Properties managedby | Select-Object name, @{Name="manager"; Expression={(Get-ADObject $_.managedBy).name}} | where manager -notLike "Noel*Green" | select name
}

