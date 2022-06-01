$appDir = "/vagrant_data"

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

Function addToPathPermanent {
    Param($pathToAdd)
    Write-Host "running addToPathPermanent :: $pathToAdd"
    [Environment]::SetEnvironmentVariable(
    "Path",
    "$pathToAdd;" + [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine),
    [EnvironmentVariableTarget]::Machine)
    refreshenv
    Write-Host "new path is $env:Path"
}
cd $appDir

Write-Host "running in $pwd"
# Write-Host "uninstalling possibly broken packages"
# choco uninstall openjdk
Write-Host "installing dependencies"
choco install cygwin visualstudio2017community vcredist2017 visualstudio2017-workload-nativegame -y 

# Write-Host "installing git"
# choco install git.install -version 1.9.5.20150114 -y

Write-Host "installing specific version of java"
choco install openjdk --version 16.0.2 --allow-downgrade -y
$defaultOpenJdkInstallDir = "C:\Program Files\OpenJdk";
$bootJavaPath = (ls $defaultOpenJdkInstallDir)

addToPathPermanent $defaultOpenJdkInstallDir

Write-Host "--- configuring cygwin ---"
Write-Host "adding cygwin binaries to path"
addToPathPermanent "C:\tools\cygwin\bin"
Write-Host "running post installation cygwin scripts"
refreshenv
$cygwinDir = "C:\tools\cygwin"
cd $cygwinDir
# this installator doesnt block by default, Start-Process allows makes sure this finishes before script goes forward, but sadly we don't see the output of it
Write-Host "installing cygwin packages, this might take more than 2 minutes"
Start-Process -wait .\cygwinsetup.exe -ArgumentList  "-q -P make,gcc-g++,find,unzip,zip,gcc-tools-automake,automake,gcc-tools-autoconf,autoconf"
refreshenv
# Write-Host "installing cygwin packages, but in cygwin context, this might take more than 2 minutes"
# Start-Process -wait bash -ArgumentList "-c ./cygwinsetup.exe -q -P make,gcc-g++,find,unzip,zip,gcc-tools-automake,automake,gcc-tools-autoconf,autoconf"

cd $appDir



Write-Host "refreshing env"
refreshenv


Write-Host "--- packages installed succesfully ---"
