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
 
**Why is Event ID 4625 important?** Event ID 4625 is important because large amounts of this event could potentially indicate a brute force attack in which a bad actor tries to access a system by using a large database of well known passwords.

![Screenshot 2025-02-17 225734](https://github.com/user-attachments/assets/1885c285-e8fe-4a2c-8f8a-01edb0960ade)
##### Screenshot of Event ID 4625 log in Splunk.

 All I had to do was run ```` runas User:msalvas cmd.exe ```` and enter the wrong password

### Test: Add/Change Registry Values
- **Objective**: Generate Sysmon Event ID 13 by changing or adding values to the registry through powershell
- **Steps**:
  1. Open Powershell as Administrator
  2. I ran this command ```` Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Anynameyouwant" -Value "Anyvalueyouwant" -Force ````
  3. Check Event Viewer and Splunk to make sure event generated.

**Why is Event ID 13 important?** Event ID 13 is important because hackers commonly change around configurations in the regsitry to maintain persistence by changing configurations or hiding malicious scripts in the registry.

![Screenshot 2025-02-21 020459](https://github.com/user-attachments/assets/974c540f-d8a5-476e-bc33-f8b00ba55e34)
##### Screenshot of Event ID 13 log in Splunk.

### Test: Creating/Adding New FIles
- **Objective**: Generate Sysmon Event ID 11 by creating  a .exe file.
- **Steps**:
    1. Opened Notepad as Administrator
    2. Write anything in the notepad and saved as ````newfile.exe````
    3. Check Splunk to make sure Event ID 11 got generated

**Why is Event ID 11 Important?** Event ID 11 is important because it tracks when and where a file is created on a system. Attackers often drop malicious files, especially executables (.EXE) to establish persistence, execute payloads, or escalate privileges. Monitoring this event helps detect suspicious activity, such as unauthorized file creation in sensitive directories.

![Screenshot 2025-02-22 134040](https://github.com/user-attachments/assets/36da92cd-12c9-4032-ae02-b673b3a0a6f3)
##### Screenshot of Event ID 11 log in Splunk.
