# Setup

## Install ARM Template

- Open the Azure Portal
- Create a new resource group called **PREFIX-azdefend-02**

    > **NOTE** You must use the naming convention above in order for the scripts to run properly.

- Browse to the Azure Resource group
- Select **Create**
- Search for **Template**, select **Template deployment...**
- Select **Create**
- Select **Build you own template in the editor**
- Copy the `/artifacts/environment-setup/spektra/deploy.json` template into the form
- Select **Save**
- Set the following parameters:
  - **Vm Admin Username** : `wsuser`
  - **Vm Admin Password** : `{A strong password}`

  - **Azure Username** : `{YOUR AZURE USERNAME}`
  - **Azure Password** : `{YOUR AZURE PASSWORD}`
  
  > **NOTE** You should ensure that you delete the deployment so your password is not exposed in the subscription.  This step is required as sub-scripts are executed as the azure user.  These labs were originally intended to run in a controlled environment with lab users and passwords.

  > **NOTE** Accounts with MFA enabled will not work. You should create a separate account for running the ARM template.  The account will need to be an owner of the Azure subscription to enable the Azure Defender components.

  - **Odl Id** : `12345`
  - **Deployment Id** `12345`

- Select **Review + create**
- 