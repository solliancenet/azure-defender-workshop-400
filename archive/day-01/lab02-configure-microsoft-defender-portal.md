# Configure Microsoft Defender

## Exercise 1: Configure Advanced Features

### Task 1: Enable Microsoft Defender Endpoint Advanced Features

Enable the advanced features of Microsoft Defender.

1. Open the [Microsoft Defender Portal](https://security.microsoft.com)
2. Browse to the [Settings -> Endpoints page](https://security.microsoft.com/preferences2)
3. Under **General**, select **Advanced features**
4. Toggle all advanced feature items to the **On** position
5. Select **Save preferences**

    ![Enable Advanced Features](./media/mde_enable_advanced_features.png "Enable Advanced Features")

## Exercise 2: Microsoft Defender Indicators

In this exercise you will add [custom indicators](https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/indicator-manage?view=o365-worldwide) to your Microsoft Defender portal.

### Task 1: Create Microsoft Defender Indicators

1. Open the [Microsoft Defender Portal](https://security.microsoft.com/preferences2/onboarding)
2. Browse to the [Settings -> Endpoints](https://security.microsoft.com/preferences2/onboarding/preferences2/onboarding)
3. Select **File hashes**
4. For the file hash, type `6e2069758228e8d69f8c0a82a88ca7433a0a71076c9b1cb0d4646ba8236edf23`
5. Select **Next**
6. Select **Alert and block**
7. For the title, type **May 21 NOBELIUM Indicators**
8. For the category, seelct **Suspicious activity**
9. For the recommended action and description, type **Delete**
10. Select **Next**
11. On the scope page, select **Next**
12. Select **Save**

### Task 2: Import Microsoft Defender Indicators

1. Select **Import**
2. Select **Browse**, browse to the `./artifacts/day-01/May21NOBELIUMIoCs.csv` (you can also find it [here](https://raw.githubusercontent.com/microsoft/mstic/master/Indicators/May21-NOBELIUM/May21NOBELIUMIoCs.csv)), select **Open**
3. Select **Import**
4. Select **Done**.  You should now see ~126 new indicators loaded for the Nobelium attack artifacts.

## Exercise 3: Integrate Endpoint Management

### Task 1: Integrate Microsoft Defender for Endpoint with Endpoint Management

1. Open the end point portal
2. Select **Endpoint Security**
3. Under **Setup**, select **Microsoft Defender for Endpoint**
4. Toggle all options to **On**

    ![Enable Integration Features](./media/endpoint_mde_integration.png "Enable Integration Features")

5. Select **Save**

## Exercise 4: Network Scanner and Assessment Jobs

Microsoft Defender for Endpoints includes a network scanner utility to find any other devices that may be close to your endpoints.  Assessments can be performed to find these devices.

### Task 1: Download Network Scanner

1. Switch to the **wssecuritySUFFIX-adpdc** virtual machine
2. Open the [Microsoft Defender Portal](https://security.microsoft.com)
3. Browse to the [Settings -> Endpoints page](https://security.microsoft.com/preferences2)
4. Under **Network Assessments**, select **Assessment Jobs**
5. Select **Download scanner**
6. Start the **MdatpScanAgentSetup.msi** installer
   1. Select **Next**
   2. Select **Next**
   3. Select **Install**
   4. Select **Finish**
7. Open a web browser to `https://microsoft.com/devicelogin`
8. Enter the device code
9. Login using your lab credentials or select your account
10. Wait for the registration to complete, close the window

### Task 2: Create Assessment Job

1. Select **Create Assessment Job**
2. For the name type **domain network devices**
3. For the device, select **adpdc**
4. Enter the target range **10.0.0.0/24**
5. For the **authentication protocol**, select **Community String**
6. For the string, enter **public**
7. Select **Next**
8. Select **Run test scan**.  The agent on the `adpdc` will start to execute a network scan.  The results will be displayed on the page.

## Exercise 5: Integrate Azure Sentinel

### Task 1: Integrate Azure Sentinel

Connect the Microsoft Defender APIs to Azure Sentinel for deeper analysis

## Exercise 4: Microsoft Defender REST APIs (External SIEM)

### Task 1: Configure SIEM Integration

1. Open the [Microsoft Defender Portal](https://security.microsoft.com/preferences2/onboarding)
2. Browse to the [Settings -> Endpoints page](https://security.microsoft.com/preferences2)
3. Under **API**, select **SIEM**
4. Select **Enable SIEM connector**, you will see a new Azure AD application is created
5. Copy the Client ID and Client Secret
6. Open the Azure Portal
7. Search for **Azure Active Directory** then select it
8. Copy the tenant id from the page

### Task 2: Download Defender data

Use the Defender REST APIs to download detections.

1. Open the **/Artifacts/day-01/DefenderRestAPI.ps1** file a new Windows PowerShell ISE
2. Update the template values (tenant id, client id and client secret) you saved above
3. Press **F5** to run the script
4. Review the results

## References

- https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/pull-alerts-using-rest-api?view=o365-worldwide
- https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/exposed-apis-create-app-webapp?view=o365-worldwide
