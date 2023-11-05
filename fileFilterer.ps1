
# For every directory that you want to sort through
$folderList = @("$Home\Downloads", "$Home\Documents")

# For every executable that you want organized and its destination
$extHash = @{
    "txt" = "$Home\Documents";
    "exe" = "$Home\Documents";
}





#######################################################################################################################################################################################################################################
param($debug)
if ($debug) { Write-Host " Debug Enabled`n/-------------\`n" -f Yellow }
$t = New-Module -AsCustomObject { function findFiles($x, $y, $z) {
        if (Test-Path -Path $z) {
        }
        else {
            New-Item -ItemType Directory -Path $z -Force | Out-Null
            if ($debug) { Write-Host "Created '$z' because it did not exist" -f Yellow }
        }
        foreach ($folder in $x) {
            Write-Host "Filtering: $folder" -f Blue
            $bin = Get-ChildItem -Path $folder | Where-Object { $_.Extension -eq ".$y" }
            if ($null -eq $bin) { return Write-Host "Nothing found in $folder" -f Red }
            foreach ($file in $bin) {
                if ($debug) { Write-Host "File Path:" -f Yellow $folder\$file `n }
                Write-Host $file
                Move-Item -Path $folder\$file -Destination $z -Force
                Invoke-Item $z
            }
        }
    }
}

if ($debug) { Write-Host "folderList:" $folderList -f Yellow }
if ($debug) { $extHash }

$extHash.GetEnumerator().ForEach({
        if ($debug) { Write-Host "Extension: '$($_.Key)' Will be moved to: $($_.Value)" -f Yellow }
        $t.findFiles($folderList, $($_.Key), $($_.Value))
    })

Write-Host "Done" -ForegroundColor Green
If ($debug) {Start-Sleep -Seconds 500}
