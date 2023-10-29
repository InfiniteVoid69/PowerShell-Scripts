$newFolder = "$Home\Desktop\Downloaded Executables"
$downloads = "$HOME\Downloads"
$bin = Get-ChildItem -Path $downloads | Where-Object {$_.name -match ".exe"}
New-Item -ItemType Directory -Path $newFolder -Force | Out-Null
foreach($file in $bin){
    Write-Host $file
    Move-Item -Path "Downloads\$file" -Destination $newFolder -Force
}
Invoke-Item $newFolder
