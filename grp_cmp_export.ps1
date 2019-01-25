#porovnanie skupin, 

$a=Compare-Object -ReferenceObject $(Get-Content C:\Users\pflorian\Documents\knowledge\powershell\access_1759912\stvergel.txt) -DifferenceObject $(Get-Content C:\Users\pflorian\Documents\knowledge\powershell\access_1759912\rodartoi.txt) | where {$_.SideIndicator -like "=>"} | select InputObject 
#dynamicky array list

#$b=[System.Collections.ArrayList]@() 
$b=%{$a} | %{ "{0,-10}" -f $_.InputObject} #odstranenie vrchu toho stlpca

#vystup do suboru aj s description
for ($i=0;$i -lt $b.count;$i++)
{
    $v='*'+$b[$i].trim()+'*'
    $tmp=Get-ADGroup -Filter {name -like $v} -Properties * | select Name, Description | fl | Out-String
    $tmp=$tmp.Trim() + "`n"
    Out-File -FilePath C:\Users\pflorian\Documents\knowledge\powershell\access_1759912\grps_descr.txt -InputObject $tmp -Append
}

#sources:
#https://stackoverflow.com/questions/1408042/output-data-with-no-column-headings-using-powershell
#https://stackoverflow.com/questions/35272003/what-does-key1-mean
#