Get-WmiObject -Query "select * from win32_service where name like '%vmware%'" -ComputerName sdoterminal -Credential GROUPHC\pafloria | fl -Property Name, ExitCode, ProcessID, StartMode, State, Status

https://docs.microsoft.com/en-us/windows/desktop/cimwin32prov/win32-service