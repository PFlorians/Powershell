$LiveCred = Get-Credential -Credential "pafloria@grouphc.net"
$SessionOpt = New-PSSessionOption -SkipCACheck:$true -SkipCNCheck:$true -SkipRevocationCheck:$true
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://DEUSEFRAN1504/powershell/ -Credential $LiveCred -AllowRedirection -SessionOption $SessionOpt 
Import-PSSession $Session


Remove-PSSession $Session