# Windows Server Active Directory Configuration

## Overview
This document outlines the configuration steps for setting up Active Directory (AD) on a Windows Server. It includes creating Organizational Units (OUs) for `Sales` and `Management`, as well as applying Group Policy Objects (GPOs) to enforce security and management policies.

## Steps

### 1. Install Active Directory Domain Services (AD DS)
```powershell
# Install AD DS Role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Promote Server to a Domain Controller
Install-ADDSForest -DomainName "company.local"
```

### 2. Create Organizational Units (OUs)
```powershell
# Create Sales OU
New-ADOrganizationalUnit -Name "Sales" 

# Create Management OU
New-ADOrganizationalUnit -Name "Management" 
```


### 4. Configure GPO Settings

#### Sales & Management GPO 
- Enforce Password History (7 passwords)
- Max Password Age (60 days)
- Min Password Age (7 days)
- Complex Password Requirements Enabled
- Account Lockout Duration (30 minutes)
- Account Lockout Threshold (5 attempts)

I also enforced auditing policies aswell

- Audit Logon Events
- Audit Account Management

I played around with a few more policies but none are relevent to the security aspects of this project.

#### 5. Setting up File Shares 

I created a file called ```Project_Files``` and shared it over the network and added the permissions as follows:

MSalvas (Management): Read/Write

CPaley (Sales): Read

## Conclusion
This configuration sets up a structured AD environment with separate OUs for `Sales` and `Management`, each having its own tailored policies. Further customization can be done based on company security policies.
