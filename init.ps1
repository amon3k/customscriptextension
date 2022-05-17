#create action-runner dir
New-Item -Path "c:\" -Name "action-runner" -ItemType "directory" -ErrorAction SilentlyContinue
cd c:\action-runner
#Get release version
$release = (iwr https://api.github.com/repos/actions/runner/releases/latest | ConvertFrom-Json ).name.substring(1)
iwr -Uri "https://github.com/actions/runner/releases/download/v$release/actions-runner-win-x64-$release.zip" -OutFile "C:\action-runner\actions-runner-win-x64-$release.zip"
Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/actions-runner-win-x64-$release.zip", "$PWD")
Remove-Item c:\action-runner\actions-runner-win-x64-$release.zip -ErrorAction SilentlyContinue

Add-LocalGroupMember -Group 'docker-users' -Member 'NT AUTHORITY\NETWORK SERVICE' -ErrorAction SilentlyContinue

# $token = "AU7I3GLR6Q4PT2XHEYQTFXDCPZFOK"
# ./config.cmd --url https://github.com/msicie --token $token --runnergroup IT-Hosted-Windows --labels IT-Hosted --replace --runasservice --unattended
