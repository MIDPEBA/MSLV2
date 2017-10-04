$in = Get-Content $triggerInput -Raw | ConvertFrom-Json

#Write-Output "PowerShell script processed queue message '$in'"

Connect-PnPOnline -Url "https://onmidroc.sharepoint.com/teams/SC000898" -AppId 79a6a8d6-d94e-4c87-bce4-9ccaff8082fe -AppSecret $env:AppSecret
$myList = Get-PnPList -Identity myList
Write-Output $myList.title
Add-PnPListItem -List myList -Values @{"Title" = $in.name} -ContentType "Item"
Disconnect-PnPOnline

$entity = [PSObject]@{
  PartitionKey = "test"  
  RowKey = get-date -Format "yyyy-MM-dd H:m:s.ms"
  Name= $in.name
}

$entity | ConvertTo-Json | Out-File -Encoding UTF8 $outputTable