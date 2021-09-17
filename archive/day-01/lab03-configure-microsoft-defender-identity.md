# Configure Microsoft Defender for Identity (Optional)

## Exercise 1: Install Microsoft Defender for Identity

You must first create the Identity instance and then download sensors to your domain controllers.  Once you have completed these steps, you can further integrate Microsoft Defender for Endpoint.

### Task 1: Install

1. Switch to the **wssecuritySUFFIX-adpdc** virtual machine
2. Open the Microsoft Defender for Identity Portal (https://portal.atp.azure.com/)
3. If its the first time opening the portal, select **Create**.  It should only take a few seconds.
4. Close any popup dialogs.
5. Select the **Provider a username and password** link
6. For the username, type **AD{SUFFIX}\administrator**
7. For the password, type your lab password
8. For the domain, type **AD{SUFFIX}.com**
9. Select **Save**
10. Scroll to the top of the page, select **Download Sensor Setup** link
11. Select **Download**, a zip file will download
12. Extract the zip file to `c:\temp`
13. Run the **Azure ATP Sensor Setup** installer
14. Select your language, select **Next**
15. Select **Sensor**, then select **Next**
16. Copy the access key from the portal, then paste it into the installer dialog
17. Select **Install**
18. Select **Finish**
19. The portal will refresh with your new sensor and its state.  Wait for the service to move to **Started**

### Task 2: Microsoft Defender for Endpoint Integration

1. In the Identity Portal, select **Microsoft Defender for Endpoint**
2. Toggle the integration to **On**
3. Select **Save**

### Task 3: Integration with Azure Sentinel

1. Open the Azure Portal
2. Search for and select **Azure Sentinel**
3. Select the **wssecuritySUFFIX** log anlytics workspace
4. Under **Configuration**, select **Data Connectors**
5. Select **Microsoft Defender for Identity**, then select **Open connector page**
6. Select the checkbox, then select **Connect**
7. Select **Enable**
