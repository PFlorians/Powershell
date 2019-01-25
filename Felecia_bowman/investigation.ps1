Get-Mailbox -OrganizationalUnit "OU=NA,DC=grouphc,DC=net" -ResultSize Unlimited | Get-MailboxPermission -User fbowman -ResultSize Unlimited #hladanie pre spravneho usera
#send on behalf for previous
Get-Mailbox -OrganizationalUnit "OU=NA,DC=grouphc,DC=net" -ResultSize Unlimited | Get-MailboxPermission -User fbowman -ResultSize Unlimited | Get-Mailbox | select GrantSendOnBehalfTo
#send as na tom s ktorym bol problem obsahuje "bfelicia" upravene na fbowman
Get-Mailbox dmailbox   | Get-ADPermission | where {($_.ExtendedRights -like "*Send*")} | select user