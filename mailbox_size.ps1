#mailbox storage quota
$user="nil";
Get-Mailbox $user | fl IssueWarningQuota,ProhibitSendQuota,ProhibitSendReceiveQuota,UseDatabaseQuotaDefaults

Set-Mailbox -Identity $user -IssueWarningQuota 768000kb -ProhibitSendQuota 1024000kb -ProhibitSendReceiveQuota 2560000kb -UseDatabaseQuotaDefaults $false