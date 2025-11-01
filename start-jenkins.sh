#!/bin/bash
# Shell Script to Start Jenkins in Docker
# For Linux/Mac

echo "==================================="
echo "Jenkins Docker Setup for PetClinic"
echo "==================================="
echo ""

# Check if Docker is running
echo "Checking Docker..."
if ! docker ps &> /dev/null; then
    echo "ERROR: Docker is not running!"
    echo "Please start Docker and try again."
    exit 1
fi
echo "Docker is running!"

# Check if Docker Compose is available
echo "Checking Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    echo "ERROR: Docker Compose not found!"
    exit 1
fi
echo "Docker Compose is available!"

# Start Jenkins
echo ""
echo "Starting Jenkins container..."
docker-compose up -d

if [ $? -eq 0 ]; then
    echo "Jenkins started successfully!"
    
    # Wait for Jenkins to initialize
    echo "Waiting for Jenkins to initialize..."
    sleep 10
    
    # Get initial admin password
    echo ""
    echo "==================================="
    echo "Initial Admin Password:"
    echo "==================================="
    
    PASSWORD=$(docker exec jenkins-petclinic cat /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null)
    if [ -n "$PASSWORD" ]; then
        echo "$PASSWORD"
    else
        echo "Password not available yet. Please check logs:"
        echo "docker logs jenkins-petclinic"
    fi
    
    echo ""
    echo "==================================="
    echo "Access Jenkins:"
    echo "==================================="
    echo "URL: http://localhost:9090"
    echo ""
    echo "Next Steps:"
    echo "1. Open http://localhost:9090 in browser"
    echo "2. Enter the admin password above"
    echo "3. Install suggested plugins"
    echo "4. Create admin user"
    echo "5. Follow JENKINS_SETUP_GUIDE.md for configuration"
    echo ""
    
    # Optional: Open browser (Linux with xdg-open, Mac with open)
    read -p "Would you like to open Jenkins in browser now? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v xdg-open &> /dev/null; then
            xdg-open "http://localhost:9090"  # Linux
        elif command -v open &> /dev/null; then
            open "http://localhost:9090"  # Mac
        fi
    fi
    
else
    echo "ERROR: Failed to start Jenkins!"
    echo "Check Docker logs for details"
    exit 1
fi

echo ""
echo "==================================="
echo "Useful Commands:"
echo "==================================="
echo "View logs:      docker logs jenkins-petclinic -f"
echo "Stop Jenkins:   docker-compose down"
echo "Restart:        docker-compose restart"
echo "Remove all:     docker-compose down -v"
echo ""

# Make script executable
chmod +x start-jenkins.sh

