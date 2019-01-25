#initialization
$usrs = 'rondrace'

$target='czesrvcvr'

$notes='AD account created: SR-1770920

Resource Information:
Custodian: Nelson Pang, David Kwong, Fiona Leung
Seats: 20

Has following services/amenities:
Guest Access To Internet
Network
Whiteboard
Video Conference Capability
Video Conference
Training Computers
Phone
'
Get-MailboxPermission $target | select User, AccessRights | where {$_.User -like '*GROUPHC*'}#| where {$_.user -like "*cvegad*"}

Get-Mailbox $target | select -ExpandProperty GrantSendOnBehalfTo

Get-Mailbox $target  | Get-ADPermission | where {($_.ExtendedRights -like "*Send*")} | fl user 

Get-Mailbox $target  | Get-ADPermission | where {($_.ExtendedRights -like "*Send*") -and ($_.User -like "*GROUPHC*")} 

Get-Mailbox | Get-MailboxPermission | select User, AccessRights | where {$_.User -like "*pflorian*" -and $_.AccessRights -like "*FullAccess*"}

#viac mailboxov nez userov
foreach($t in $target)
{

    Write-Output "###########################" $t "##########################" >> C:\Users\pflorian\Documents\knowledge\powershell\multiple_boxes\fullAcc_bckp.txt
    Get-MailboxPermission $t | select User, AccessRights | where {$_.User -like '*GROUPHC*'} >> C:\Users\pflorian\Documents\knowledge\powershell\multiple_boxes\fullAcc_bckp.txt

}
foreach($t in $target)
{
    Write-Output "##############################" $t "##############################" >> C:\Users\pflorian\Documents\knowledge\powershell\multiple_boxes\behalf_bckp.txt
    Get-Mailbox $t| select GrantSendOnBehalfTo -ExpandProperty GrantSendOnBehalfTo  >> C:\Users\pflorian\Documents\knowledge\powershell\multiple_boxes\behalf_bckp.txt
}
foreach($t in $target)
{
    Write-Output "##############################" $t "##############################" #>> C:\Users\pflorian\Documents\knowledge\powershell\multiple_boxes\sendas_bckp.txt
    Get-Mailbox $t  | Get-ADPermission | where {($_.ExtendedRights -like "*Send*") -and ($_.User -like "*GROUPHC*")} | select user # >> C:\Users\pflorian\Documents\knowledge\powershell\multiple_boxes\sendas_bckp.txt
}
#full acc bulk
foreach($t in $target)
{
   # Write-Output $t
    Add-MailboxPermission -Identity $t -User $usrs -AccessRights FullAccess -AutoMapping $false
}
#send on behalf sets

foreach($t in $target)
{
  #  Write-Output $t
    Set-Mailbox $t -GrantSendOnBehalfTo @{add=$usrs}
}
#send as perms
foreach($t in $target)
{
   # Write-Output $t
    Get-Mailbox $t | Add-ADPermission -User $usrs -ExtendedRights "Send As"
}


(Get-User $target).Manager #ziskaj managera
#full access
foreach($u in $usrs)
{

    Add-MailboxPermission -Identity $target -User $u -AccessRights FullAccess -AutoMapping $true
}
#send on behalf
foreach ($u in $usrs)
{
    Set-Mailbox $target -GrantSendOnBehalfTo @{add=$u}
}
#send as
foreach($u in $usrs)
{
    Get-Mailbox $target | Add-ADPermission -User $u -ExtendedRights "Send As"
}

Set-Mailbox $target -EmailAddresses @{add="k.aleksnadrova@devnyacement.bg"}
Set-Mailbox $target -EmailAddressPolicyEnabled $false
Set-Mailbox $target -WindowsEmailAddress hkgstwconferenceroom@heidelbergcement.com
Set-mailbox $target -CustomAttribute11 "NoPsmtpExport"

Set-Mailbox $target -Alias hkghoroom2

Set-ADUser $target -Replace @{info=$notes}

#television a dalsie amenities
(Get-Mailbox hkgrrlabtrainingcent).ResourceCustom
#-----------------------------------------------------

#ziskaj userov a nahadz to do array, skipny prve 3 riadky -> prazdny, samaccountname, -------------
$a=@()
Get-ADUser -Filter {company -like "*Heidelberger Beton GmbH*Region Sued-West*"} | select SamAccountName | Out-String -Stream | Select-Object -Skip 3 | ForEach-Object {$a=$a+($_.trim())}
#teraz len usernames nie stringy
$b=@()
$b=Get-ADUser -Filter {company -like "*Heidelberger Beton GmbH*Region Sued-West*"} | select SamAccountName #| Select-Object -Skip 3 #| ForEach-Object {$b=$b+($_.SamAccountName)}
#bookovat mozu len useri v poli a
Set-CalendarProcessing -Identity $target -AllBookInPolicy $false -AllRequestInPolicy $false

#nastavenie policy mnoziny - su tu useri co nemaju mailbox, alebo je v cloude
$polSe2=Get-CalendarProcessing -Identity $target | select BookInPolicy
for ($i=0;$i -lt $b.Count;$i++)
{
    $existsMailbox=[bool](Get-Mailbox $b[$i].SamAccountName -ErrorAction SilentlyContinue)
    if($existsMailbox -eq $true)
    {
        $polSe2.BookInPolicy.Add((Get-ADUser $b[$i].SamAccountName | Select-Object SamAccountName).SamAccountName)
    }
}
Set-CalendarProcessing -Identity $target -BookInPolicy $polSe2.BookInPolicy
#zoznam tych co nemaju mailbox, alebo je v cloude
$noMail=@() 
for($i=0;$i -lt $b.Count; $i++)
{
    $existsMailbox=[bool](Get-Mailbox $b[$i].SamAccountName -ErrorAction SilentlyContinue)
    if($existsMailbox -eq $false)
    {
        $noMail=$noMail+((Get-ADUser $b[$i].SamAccountName | Select-Object SamAccountName).SamAccountName)
    }
}
#-----


$Excluded = @(
"NT AUTHORITY\SELF",
"server\AdmEnterprise Servers Advance",
"server\Domain Admins",
"server\Exchange Domain Servers",
"server\Exchange Services",
"server\ExchangeAdmin",
"server\ExchangeFull",
"server\ExchangeView"
)


Get-MailboxPermission -Identity $target |
 where  { $Excluded -notcontains $_.user.tostring() -and $_.isInherited -eq $false} | select user, accessrights