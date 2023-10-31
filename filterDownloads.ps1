$newFolder = "$Home\Desktop\Downloaded Executables"
$exe = Get-ChildItem -Path $Home\Downloads | Where-Object {$_.Extension -eq ".exe"}
$image = Get-ChildItem -Path $Home\Downloads | Where-Object {$_.Extension -eq ".jpeg" -or $_.Extension -eq ".jpg" -or $_.Extension -eq ".png" -or $_.Extension -eq ".gif" -or $_.Extension -eq ".svg" }
$mp4 = Get-ChildItem -Path $Home\Downloads | Where-Object {$_.Extension -eq ".mp4" -or $_.Extension -eq ".mov"}
$mp3 = Get-ChildItem -Path $Home\Downloads | Where-Object {$_.Extension -eq ".mp3"}

New-Item -ItemType Directory -Path $newFolder -Force | Out-Null
if ($null -ne $exe){
    foreach($file in $exe){
        Write-Host $file
        Move-Item -Path "Downloads\$file" -Destination $newFolder -Force
    }
    Invoke-Item $newFolder
}
else {
    Write-Output("No files ending in '.exe' found")
}
if ($null -ne $image){
    foreach($file in $image){
        Write-Host $file
        Move-Item -Path "Downloads\$file" -Destination $Home\Pictures -Force
    }
}
else {
    Write-Output("No image files found")
}
if ($null -ne $mp4){
    foreach($file in $mp4){
        Write-Host $file
        Move-Item -Path "Downloads\$file" -Destination $Home\Videos -Force
    }
}
else {
    Write-Output("No files ending in '.mp4' found")
}
if ($null -ne $mp3){
    foreach($file in $mp3){
        Write-Host $file
        Move-Item -Path "Downloads\$file" -Destination $Home\Music -Force
    }
}
else {
    Write-Output("No files ending in '.mp3' found")
}