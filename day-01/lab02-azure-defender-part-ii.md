# Microsoft Defender for Cloud Setup : Lab 2 : Execute Microsoft Defender for Cloud Protections

## Exercise 1: VM Vulnerability Assessments

### Task 1: VM Vulnerability

1. Switch to the Azure Portal.

2. In the global search for and select the **Security Center**

3. Under **Cloud Security**, select **Workload protections**

    ![Select the workload protections link.](./media/asc_workload_protections.png "Select the workload protections link")

4. Scroll down, under **Advanced protection**, select **VM vulnerability assessment**

    ![Select VM Vulnerability Assessments.](./media/asc_vm_vulnerability.png "Select VM Vulnerability Assessments")

5. Select the checkbox to select all the virtual machines

    ![Select all VMs.](./media/vm_vulnerability_vms.png "Select all VMs")

6. Select **Fix**

    ![Select the Qualsys agent.](./media/vm_vulnerability_agent.png "Select the Qualsys agent")

7. Select **Proceed**

8. In the dialog, select **Fix 6 resources**

  > **Note** After a few hours (up to 12), the agent will be installed on all selected machines and the assessment data will start to flow into the Security Center.

## Exercise 2: SQL Vulnerability Assessments

### Task 1: SQL Vulnerability

1. Switch to the Azure Portal and browse to your resource group

2. Browse to the **wssecuritySUFFIX** Azure Database for SQL instance

3. Under **Security**, select **Microsoft Defender for Cloud**, if you see **Enable Azure Defender for SQL**, select it. After a few minutes, you should see the recommendations and security alerts for the single SQL resource (if any).

    ![Enable security.](./media/sql_vulnerability_enable.png "Enable security")

4. Refresh the page, select the **(Configure)** link

    ![Select the configure link.](./media/sql_vulnerability_configure.png "Select the configure link")

5. Select the **Select storage account** link
  
    ![Select the storage account link.](./media/sql_vulnerability_storage_account.png "Select the storage account link")

6. Change the storage account to the **wssecuritySUFFIX** storage account

7. Toggle the periodic recurring checkbox to **On**

8. Set the email to the lab user email

9. Select the **Enable Auditing for better threats investigation experience** link

    ![Select the link.](./media/sql_vulnerability_storage_auditing.png "Select the link")

10. Toggle the **Enable Azure SQL Auditing** to **On**

11. Select **Log Analytics** checkbox

12. Select the **wssecuritySUFFIX** log analytics workspace

13. Toggle the **Enable Auditing of Microsoft support operations** to **On**

    ![Configure auditing.](./media/sql_vulnerability_storage_auditing_config.png "Configure auditing")

14. Again, select the **Log Analytics** checkbox, then select the lab subscription and the **wssecuritySUFFIX** workspace

15. Select **Save**

16. In the breadcrumb, select **Server settings**

17. Select **Save** again

18. Navigate to the **wssecuritySUFFIX** Azure Database for SQL server.

19. Under **Settings**, select **Databases**

20. Select the **Insurance** database

21. Under **Security**, select **Microsoft Defender for Cloud**

22. Select **View additional findings in Vulnerability Assessment**

23. Select **Scan**

    ![Select Scan.](./media/sql-vulnerability-scan.png "Select Scan")

24. In the Azure Portal, open **Security Center**

25. Under **Cloud Security**, select **Workload Protections**

26. Scroll to the bottom, select **SQL Vulnerability Assessment**, after a few minutes, you should see all servers across the subscription displayed.

    ![Scan results.](./media/sql-vulnerability-scan-results.png "Scan results")

## Exercise 3: File Integrity Monitoring

### Task 1: File Integrity Monitoring

1. Navigate back to the Security Center

2. In the blade menu, under **Cloud Security**, select **Workload protections**

3. Scroll to the bottom and select **File Integrity Monitoring**.

4. Select the **wssecuritySUFFIX** log workspace. If displayed, select **Upgrade Plan**

   ![Update the workspace.](./media/securitycenter-fileintegrity-upgrade.png "Upgrade the workspace")

   1. Select **Try File Integrity Monitoring**.

   2. Select the workspace only, then select **Upgrade**.

   3. Select the **Continue without installing agents** link.

      ![The continue without installing agents link is highlighted.](./media/fileintegrity-enable.png "Select the continue without installing agents link")

   4. If displayed, select **Enable**, then select **Enable File Integrity Monitoring**. If not displayed, simply select the workspace.

      > **NOTE** This can take some time, but is typically within a few minutes

   5. Refresh the File Integrity Monitoring page
  
5. In the menu, select **Settings**.

    ![The Settings link is highlighted.](./media/fileintegrity-settings.png "Select the settings link")

6. Select the **Windows Files** tab.
7. Select **+Add**.

    ![Add windows item.](./media/fileintegrity-windows.png "Add windows item")

8. For the item name, type **HOSTS**.
9. For the path, type **c:\windows\system32\drivers\etc\\\***
10. For the path type, select **Folder**
11. Toggle **Recursion** to **On**
12. Toggle **Upload file content** to **True**
13. Select **Save**.

    ![The settings page is displayed with the links highlighted.](./media/fileintegrity-addentry.png "Add a new file integrity monitoring item")

14. Select the **File Content** tab.
15. Select **Link**, then select the **wssecuritySUFFIX** storage account tied to your lab.

    > **NOTE** It will take 15-30 minutes for Log Analytics and its management packs to execute on all your VMs. As you may not have that much time with this lab, screen shots are provided as to what results you will eventually get.

    ![The file content page is displayed with the links highlighted.](./media/fileintegrity-filecontent.png "Link a storage account for file changes")

16. Select **Save**
17. Switch to the Remote Desktop Connection to the **wssecuritySUFFIX-paw-1**.
18. Open **Event Viewer**.
19. Expand the **Applications and Services Logs**, then select **Operations Manager**.
20. Right-click **Operations Manager**, select **Filter Current Log**.
21. Wait for a new event with the event id of **5001** to be displayed.
22. Open the **c:\windows\system32\drivers\etc\hosts** file.
23. Add the following entry:

    ```cmd
    10.0.0.6    linux-2
    ```

24. Save the file.
25. After about 15-30 minutes, the Log Analytics workspace will start to pickup changes to your files, registry settings and windows services.
    - Switch to your **wssecuritySUFFIX** Log Analytics workspace
    - Under **General**, select **Logs**
    - Run the following query:

    ```output
    ConfigurationChange
    | where Computer == "paw-1"
    | where ConfigChangeType in("Files", "Registry")
    | order by TimeGenerated
    | render table
    ```

    ![The file changes are saved to the logs of the workspace.](./media/fileintegrity-logchanges.png "Review the file change logs for the paw-1 machine in the log analytics workspace")

26. You will also start to see the file snapshots show up in the storage account.  Browse to the **wssecuritySUFFIX** storage, then select **changetrackingblob** container, then select the folder that matches the machine name:

    ![The file changes are displayed in the storage account.](./media/fileintegrity-snapshots.png "The file changes are displayed in the storage account")

### Task 2: File Integrity Monitoring Automation

1. Browse to the **wssecuritySUFFIX** automation account
2. Under **Configuration Management**, select **Change tracking**
3. In the **Change Types** drop down filter, select **Files**

    ![Select Files change type.](./media/fileintegrity-automation-changetracking.png "Select Files change type.")

4. Select the **HOSTS** file, in the dialog, review the file changes

    ![The file changes are displayed.](./media/automation_change_tracking_hosts_change.png "The file changes are displayed.")

    > **NOTE** It may take a few minutes for the changes to be displayed. You can continue on to the next set of labs and come back to check on the results later in the day.

## Reference Links

- [Adaptive Application Controls](https://docs.microsoft.com/en-us/azure/security-center/security-center-adaptive-application)
- [File Integrity Monitoring](https://docs.microsoft.com/en-us/azure/security-center/security-center-file-integrity-monitoring)
