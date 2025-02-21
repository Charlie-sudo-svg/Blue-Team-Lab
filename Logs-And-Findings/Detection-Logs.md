# Detection Logs

## Splunk Log Generation Test

This document outlines the tests performed to generate logs in Splunk, including security events, system logs, and network activity.

## **1. Windows Security Event Logs**
### **Test: Failed Login Attempts**
- **Objective**: Generate failed login events in Windows Security Logs.
- **Steps**:
  1. Attempt multiple failed logins on the Windows Server.
  2. Use an incorrect password to trigger an event.
  3. Check Event Viewer under `Windows Logs > Security` for Event ID **4625**.
- **Expected Logs**:
  - Event ID `4625`: "An account failed to log on."
  - Details include username, source IP, and failure reason.

![Screenshot 2025-02-17 225734](https://github.com/user-attachments/assets/1885c285-e8fe-4a2c-8f8a-01edb0960ade)

 All I had to do was run ```` runas User:msalvas cmd.exe ```` and enter the wrong password

### Test: Add/Change Registry Values
- **Objective**: Generate Sysmon Event ID 13 by changing or adding values to the registry through powershell
- **Steps**:
  1. Open Powershell as Administrator
  2. I ran this command ```` Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Anynameyouwant" -Value "Anyvalueyouwant" -Force ````
  3. Check Event Viewer and Splunk to make sure event generated.

     ![Screenshot 2025-02-21 014234](https://github.com/user-attachments/assets/a6bf7400-1646-464f-984c-3cd9c242fe15)
