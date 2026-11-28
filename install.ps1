# AgentJail Windows 11 PowerShell Installer
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  AgentJail: Hermes Docker Sandbox Bridge for Windows 11  " -ForegroundColor Cyan
Write-Host "=========================================================="
Write-Host ""

# Check Docker running
docker info >$null 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error: Docker Desktop is not running. Please start Docker Desktop and run install.ps1 again." -ForegroundColor Red
    exit 1
}
Write-Host "✓ Docker Desktop is running" -ForegroundColor Green

# Setup host directories
$hermesDir = Join-Path $HOME ".hermes-docker"
$workspaceDir = Join-Path $HOME ".openclaw\workspace"
$binDir = Join-Path $HOME "bin"

New-Item -ItemType Directory -Force -Path $hermesDir >$null
New-Item -ItemType Directory -Force -Path $workspaceDir >$null
New-Item -ItemType Directory -Force -Path $binDir >$null

# Copy hermes-docker.cmd to ~/bin
Copy-Item -Force "hermes-docker.cmd" "$binDir\hermes-docker.cmd"
Write-Host "✓ Installed Windows bridge wrapper to $binDir\hermes-docker.cmd" -ForegroundColor Green

# Launch container if not running
$containerRunning = docker ps --format '{{.Names}}' | Select-String -Pattern '^hermes-sandbox$'
if (-not $containerRunning) {
    Write-Host "Starting hermes-sandbox container via docker compose..." -ForegroundColor Yellow
    docker compose up -d
    Start-Sleep -Seconds 5
}
Write-Host "✓ hermes-sandbox container is active" -ForegroundColor Green

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "🎉 Setup Complete!" -ForegroundColor Green
Write-Host "In Traycer: Settings -> Providers -> Hermes Agent -> Add custom path:"
Write-Host "  $binDir\hermes-docker.cmd" -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan
