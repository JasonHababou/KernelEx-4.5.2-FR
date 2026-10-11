$rh = "C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe"   # à adapter
if (-not (Test-Path $rh)) { Write-Host "ResourceHacker.exe introuvable : $rh" -ForegroundColor Red; exit 1 }

$jobs = @(
    @{ bin = "core\Release\KernelEx.dll"; res = "core\Core-fr.res" },
    @{ bin = "apilibs\kexbases\Release\kexbases.dll"; res = "apilibs\kexbases\kexbases-fr.res" },
    @{ bin = "apilibs\kexbasen\Release\kexbasen.dll"; res = "apilibs\kexbasen\kexbasen-fr.res" },
    @{ bin = "sheet\Release\sheet.dll"; res = "sheet\sheet-fr.res" },
    @{ bin = "verify\release\verify.exe"; res = "verify\verify-fr.res" },
    @{ bin = "auxiliary\msimg32.dll"; res = "auxiliary\msimg32\msimgme-fr.res" }
)

foreach ($j in $jobs) {
    if (-not (Test-Path $j.bin)) { Write-Host "MANQUANT bin : $($j.bin)" -ForegroundColor Red; continue }
    if (-not (Test-Path $j.res)) { Write-Host "MANQUANT res : $($j.res)" -ForegroundColor Red; continue }
    python inject_resources.py $j.bin $j.res --rh $rh
    if ($LASTEXITCODE -ne 0) { Write-Host "ECHEC : $($j.bin)" -ForegroundColor Red }
}
Write-Host "Terminé. Vérifiez les fichiers *-fr.dll / *-fr.exe créés." -ForegroundColor Green