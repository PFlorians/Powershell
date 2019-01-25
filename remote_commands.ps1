#WMI, remote control commands and sessions on servers
#list classes: 
get-cimclass | select cimclassname, cimclassmethods, cimclassproperties 
#vypis properties/methods/whatever z classy
([wmiclass]"Win32_NetworkAdapterConfiguration").Properties | select name

#pusti vystup z niektorej classy na local PC
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Property Caption, IPAddress, IPSubnet, macaddress | select caption, ipaddress, ipsubnet, macaddress

#pouzitim wsql
Get-WmiObject -Query "select * from Win32_NetworkAdapterConfiguration where index =16" #toto radsej nepouzivat, neda sa odfiltrovat kazda property

#1. sposob remote code execution, da sa aj local path script v code block
Invoke-Command -ComputerName deusaheid060 -Credential grouphc\pafloria -ScriptBlock {
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Property Caption, IPAddress, IPSubnet, macaddress | select caption, ipaddress, ipsubnet, macaddress |
where {$_.ipaddress -notlike ""}
}

#2. sposob built in session
Get-WmiObject -ComputerName DEUXTHEIDAS01 -Credential grouphc\pafloria -Class Win32_NetworkAdapterConfiguration -Property Caption, IPAddress, IPSubnet, macaddress `
| select caption, ipaddress, ipsubnet, macaddress | where {$_.ipaddress -notlike ""}