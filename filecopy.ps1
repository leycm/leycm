param(
    [string]$zielOrdner = "$env:USERPROFILE\Pictures\Handy"
)


$quellOrdner = @(
    "Dieser PC\Galaxy S23 Ultra\Interner Speicher\DCIM\Camera",
    "Dieser PC\Galaxy S23 Ultra\Interner Speicher\WhatsApp\Media\WhatsApp Images",
    "Dieser PC\Galaxy S23 Ultra\Interner Speicher\DCIM\Screenshots"
)

if (!(Test-Path $zielOrdner)) {
    New-Item -ItemType Directory -Path $zielOrdner | Out-Null
}

$bildEndungen = @("*.png", "*.jpg", "*.jpeg", "*.jpng")
$alleBilder = @()

foreach ($ordner in $quellOrdner) {
    if (Test-Path $ordner) {
        foreach ($ext in $bildEndungen) {
            $alleBilder += Get-ChildItem -Path $ordner -Filter $ext -File -ErrorAction SilentlyContinue
        }
    } else {
        Write-Host "⚠ Ordner nicht gefunden: $ordner"
    }
}

$total = $alleBilder.Count

if ($total -eq 0) {
    Write-Host "Keine Bilder gefunden. Übertragung abgebrochen."
    Start-Sleep -Seconds 3
    exit
}

Write-Host "$total Bilder gefunden. Starte Übertragung..."
Start-Sleep -Seconds 1

function Show-ProgressBar {
    param (
        [int]$progress
    )
    $width = $Host.UI.RawUI.WindowSize.Width - 15  
    if ($width -lt 20) { $width = 20 }
    
    $filled = " " * (($width * $progress) / 100)  
    $empty = " " * ($width - $filled.Length)      
    
    Write-Host -NoNewline "`r[" -BackgroundColor Green -ForegroundColor Black
    Write-Host -NoNewline "$filled" -BackgroundColor Green
    Write-Host -NoNewline "$empty" -BackgroundColor DarkGray
    Write-Host "] $progress% "
}

$counter = 0
foreach ($bild in $alleBilder) {
    $counter++
    $prozent = [math]::Round(($counter / $total) * 100)
    
    Clear-Host
    Write-Host "Bilder übertragen..."
    Show-ProgressBar -progress $prozent
    Write-Host "Datei: $($bild.Name)"
    
    Copy-Item -Path $bild.FullName -Destination $zielOrdner -Force
}

Write-Host "`nAlle Bilder wurden erfolgreich übertragen!"
Start-Sleep -Seconds 3
