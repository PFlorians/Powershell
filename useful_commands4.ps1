$rooms='USA Room, Irving - Conference Room 1501',
'USA Room, Change Mgmt (Irving)',
'USA Room, Irving - Conference Room 1534',
'USA Room, PMO Conference (Irving)',
'USA Room, SMALL (Irving)',
'USA Room, Produce to Stock (Irving)',
'USA Room, Purchase to Pay (Irving)'

$rooms | %{Get-ADUser -Filter {name -like $_}} | select samaccountname