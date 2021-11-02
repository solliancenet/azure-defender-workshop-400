Param (
  [Parameter(Mandatory = $true)]
  [string]
  $azureUsername,

  [string]
  $azurePassword,

  [string]
  $azureTenantID,

  [string]
  $azureSubscriptionID,

  [string]
  $odlId,
    
  [string]
  $deploymentId
)

#Disable-InternetExplorerESC
function DisableInternetExplorerESC
{
  $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
  $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
  Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force -ErrorAction SilentlyContinue -Verbose
  Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force -ErrorAction SilentlyContinue -Verbose
  Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green -Verbose
}

#Enable-InternetExplorer File Download
function EnableIEFileDownload
{
  $HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
  $HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
  Set-ItemProperty -Path $HKLM -Name "1803" -Value 0 -ErrorAction SilentlyContinue -Verbose
  Set-ItemProperty -Path $HKCU -Name "1803" -Value 0 -ErrorAction SilentlyContinue -Verbose
  Set-ItemProperty -Path $HKLM -Name "1604" -Value 0 -ErrorAction SilentlyContinue -Verbose
  Set-ItemProperty -Path $HKCU -Name "1604" -Value 0 -ErrorAction SilentlyContinue -Verbose
}

#Create-LabFilesDirectory
function CreateLabFilesDirectory
{
  New-Item -ItemType directory -Path C:\LabFiles -force
}

#Create Azure Credential File on Desktop
function CreateCredFile($azureUsername, $azurePassword, $azureTenantID, $azureSubscriptionID, $deploymentId)
{
  $WebClient = New-Object System.Net.WebClient
  $WebClient.DownloadFile("https://raw.githubusercontent.com/solliancenet/azure-synapse-analytics-workshop-400/master/artifacts/environment-setup/spektra/AzureCreds.txt","C:\LabFiles\AzureCreds.txt")
  $WebClient.DownloadFile("https://raw.githubusercontent.com/solliancenet/azure-synapse-analytics-workshop-400/master/artifacts/environment-setup/spektra/AzureCreds.ps1","C:\LabFiles\AzureCreds.ps1")

  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "ClientIdValue", ""} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "AzureUserNameValue", "$azureUsername"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "AzurePasswordValue", "$azurePassword"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "AzureSQLPasswordValue", "$azurePassword"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "AzureTenantIDValue", "$azureTenantID"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "AzureSubscriptionIDValue", "$azureSubscriptionID"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "DeploymentIDValue", "$deploymentId"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"               
  (Get-Content -Path "C:\LabFiles\AzureCreds.txt") | ForEach-Object {$_ -Replace "ODLIDValue", "$odlId"} | Set-Content -Path "C:\LabFiles\AzureCreds.txt"  
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "ClientIdValue", ""} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "AzureUserNameValue", "$azureUsername"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "AzurePasswordValue", "$azurePassword"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "AzureSQLPasswordValue", "$azurePassword"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "AzureTenantIDValue", "$azureTenantID"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "AzureSubscriptionIDValue", "$azureSubscriptionID"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "DeploymentIDValue", "$deploymentId"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  (Get-Content -Path "C:\LabFiles\AzureCreds.ps1") | ForEach-Object {$_ -Replace "ODLIDValue", "$odlId"} | Set-Content -Path "C:\LabFiles\AzureCreds.ps1"
  Copy-Item "C:\LabFiles\AzureCreds.txt" -Destination "C:\Users\Public\Desktop"
}

Start-Transcript -Path C:\WindowsAzure\Logs\CloudLabsCustomScriptExtension.txt -Append

[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls" 

mkdir "c:\temp" -ea SilentlyContinue;
mkdir "c:\labfiles" -ea SilentlyContinue;

#download the solliance pacakage
$WebClient = New-Object System.Net.WebClient;
$WebClient.DownloadFile("https://raw.githubusercontent.com/solliancenet/common-workshop/main/scripts/common.ps1","C:\LabFiles\common.ps1")
$WebClient.DownloadFile("https://raw.githubusercontent.com/solliancenet/common-workshop/main/scripts/httphelper.ps1","C:\LabFiles\httphelper.ps1")
$WebClient.DownloadFile("https://raw.githubusercontent.com/solliancenet/common-workshop/main/scripts/rundeployment.ps1","C:\LabFiles\rundeployment.ps1")

#run the solliance package
. C:\LabFiles\Common.ps1
. C:\LabFiles\HttpHelper.ps1

Set-Executionpolicy unrestricted -force

DisableInternetExplorerESC

EnableIEFileDownload

InstallChocolaty

InstallNotepadPP

InstallAzPowerShellModule

InstallGit

InstallChrome
        
InstallAzureCli

#InstallVisualStudio

#InstallVisualStudioCode

InstallTor

EnableDarkMode

Uninstall-AzureRm -ea SilentlyContinue

CreateLabFilesDirectory

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

cd "c:\labfiles";

CreateCredFile $azureUsername $azurePassword $azureTenantID $azureSubscriptionID $deploymentId $odlId

. C:\LabFiles\AzureCreds.ps1

$userName = $AzureUserName                # READ FROM FILE
$password = $AzurePassword                # READ FROM FILE
$clientId = $TokenGeneratorClientId       # READ FROM FILE
$global:sqlPassword = $AzureSQLPassword          # READ FROM FILE

$securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $userName, $SecurePassword

Connect-AzAccount -Credential $cred | Out-Null

#download the git repo...
Write-Host "Download Git repo." -ForegroundColor Green -Verbose

git clone https://github.com/solliancenet/azure-defender-workshop-400.git

# Template deployment
$rg = Get-AzResourceGroup | Where-Object { $_.ResourceGroupName -like "*-security" };
$resourceGroupName = $rg.ResourceGroupName
$deploymentId =  (Get-AzResourceGroup -Name $resourceGroupName).Tags["DeploymentId"]

$branch = "main";
$workshopName = "azure-defender-workshop-400";
$repoUrl = "solliancenet/$workshopName";

$templatesFile = "c:\labfiles\azure-defender-workshop-400\artifacts\environment-setup\automation\00-template.json";
$parametersFile = "c:\labfiles\azure-defender-workshop-400\artifacts\environment-setup\spektra\deploy.parameters.post.json"
$content = Get-Content -Path $parametersFile -raw;

$content = $content.Replace("GET-AZUSER-PASSWORD",$azurepassword);
$content = $content | ForEach-Object {$_ -Replace "GET-AZUSER-UPN", "$AzureUsername"};
$content = $content | ForEach-Object {$_ -Replace "GET-ODL-ID", "$deploymentId"};
$content = $content | ForEach-Object {$_ -Replace "GET-DEPLOYMENT-ID", "$deploymentId"};
$content = $content | ForEach-Object {$_ -Replace "GET-REGION", "$($rg.location)"};
$content = $content | ForEach-Object {$_ -Replace "ARTIFACTS-LOCATION", "https://raw.githubusercontent.com/$repoUrl/$branch/artifacts/environment-setup/automation/"};
$content | Set-Content -Path "$($parametersFile).json";

Write-Host "Executing main ARM deployment" -ForegroundColor Green -Verbose

#OLD WAY...
#New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templatesFile -TemplateParameterFile "$($parametersFile).json";

#will fire deployment async so the main deployment shows "succeeded"
ExecuteDeployment $templatesFile "$($parametersFile).json" $resourceGroupName;
 
cd './azure-defender-workshop-400/artifacts/environment-setup/automation'

#upload the bacpac file...
$bacpacFilename = "Insurance.bacpac"

# The ip address range that you want to allow to access your server
$startip = "0.0.0.0"
$endip = "0.0.0.0"

$resourceName = "wssecurity" + $deploymentId;
$storageAccountName = $resourceName;
$serverName = $resourceName;
$storageContainerName = "sqlimport";
$databaseName = "Insurance";

WaitForResource $resourceGroupName $resourceName "Microsoft.Storage/storageAccounts " 1500;

$storageKey = $(Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Value[0];
$context = $(New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageKey);

$storageContainer = New-AzStorageContainer -Name $storageContainerName -Permission Container -Context $context;

Set-AzStorageBlobContent -Container $storagecontainername -File $bacpacFilename -Context $context

#create a share
$shareName = "users";

New-AzRmStorageShare -ResourceGroupName $resourceGroupName -StorageAccountName $storageAccountName -Name $shareName -EnabledProtocol SMB -QuotaGiB 1024;

$user = Get-AzADUser -UserPrincipalName $userName;

WaitForResource $resourceGroupName $resourceName "Microsoft.Sql/servers" 1500;

Set-AzSqlServerActiveDirectoryAdministrator -ResourceGroupName $resourceGroupName -ServerName $serverName -DisplayName $user.DisplayName -ObjectId $user.Id;

#allow azure
$serverFirewallRule = New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName -ServerName $serverName -AllowAllAzureIPs

#WaitForResource $resourceGroupName $resourceName "Microsoft.Sql/databases" 1000;

#deploy the bacpac file...
$importRequest = New-AzSqlDatabaseImport -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -DatabaseName $databaseName `
    -DatabaseMaxSizeBytes 100GB `
    -StorageKeyType "StorageAccessKey" `
    -StorageKey $(Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -StorageAccountName $storageAccountName).Value[0] `
    -StorageUri "https://$storageaccountname.blob.core.windows.net/$storageContainerName/$bacpacFilename" `
    -Edition "Standard" `
    -ServiceObjectiveName "S3" `
    -AdministratorLogin "wsuser" `
    -AdministratorLoginPassword $(ConvertTo-SecureString -String $password -AsPlainText -Force)

#execute setup scripts
Write-Host "Executing post scripts." -ForegroundColor Green -Verbose

sleep 20

Stop-Transcript