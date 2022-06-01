$appDir = "/vagrant_data"
cd $appDir

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
Write-Host "--- validating install ---"

bash -c "where java"
bash -c "where bash"
bash -c "where autoconf"

Write-Host "--- preparing java  for compilation ---"
bash -c "./configure"
