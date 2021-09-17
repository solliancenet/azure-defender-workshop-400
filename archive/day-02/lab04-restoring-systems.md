# Restoring Systems

## Exercise 1: Restore with Azure Backup

### Task 1: Restore a System with Azure Backup

After detecting the threat, you must now get back to a valid server state.  You can use the Azure Backups you took in the first lab to restore back to a known good state.

1. Open Azure Portal
2. Browse to the Recovery Services Vault
3. Under **Protected Items**, select **Backup items**
4. Select the **Azure Virtual Machine** node
5. Select the **wssecuritySUFFIX-paw-1** virtual machine
6. Select **Restore**
7. Select **Restore VM**

## Exercise 2: Restore Azure Storage

### Task 1: Restore Azure Storage

Utilize the Recovery Services Vault to recover an encryption File Share.

1. Browse to the Recovery Services Vault
2. Under **Protected Items**, select **Backup items**
3. Select the **Azure Storage (Azure Files)** node
4. Select the **users** file share
5. Select **Restore Share**
6. For the restore point, select the **Select** link
7. Select the last restore point
8. Select **Restore**

## Exercise 3: Restore Azure Database for SQL

### Task 1: Restore Azure Database for SQL

Perform the following steps to restore a corrupted database.

1. Browse to the **wssecuritySUFFIX** SQL Server
2. Select **Backups**
3. Select the **Insurance** database, then select **Restore**
4. Select **Point-in-time**
5. Select sometime at the end of the first day
6. Select **Review + create**
7. Select **Create**

## Exercise 4: Restore with OneDrive for Business

### Task 1: Restore Files with OneDrive

Perform the following steps to restore your OneDrive for Business.

1. Switch to the **wssecuritySUFFIX-paw-1** machine
2. Open OneDrive for Business
3. Right-click the **OneDrive for Business** icon in task area
4. Select **View Online**
5. Login using your lab username and password
6. Select the settings cog in the top right corner, then select **Restore your OneDrive**
7. For the date, select **Yesterday**
8. Select **Restore**

## References

- https://techcommunity.microsoft.com/t5/microsoft-onedrive-blog/onedrive-files-restore-and-windows-defender-takes-ransomware/ba-p/188001