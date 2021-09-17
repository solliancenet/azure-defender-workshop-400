#update all data to today's date

function UpdateFile($fileName, $tokens)
{
    $content = Get-Content $fileName -raw

    if ($content)
    {
        foreach($key in $tokens.keys)
        {
            $content = $content.replace($key,$tokens[$key]);
        }
    }

    Set-Content $fileName $content;
}

$workshopName = "azure-defender-workshop-400";

cd C:\LabFiles\"#IN_WORKSHOP_NAME#"\artifacts

$ht = new-object System.Collections.Hashtable;
$ht.add("#TODAY#",[DateTime]::NOW.ToString("yyyy-MM-dd"));
$ht.add("#TOMORROW#",[DateTime]::NOW.AddDays(1).ToString("yyyy-MM-dd"));
$ht.add("#YESTERDAY#",[DateTime]::NOW.AddDays(-1).ToString("yyyy-MM-dd"));
$ht.add("#TWODAYSAGO#",[DateTime]::NOW.AddDays(-2).ToString("yyyy-MM-dd"));
$ht.add("#TIMESTAMP#",[DateTime]::NOW.tostring("yyyy-MM-dd HH:MM:SS"));
$ht.add("#USERNAME#", "#IN_USERNAME#");
$ht.add("#PASSWORD#", "#IN_PASSWORD#");
$ht.add("#WORKSPACE_NAME#", "#IN_WORKSPACE_NAME#");
$ht.add("#STORAGE_ACCOUNT_NAME#", "#IN_STORAGE_ACCOUNT_NAME#");
$ht.add("#WORKSPACE_ID#", "#IN_WORKSPACE_ID#");
$ht.add("#WORKSPACE_KEY#", "#IN_WORKSPACE_KEY#");
$ht.add("#SUBSCRIPTION_ID#", "#IN_SUBSCRIPTION_ID#");
$ht.add("#RESOURCE_GROUP_NAME#", "#IN_RESOURCE_GROUP_NAME#");
$ht.add("#DEPLOYMENT_ID#", "#IN_DEPLOYMENT_ID#");
$ht.add("#WAF_IP#", "#IN_WAF_IP#");
$ht.add("#APP_SVC_URL#", "#IN_APP_SVC_URL#");
$ht.add("#IP_1#", "203.160.71.100"); #china
$ht.add("#IP_2#", "80.89.137.214"); #russia
$ht.add("#IP_3#", "117.82.191.160"); #china
$ht.add("#WORKSHOP_NAME#", "#IN_WORKSHOP_NAME#");

UpdateFile "./day-02/powershell-attack.ps1" $ht;

