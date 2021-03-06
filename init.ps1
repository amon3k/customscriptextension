$appId = 195636
$privateKeyFile = 'jvx437-packages-test-195636.pem'

#create action-runner dir
Write-Output "Create action-runner dir"
New-Item -Path "c:\" -Name "action-runner" -ItemType "directory" -ErrorAction SilentlyContinue
$runnerDir = "C:\action-runner"

Write-Output "Get release version"
$release = (iwr https://api.github.com/repos/actions/runner/releases/latest -UseBasicParsing | ConvertFrom-Json ).name.substring(1)

Write-Output "Downloads runner package"
#iwr -Uri "https://github.com/actions/runner/releases/download/v$release/actions-runner-win-x64-$release.zip" -OutFile "$runnerDir\actions-runner-win-x64-$release.zip" -UseBasicParsing
#iwr -Uri "https://sweetaibstorage.blob.core.windows.net/runner-win/actions-runner-win-x64-2.291.1.zip?sp=r&st=2022-05-17T09:20:46Z&se=2022-05-22T17:20:46Z&spr=https&sv=2020-08-04&sr=b&sig=fkGU9RqU7ey0Mn0CtkLNNimgoMg2C6dkze3TB%2BjqUQg%3D" -OutFile "$runnerDir\actions-runner-win-x64-$release.zip" -UseBasicParsing
Write-Output "Unzip runner package"
#Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$runnerDir\actions-runner-win-x64-$release.zip", "$runnerDir")
#Remove-Item $runnerDir\actions-runner-win-x64-$release.zip -ErrorAction SilentlyContinue

#Write-Output "Download test package"
#iwr -Uri "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-large-zip-file.zip" -OutFile "C:\action-runner\sample-large-zip-file.zip"

Write-Output "Add NETWORK SERVICE to the docker group"
Add-LocalGroupMember -Group 'docker-users' -Member 'NT AUTHORITY\NETWORK SERVICE' -ErrorAction SilentlyContinue

docker run --rm jvx437/ghtoken generate --base64_key $privateKeyB64 --app_id 195636

Write-Output "Configure & run GitHub runner service"
# $token = "AU7I3GLR6Q4PT2XHEYQTFXDCPZFOK"
# .\config.cmd --url https://github.com/msicie --token $token --runnergroup IT-Hosted-Windows --labels IT-Hosted --replace --runasservice --unattended
Write-Output "Done"
