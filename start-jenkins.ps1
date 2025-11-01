# PowerShell Script to Start Jenkins in Docker
# For Windows

Write-Host "===================================" -ForegroundColor Cyan
Write-Host "Jenkins Docker Setup for PetClinic" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is running
Write-Host "Checking Docker..." -ForegroundColor Yellow
try {
    docker ps | Out-Null
    Write-Host "Docker is running!" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Docker is not running!" -ForegroundColor Red
    Write-Host "Please start Docker Desktop and try again." -ForegroundColor Red
    exit 1
}

# Check if Docker Compose is available
Write-Host "Checking Docker Compose..." -ForegroundColor Yellow
try {
    docker-compose --version | Out-Null
    Write-Host "Docker Compose is available!" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Docker Compose not found!" -ForegroundColor Red
    exit 1
}

# Start Jenkins
Write-Host ""
Write-Host "Starting Jenkins container..." -ForegroundColor Yellow
docker-compose up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "Jenkins started successfully!" -ForegroundColor Green
    
    # Wait for Jenkins to initialize
    Write-Host "Waiting for Jenkins to initialize..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    
    # Get initial admin password
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Initial Admin Password:" -ForegroundColor Cyan
    Write-Host "===================================" -ForegroundColor Cyan
    
    try {
        $password = docker exec jenkins-petclinic cat /var/jenkins_home/secrets/initialAdminPassword
        Write-Host $password -ForegroundColor Yellow
    } catch {
        Write-Host "Password not available yet. Please check logs:" -ForegroundColor Yellow
        Write-Host "docker logs jenkins-petclinic" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Access Jenkins:" -ForegroundColor Cyan
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "URL: http://localhost:9090" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Cyan
    Write-Host "1. Open http://localhost:9090 in browser" -ForegroundColor White
    Write-Host "2. Enter the admin password above" -ForegroundColor White
    Write-Host "3. Install suggested plugins" -ForegroundColor White
    Write-Host "4. Create admin user" -ForegroundColor White
    Write-Host "5. Follow JENKINS_SETUP_GUIDE.md for configuration" -ForegroundColor White
    Write-Host ""
    
    # Optional: Open browser
    $response = Read-Host "Would you like to open Jenkins in browser now? (Y/N)"
    if ($response -eq 'Y' -or $response -eq 'y') {
        Start-Process "http://localhost:9090"
    }
    
} else {
    Write-Host "ERROR: Failed to start Jenkins!" -ForegroundColor Red
    Write-Host "Check Docker logs for details" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "===================================" -ForegroundColor Cyan
Write-Host "Useful Commands:" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host "View logs:      docker logs jenkins-petclinic -f" -ForegroundColor Gray
Write-Host "Stop Jenkins:   docker-compose down" -ForegroundColor Gray
Write-Host "Restart:        docker-compose restart" -ForegroundColor Gray
Write-Host "Remove all:     docker-compose down -v" -ForegroundColor Gray
Write-Host ""

