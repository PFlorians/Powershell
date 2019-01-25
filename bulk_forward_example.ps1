#priklad kodu => bulk forwarding emaily k ticketu: 1681831, useri boli umiestneni v ITC cloude, kde som nemal pristup
$users = "A.BADIE@suezcem.com","H.ABDELHAMEED@suezcem.com","A.ELSAID@suezcem.com","A.ELESAWY@suezcem.com","o.saleh@suezcem.com","H.HASSAN4@suezcem.com","M.MOSTAFAMONAIIAR@suezcem.com","A.SOLIMAN@suezcem.com","A.HEDAYA@suezcem.com","A.ABOSHADY@suezcem.com","H.MAHMOOD@suezcem.com","E.MOSTAFA@suezcem.com","MA.SAADELDEN@suezcem.com","M.FARGHAL@suezcem.com","A.RIZK@suezcem.com","A.ELHAMSHARY@suezcem.com","M.MOHMED@suezcem.com","A.IBRAHEM@suezcem.com","T.HASAN@suezcem.com","H.HEGAZY@suezcem.com","H.SAID@suezcem.com","B.GOMAA@suezcem.com","H.SOLIMAN@suezcem.com","A.ABDELRADY2@suezcem.com","H.ELMOGY@suezcem.com","E.ABDELKHALEK@suezcem.com","K.AHMED@suezcem.com","A.DAWY@suezcem.com"
$address = "Ahmed.Mohamed@mondigroup.com","Harby.Abdelhamid@mondigroup.com","Abdelrahman.Ahmed@mondigroup.com","Ahmed.Essawy@mondigroup.com","Saleh.Osman@mondigroup.com","Hassan.Ibrahim@mondigroup.com","Monier.Monaiiar@mondigroup.com","Ayman.Soliman@mondigroup.com","Alaaeldin.Hassan@mondigroup.com","Abdallah.Abushady@mondigroup.com","Hassan.Ali@mondigroup.com","Elhusseiny.Ali@mondigroup.com","Mahmoud.Mahmoud@mondigroup.com","Medhat.Farghal@mondigroup.com","Ayman.Abdelhakim@mondigroup.com","Ahmed.Elhamshary@mondigroup.com","Mahmoud.Ali@mondigroup.com","Ahmed.Ibrahim1@mondigroup.com","Thabet.Omara@mondigroup.com","Hussein.Hegazy@mondigroup.com","Hesham.Omran@mondigroup.com","Bassam.Aref@mondigroup.com","Hossameldin.Soliman@mondigroup.com","Ali.ABDEL-RADY@mondigroup.com","Hussien.Elmogy@mondigroup.com","Emad.Mohamed@mondigroup.com","Khaled.Ahmed@mondigroup.com","Ahmed.Dawy@mondigroup.com"

$i = 0;

foreach ($user in $users)
{
try
    {
    Get-Mailbox -Identity $user
    }
catch
    {
    Write-Host "ERROR USER NOT FOUND !" -ForegroundColor Red
    }
finally
    {#tato cast je obzvlaste zaujimava
     Set-Mailbox -Identity $user -DeliverToMailboxAndForward $true -ForwardingSMTPAddress $address[$i]
     write-host $user "--> forwards to -->" $address[$i] -ForegroundColor Green
    }
  $i++
}
