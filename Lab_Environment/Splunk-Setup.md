# Splunk Setup in the Network Architecture

In this environment, **Windows Server 2022** serves a dual role:  
1. **Active Directory (AD) Domain Controller** – Manages user authentication, group policies, and other directory services.  
2. **Splunk Server** – Collects, indexes, and analyzes logs from various devices and services within the network.  

## System Configuration

- **IP Address**: `192.168.10.100/24` (static, within the internal network)  
- **Operating System**: Windows Server 2022  
- **Software Installed**:  
  - **Active Directory Domain Services (AD DS)**
  - **Splunk Enterprise**  

## Splunk Installation & Configuration

### 1. Install Splunk Enterprise
- Download and install Splunk for Windows.
- Set Splunk to run as a system service.
- Configure the Splunk admin account.

### 2. Configure Data Inputs
- Set up **Universal Forwarders** on other machines to send logs.
- Add data sources, such as:
  - Windows Event Logs
  - Syslog from network devices
  - Security logs from firewalls and IDS/IPS

### 4. Set Up Dashboards & Alerts
- Create custom dashboards for monitoring system activity.
- Configure alerts for security events.

### A few notes.... 

Just one last thing to note here as I finished setting up Splunk is I had to configure firewall rules to allow port 8000, 8089, and 9997 in Powershell. I used these commands below:

````
New-NetFirewallRule -DisplayName "Allow Splunk Web" -Direction Inbound -Protocol TCP -LocalPort 8000 -Action Allow
New-NetFirewallRule -DisplayName "Allow Splunk Forwarder" -Direction Inbound -Protocol TCP -LocalPort 9997 -Action Allow
New-NetFirewallRule -DisplayName "Allow Splunk Management" -Direction Inbound -Protocol TCP -LocalPort 8089 -Action Allow
````

### Update #1 

While using the GUI to index in Splunk, I noticed that many Sysmon fields weren’t properly populated with variables. For example, Event IDs, commands used, file paths, and registry paths didn't have proper variables attached to them. Since the whole point of using Sysmon is to properly analyze telemetry from the Windows 10 machines, this was a problem. To fix it, I installed the Splunk Add-on for Sysmon on the Windows Server 2022 machine running Splunk. This add-on allowed Splunk to properly parse Sysmon logs, assigning key data variables to their respective fields instead of requiring manual searches through raw text. 

An example is shown below:

Before:

![Screenshot 2025-02-21 014507](https://github.com/user-attachments/assets/10c62705-d8e5-4160-8e4f-a25aa6e8d197)

After:

![Screenshot 2025-02-21 020459](https://github.com/user-attachments/assets/dd7f9769-bc38-4bf6-b509-127756b32451)


Note, a wall of text is still present in both data sources for the main log, but in the second screenshot the log is more broken apart with seperate variables to match the data to.
