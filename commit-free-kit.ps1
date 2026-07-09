# Commit + push the free-kit signup wiring (site + README)
# Run from: C:\Users\selva\Documents\Github\forge-skill-pack-free
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
git add index.html README.md
git commit -m "Add free starter kit signup section (site + README) -> Gumroad $0 lead magnet"
git push
Write-Host "Pushed. Vercel will redeploy tools.prepbrix.com in ~30s." -ForegroundColor Green
