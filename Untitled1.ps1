foreach($log in $logy) 
{
    Get-CalendarDiagnosticAnalysis -CalendarLogs $log -DetailLevel Advanced > "C:\Users\pflorian\Documents\knowledge\powershell\usairving room1551 calendar analysis\analyza"+$count+".html"
    $count+=1
}
$count=0
foreach($log in $logy) 
{
    $tmp=Get-CalendarDiagnosticLog -Identity Patrik.Florians@heidelbergcement.com -MeetingID $log.CleanGlobalObjectId
    $tmp1=Get-CalendarDiagnosticLog -Identity usarrirvgcr1551@heidelbergcement.com -MeetingID 040000008200E00074C5B7101A82E00800000000C0A3FE31392FD401000000000000000010000000B9AF782D8508954AB1DC88E43AFE6CA7
    Get-CalendarDiagnosticAnalysis -CalendarLogs $tmp1 -DetailLevel Advanced> "C:\Users\pflorian\Documents\knowledge\powershell\usairving room1551 calendar analysis\analyza"+$count+".html"
    $count+=1
}