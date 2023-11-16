#---------------------------------------------------------[Initialisations]--------------------------------------------------------
param($debug)
$folderList = @() #directories that you want to filter through
$extHash = @{} #Extensions and where you want them to go; EX: "txt" = "$Home\Documents"
if ($debug) {Write-Host " /-------------\`n Debug Enabled`n \-------------/`n" -f Yellow}

#---------------------------------------------------------[Checks]--------------------------------------------------------
if (no) { return Write-Host "Canceled" -f Red }
if ($folderList.Count -eq 0 ) {return Write-Host "Folder List Cannot be empty" -f Red}
if ($extHash.Count -eq 0 ) {return Write-Host "Extensions Cannot be empty" -f Red}
if ($debug) {Write-Host "Debug: folderList:" $folderList -f Yellow}
if ($debug) {$extHash}

#---------------------------------------------------------[Functions]--------------------------------------------------------

$t = New-Module -AsCustomObject{ function findFiles($x,$y,$z) {
if (Test-Path -Path $z) {
}else {
New-Item -ItemType Directory -Path $z -Force | Out-Null
if ($debug) {Write-Host "Debug: Created '$z' because it did not exist" -f Yellow }
}
foreach ($folder in $x) {
Write-Host "Filtering: $folder" -f Blue
$bin = Get-ChildItem -Path $folder | Where-Object {$_.Extension -eq ".$y"}
if ($null -eq $bin){ return Write-Host "Nothing found in $folder" -f Red}
foreach ($file in $bin) {
if ($debug) {Write-Host "Debug:`nFile Found:" -f Yellow $folder\$file `n}
Write-Host $file
Move-Item -Path $folder\$file -Destination $z -Force
Invoke-Item $z
}
}
}
}
$extHash.GetEnumerator().ForEach({
if ($debug) {Write-Host "Debug:`nExtension: '$($_.Key)' Will be moved to: $($_.Value)" -f Yellow}
$t.findFiles($folderList, $($_.Key), $($_.Value))
})

Write-Host "Done" -ForegroundColor Green
if ($debug) { Start-Sleep -Seconds 500}
