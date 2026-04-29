function list-apks {
    param([string]$grep = "")
    if ($grep) {
        adb shell "pm list packages -3 | sed 's/package://' | grep -i '$grep'"
    } else {
        adb shell "pm list packages -3 | sed 's/package://'"
    }
}

function pull-apks {
    param(
        [Parameter(Mandatory=$true)]
        [string]$PackageName
    )

    $paths = adb shell pm path $PackageName

    if (-not $paths) {
        Write-Host "[-] Package '$PackageName' not found on the device." -ForegroundColor Red
        return
    }

    $outDir = ".\$PackageName"
    if (-not (Test-Path $outDir)) {
        New-Item -ItemType Directory -Path $outDir | Out-Null
    }

    Write-Host "[+] Extracting APKs from '$PackageName'" -ForegroundColor Cyan

    foreach ($line in $paths) {
        $apkPath = $line -replace '^package:', '' -replace "`r", ''
        
        if (-not [string]::IsNullOrWhiteSpace($apkPath)) {
            Write-Host "-> Pulling: $apkPath"
            adb pull $apkPath $outDir
        }
    }
    
    Write-Host "[+] Complete!" -ForegroundColor Green
}

function frida-srv {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet("start", "stop")]
        [string]$Action,

        [Parameter(Position=1)]
        [string]$CustomBinaryName = "frida-server"
    )

    $path = "/data/local/tmp/$CustomBinaryName"

    if ($Action -eq "start") {
        Write-Host "[+] Starting $CustomBinaryName in background" -ForegroundColor Green
        adb shell "su -c 'chmod +x $path && nohup $path >/dev/null 2>&1 &'"
    } 
    elseif ($Action -eq "stop") {
        Write-Host "[-] Killing $CustomBinaryName..."
        adb shell "su -c 'killall -9 $CustomBinaryName 2>/dev/null'"
        Write-Host "[+] Server stopped!" -ForegroundColor DarkRed
    }
}

function get-front {
    Write-Host "[+] Frontmost App (Current Focus):" -ForegroundColor Cyan
    adb shell "dumpsys window | grep mCurrentFocus"
}