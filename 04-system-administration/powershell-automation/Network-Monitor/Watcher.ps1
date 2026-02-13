# Watcher - Network Connection Monitoring
clear

# Get current network connections
$connections = netstat -abno

# Filter to only established connections
$activeConnections = $connections | Select-String "ESTABLISHED"

# Define suspicious indicatiors
$suspiciousPorts = @("4444", "1337", "31337", "5555", "6666", "6667", "23", "21")
$suspiciousProcesses = @("nc.exe", "ncat.exe", "netcat.exe", "telnet.exe", "powershell.exe")

Write-Host "=====Watcher=====" -ForegroundColor Cyan
Write-Host "Scanning at: $(Get-Date)"
Write-Host ""

# Analyze each connection
foreach ($connection in $activeConnections) {
    $isSuspicious = $false
    $reason = @()

    # Check for suspicious ports
    foreach ($port in $suspiciousPorts) {
        if ($connection -match ":$port") {
            $isSuspicious = $true
            $reason += "Suspicious port: $port"
        }
    }

    # Check for suspicious processes
    foreach ($process in $suspiciousProcesses) {
        if ($connection -match $process) {
            $isSuspicious = $true
            $reason += "Suspicious process: $process"
        }
    }

    # Report findings
    if ($isSuspicious) {
        Write-Host "⚠ ALERT: Suspicious connection detected!" -ForegroundColor Red
        Write-Host "Connection: $connection"
        Write-Host "Reason: $($reason -join ', ')"
        Write-Host "----------------------------------------"
    }
}

#log findings
$logPath = "D:\CyberSecurity\Cisco Cybersecurity Essentials\scripts"

# Create log filename with timestamp
$logFile = "$logPath\connections_$(Get-Date -Format 'yyyy-MM-dd_HH-mm').txt"

# Save full results
$report = @"
=========================================
CONNECTION WATCHDOG REPORT
Generated: $(Get-Date)
Computer: $env:COMPUTERNAME
User: $env:USERNAME
=========================================

ACTIVE CONNECTIONS:
$($activeConnections -join "`n")

=========================================
ALERTS GENERATED:
$alerts
=========================================
"@

$report | Out-File -FilePath $logFile
Write-Host "Report saved to: $logFile" -ForegroundColor Green