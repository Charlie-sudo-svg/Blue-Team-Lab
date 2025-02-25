# Define known malicious indicators
# I dropped the file extension from the processes or it wouldn't detect otherwise
$MaliciousProcesses = @(
    "malware", "ransomware", "keylogger",
    "cryptominer", "backdoor", "trojan",
    "adware", "botnet", "exploit", "hacker", 
    "Meterpreter"
)  
$MaliciousIPs = @("192.168.10.35")

# VirusTotal API Key (replace with your own)
$VirusTotalAPIKey = "YOUR_VIRUSTOTAL_API_KEY"

# Function to check file hash against VirusTotal
Function Check-VirusTotal {
    param (
        [string]$FileHash
    )

    # VirusTotal API URL
    $url = "https://www.virustotal.com/api/v3/files/$FileHash"

    # Make the request to VirusTotal
    try {
        $headers = @{
            "x-apikey" = $VirusTotalAPIKey
        }

        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get

        # If the file is found in VirusTotal
        if ($response.data) {
            $positiveHits = $response.data.attributes.last_analysis_stats.malicious
            if ($positiveHits -gt 0) {
                Write-Host "WARNING: File is malicious! $FileHash flagged by $positiveHits engines." -ForegroundColor Red
            } else {
                Write-Host "File is clean: $FileHash" -ForegroundColor Green
            }
        } else {
            Write-Host "File not found in VirusTotal database: $FileHash" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error querying VirusTotal: $_" -ForegroundColor Red
    }
}

# Function to get file hash (MD5)
Function Get-FileHashMD5 {
    param ($FilePath)
    if ($FilePath -and (Test-Path $FilePath)) {   # Ensure FilePath is not null before checking
        return (Get-FileHash -Path $FilePath -Algorithm MD5).Hash
    }
    return $null
}

# Get running processes
$Processes = Get-Process | ForEach-Object {
    try {
        $ProcPath = $_.Path  # Try getting the process path
    } catch {
        $ProcPath = $null  # If access is denied or unavailable, set to null
    }

    # Return process with path (if available)
    [PSCustomObject]@{
        Name = $_.Name
        PID = $_.Id
        Path = $ProcPath
    }
}

# Check for malicious processes
foreach ($proc in $Processes) {
    if ($proc.Name -in $MaliciousProcesses) {
        Write-Host "WARNING: Suspicious process detected -> $($proc.Name) (PID: $($proc.PID))" -ForegroundColor Red
    }

    # Check if the file hash is malicious
    if ($proc.Path) {
        $fileHash = Get-FileHashMD5 -FilePath $proc.Path
        if ($fileHash) {
            Check-VirusTotal -FileHash $fileHash
        }
    }
}

# Check network connections for bad IPs
$Connections = Get-NetTCPConnection | Where-Object { $_.State -eq "Established" }
foreach ($conn in $Connections) {
    if ($MaliciousIPs -contains $conn.RemoteAddress) {
        Write-Host "ALERT: Process with PID $($conn.OwningProcess) is connecting to malicious IP: $($conn.RemoteAddress)" -ForegroundColor Red
    }
}

Write-Host "Scan complete." -ForegroundColor Green
