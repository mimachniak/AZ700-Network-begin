---
Exercise:
    title: 'M01 - Unit 6 Configure DNS settings in Azure'
    module: 'Module 01 - Introduction to Azure Virtual Networks'
---

# M01 - Unit 6 Configure DNS settings in Azure

## Exercise scenario

In this unit, you will configure DNS name resolution for Contoso Ltd. You will create a private DNS zone named contoso.com, link the VNets for registration and resolution, and then create two virtual machines and test the configuration.

![Diagram of DNS architecture.](../media/6-exercise-configure-domain-name-servers-configuration-azure.png)

In this exercise, you will:

+ Task 1: Create a private DNS Zone
+ Task 2: Link subnet for auto registration
+ Task 3: Create Virtual Machines to test the configuration
+ Task 4: Verify records are present in the DNS zone
+ Task 5: Create Private link for storage account in network


### Estimated time: 35 minutes

## Task 1: Create a private DNS Zone

1. Go to [Azure Portal](https://portal.azure.com/).

2. On the Azure home page, in the search bar, enter dns, and then select **Private DNS zones**.  
   ‎![Azure Portal home page with dns search.](../media/create-private-dns-zone.png)

3. In Private DNS zones, select **+ Create**.

4. Use the information in the following table to create the private DNS zone.

| **Tab**         | **Option**                             | **Value**            |
| --------------- | -------------------------------------- | -------------------- |
| Basics          | Resource group                         | ContosoResourceGroup |
|                 | Name                                   | Contoso.com          |
| Tags            | No changes required                    |                      |
| Review + create | Review your settings and select Create |                      |

5. Wait until the deployment is complete, and then select **Go to resource**.

6. Verify that the zone has been created.

## Task 2: Link subnet for auto registration

1. In Contoso.com, under **Settings**, select **Virtual network links**.

2. On Contoso.com | Virtual network links, select **+ Add**.

![contoso.com | Virtual links with + Add highlighted.](../media/add-network-link-dns.png)

3. Use the information in the following table to add the virtual network link.

| **Option**                          | **Value**                               |
| ----------------------------------- | --------------------------------------- |
| Link name                           | CoreServicesVnetLink                    |
| Subscription                        | No changes required                     |
| Virtual Network                     | CoreServicesVnet (ContosoResourceGroup) |
| Enable auto registration            | Selected                                |
| Review your settings and select OK. |                                         |

4. Select **Refresh**.

5. Verify that the CoreServicesVnetLink has been created, and that auto-registration is enabled.

6. Repeat steps 2 - 5 for the ManufacturingVnet, using the information in the following table:

| **Option**                          | **Value**                                |
| ----------------------------------- | ---------------------------------------- |
| Link name                           | ManufacturingVnetLink                    |
| Subscription                        | No changes required                      |
| Virtual Network                     | ManufacturingVnet (ContosoResourceGroup) |
| Enable auto registration            | Selected                                 |
| Review your settings and select OK. |                                          |

7. Select **Refresh**.

8. Verify that the ManufacturingVnetLink has been created, and that auto-registration is enabled.

9. Repeat steps 2 - 5 for the ResearchVnet, using the information in the following table:

| **Option**                          | **Value**                           |
| ----------------------------------- | ----------------------------------- |
| Link name                           | ResearchVnetLink                    |
| Subscription                        | No changes required                 |
| Virtual Network                     | ResearchVnet (ContosoResourceGroup) |
| Enable auto registration            | Selected                            |
| Review your settings and select OK. |                                     |

10. Select **Refresh**.

11. Verify that the ResearchVnetLink has been created, and that auto-registration is enabled.


## Task 3: Verify records are present in the DNS zone

1. On the Azure Portal home page, select **Private DNS zones**.

2. On Private DNS zones, select **contoso.com**.

3. Verify that host (A) records are listed for both VMs, as shown:

![Contoso.com DNS zone showing auto-registered host A records.](../media/contoso_com-dns-zone.png)

4. Make a note of the names and IP addresses of the VMs.

### Connect to the Test VMs using RDP

1. On the Azure Portal home page, select **Virtual Machines**.

1. Select **TestVM1**.

1. On TestVM1, select **Connect &gt; RDP** and download the RDP file.

    ![TestVM1 with Connect and RDP highlighted.](../media/connect-to-am.png)

1. Save the RDP file to your desktop.

1. Follow the same steps for **TestVM2**

1. Connect to TestVM1 using the RDP file, and the username **TestUser** and the password you provided during deployment.

1. Connect to TestVM2 using the RDP file, and the username **TestUser** and the password you provided during deployment.

1. On both VMs, in **Choose privacy settings for your device**, select **Accept**.

1. On both VMs, if prompted, in **Networks**, select **Yes**.

1. On TestVM1, open a command prompt and enter the command ipconfig /all.

1. Verify that the IP address is the same as the one you noted in the DNS zone.

1. Enter the command ping TestVM2.contoso.com.

1. Verify that the FQDN resolves to the IP address that you noted in the Private DNS zone. The ping itself will timeout because of the Windows Firewall that is enabled on the VMs.

1. Alternatively, you can enter the command nslookup TestVM2.contoso.com and verify that you receive a successful name resolution record for VM2

Congratulations! You have created a private DNS Zone, added a name resolution and auto-registration link, and tested name resolution in your configuration.

## Task 5: Create Private link for storage account in network

1. Go to [Azure Portal](https://portal.azure.com/).

2. On the Azure home page, in the search bar, enter dns, and then select **Strorage accoout**.  
   ‎![Azure Portal home page with storage accont search.](../media/01-PRIVATE.png)

3. In Storage account, select **+ Create**.
4. Select subscription.
5. Select resource group .
6. Enter Name: **stazrze${{Studnet Number}}**.
7. Select region: **East US**.
8. Performance: **Standard**.
9. Redundancy: **Locally-redundant storage (LRS)**.
10. **Review and Create**.
11. When deployment finished go to storage account.
12. Navigate to **Networking**.
13. Click on **Private endpoints connections** and **Private endpoint**.
14. Select subscription.
15. Select resource group.
16. Name: **PrivateEndpointST${{Studnet Number}}**.
17. Select region: **East US**.
18. Target sub-resource: **file**.
19. Select Virtual Network: **CoreServicesVnet**.
20. Select Subnet: **PublicWebServiceSubnet**.
21. Go Next to DNS.
21. Next review and create.
22. Select **TestVM1**.

23. On TestVM1, select **Connect &gt; RDP** and download the RDP file.

    ![TestVM1 with Connect and RDP highlighted.](../media/connect-to-am.png)

24. Save the RDP file to your desktop.

25. Follow the same steps for **TestVM2**

26. Connect to TestVM1 using the RDP file, and the username **TestUser** and the password you provided during deployment.
27. Check that blob endpoint answer on public IP and file use Private IP
```powershell

PS C:\Users\godmode> ping stazrze.blob.core.windows.net

Pinging blob.blz21prdstr17a.store.core.windows.net [20.60.220.36] with 32 bytes of data:

PS C:\Users\godmode> ping stazrze.file.core.windows.net

Pinging stazrze.privatelink.file.core.windows.net [10.0.1.5] with 32 bytes of data:

```