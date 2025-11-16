$ErrorActionPreference = "SilentlyContinue"

Write-Host "--- 🖥️  SİSTEM RAPORU ---" -ForegroundColor Yellow


$computerName = $env:COMPUTERNAME
$userName = $env:USERNAME
Write-Host "Bilgisayar Adi:`t" -NoNewLine -ForegroundColor Cyan
Write-Host "$computerName"
Write-Host "Kullanici Adi:`t" -NoNewLine -ForegroundColor Cyan
Write-Host "$userName"



$ip = (Test-Connection -ComputerName $computerName -Count 1).IPv4Address
Write-Host "Yerel IP Adresi:`t" -NoNewLine -ForegroundColor Cyan
Write-Host "$ip"



$os = Get-CimInstance -ClassName Win32_OperatingSystem
$uptime = (Get-Date) - $os.LastBootUpTime
$uptimeString = "$($uptime.Days) gun, $($uptime.Hours) saat, $($uptime.Minutes) dakika"
Write-Host "Calisma suresi:`t" -NoNewLine -ForegroundColor Cyan
Write-Host "$uptimeString"



Write-Host "CPU Sıcaklığı:`t" -NoNewLine -ForegroundColor Cyan

$temp = Get-CimInstance -Namespace "root\WMI" -ClassName "MSAcpi_ThermalZoneTemperature" | Select-Object -First 1

if ($temp) {
   
    $cpuTemp = ($temp.CurrentTemperature / 10) - 273.15
    $cpuTempFormatted = [math]::Round($cpuTemp, 1)
    Write-Host "$cpuTempFormatted °C" -ForegroundColor Green
} else {
    Write-Host "sicaklik sensörleri okunamadı." -ForegroundColor Red
}
Write-Host "---------------------------"



$totalRam = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
$freeRam = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
$usedRam = $totalRam - $freeRam
Write-Host "RAM kullanimi:" -ForegroundColor Cyan
Write-Host "Toplam: `t$totalRam GB"
Write-Host "Kullanilan:`t$usedRam GB" -ForegroundColor Red
Write-Host "Bosta: `t$freeRam GB" -ForegroundColor Green
Write-Host "" 


Write-Host "En Çok RAM Kullanan 3 islem:" -ForegroundColor Cyan
Get-Process | Sort-Object -Property WS -Descending | Select-Object -First 3 | Format-Table -Property Name, @{Name="RAM (MB)"; Expression={[math]::Round($_.WS / 1MB, 2)}} -AutoSize
Write-Host "---------------------------"



$disk = Get-PSDrive C
$totalDisk = [math]::Round($disk.Size / 1GB, 2)
$freeDisk = [math]::Round($disk.Free / 1GB, 2)
$usedDisk = $totalDisk - $freeDisk
$percentFree = [math]::Round(($freeDisk / $totalDisk) * 100, 0)

Write-Host "Disk Kullanimi (C:):" -ForegroundColor Cyan
Write-Host "Toplam: `t$totalDisk GB"
Write-Host "Kullanilan:`t$usedDisk GB"
Write-Host "Bosta: `t$freeDisk GB (%$percentFree bosta)" -ForegroundColor Green


$barLength = 20 
$usedBlocks = [math]::Round(($usedDisk / $totalDisk) * $barLength)
$freeBlocks = $barLength - $usedBlocks
$bar = ("#" * $usedBlocks) + ("-" * $freeBlocks)
Write-Host "[$bar]" -ForegroundColor Yellow

Write-Host "--- RAPOR TAMAMLANDI ---" -ForegroundColor Yellow