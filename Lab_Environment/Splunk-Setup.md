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
