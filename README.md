# Spring PetClinic - Jenkins CI/CD Pipeline

This project demonstrates a complete Jenkins CI/CD pipeline setup for the Spring PetClinic application with build and test stages.

## 📋 Project Overview

This repository contains:
- Spring PetClinic application (Spring Boot)
- **Jenkinsfile** (Scripted Pipeline) for Jenkins automation
- **Jenkinsfile.Declarative** (Declarative Pipeline alternative)
- Complete Jenkins setup documentation
- Maven build configuration

## 🏗️ Project Structure

```
OST/
├── Jenkinsfile                      # Scripted Pipeline (Main)
├── Jenkinsfile.Declarative          # Declarative Pipeline Alternative
├── docker-compose.yml               # Docker Compose configuration
├── start-jenkins.ps1               # Windows PowerShell start script
├── start-jenkins.sh                # Linux/Mac start script
├── pom.xml                          # Maven build configuration
├── src/
│   ├── main/java/org/springframework/samples/petclinic/
│   │   └── PetclinicApplication.java
│   └── test/java/org/springframework/samples/petclinic/
│       └── PetclinicApplicationTests.java
├── docker-configs/
│   └── maven-settings.xml          # Maven settings for Docker
├── README.md                        # This file
├── DOCKER_SETUP_GUIDE.md           # Docker Jenkins setup guide
├── JENKINS_SETUP_GUIDE.md          # Manual Jenkins setup guide
├── JENKINS_QUICK_REFERENCE.md      # Quick reference guide
└── PROBLEM_STATEMENT_SOLUTION.md   # Complete solution overview
```

## 🚀 Quick Start

### Prerequisites

1. **Docker** (Recommended) or Manual Installation
   - Docker Desktop for Windows/Mac: https://www.docker.com/products/docker-desktop
   - Docker Engine for Linux: https://docs.docker.com/engine/install/

2. **Git**
   ```bash
   git --version
   ```

### Option 1: Docker Setup (Recommended) 🐳

**Quickest way to get started!**

1. **Start Jenkins**
   ```bash
   # Windows
   .\start-jenkins.ps1
   
   # Linux/Mac
   chmod +x start-jenkins.sh
   ./start-jenkins.sh
   
   # Or use Docker Compose directly
   docker-compose up -d
   ```

2. **Get Admin Password**
   ```bash
   docker exec jenkins-petclinic cat /var/jenkins_home/secrets/initialAdminPassword
   ```

3. **Access Jenkins**
   - Open: `http://localhost:9090` (changed from 8080 to avoid port conflicts)
   - Enter admin password
   - Install suggested plugins
   - Create admin user

**See `DOCKER_SETUP_GUIDE.md` for detailed instructions**

### Option 2: Manual Installation

1. **Java JDK 11+**
   ```bash
   java -version  # Should show 11 or higher
   ```

2. **Maven 3.6+**
   ```bash
   mvn -version  # Should show 3.6 or higher
   ```

3. **Jenkins 2.400+**
   - Download from: https://jenkins.io/download/
   - Run: `java -jar jenkins.war --httpPort=8080`

**See `JENKINS_SETUP_GUIDE.md` for detailed instructions**

### Local Build (Without Jenkins)

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd OST
   ```

2. **Build the application**
   ```bash
   mvn clean compile
   ```

3. **Run tests**
   ```bash
   mvn test
   ```

4. **Package application**
   ```bash
   mvn package
   ```

5. **Run application**
   ```bash
   java -jar target/spring-petclinic-2.7.0.jar
   ```

6. **Access application**
   - Open browser: `http://localhost:8080`

## 🔧 Jenkins Setup

### Docker Setup (Recommended) 🐳
For Docker-based Jenkins installation, see **[DOCKER_SETUP_GUIDE.md](DOCKER_SETUP_GUIDE.md)**

### Manual Setup
For manual Jenkins installation, see **[JENKINS_SETUP_GUIDE.md](JENKINS_SETUP_GUIDE.md)**

### Quick Setup Summary

1. **Access Jenkins Dashboard**
   - Start Jenkins: `java -jar jenkins.war --httpPort=8080`
   - Open: `http://localhost:8080`
   - Complete initial setup

2. **Configure Tools**
   - Go to: `Manage Jenkins` → `Global Tool Configuration`
   - Add Maven: `Maven-3.8.6`
   - Add JDK: `JDK-17` or `JDK-11`

3. **Create Pipeline**
   - Click `New Item`
   - Name: `PetClinic-Pipeline`
   - Type: `Pipeline`
   - Configure: Use `Jenkinsfile` from SCM

4. **Build**
   - Click `Build Now`
   - Monitor progress in Stage View

## 📊 Pipeline Stages

The Jenkins pipeline includes the following stages:

### 1. Checkout Stage
- Clones/fetches source code from Git repository

### 2. Build Stage
- Runs `mvn clean compile` to compile the application
- Skips tests for faster compilation

### 3. Test Stage
- Runs `mvn test` to execute all unit tests
- Generates test reports in JUnit format

### 4. Archive Artifacts Stage
- Archives compiled JAR files
- Publishes test results
- Creates build artifacts for deployment

### 5. Notify Stage
- Sends notifications on build completion
- Can be extended with email/Slack integration

## 📝 Jenkinsfile Variants

### Scripted Pipeline (`Jenkinsfile`)
- More flexible and programmatic
- Better for complex logic
- Uses Groovy scripting

**Usage:**
```groovy
node {
    stage('Build') { ... }
    stage('Test') { ... }
}
```

### Declarative Pipeline (`Jenkinsfile.Declarative`)
- Simpler syntax
- Opinionated structure
- More readable for beginners

**Usage:**
```groovy
pipeline {
    agent any
    stages {
        stage('Build') { ... }
    }
}
```

## 🎯 Problem Statement Solutions

This project addresses all requirements:

| Requirement | Solution | File |
|------------|----------|------|
| 1. Accessing Jenkins dashboard and configuring Maven | Complete setup guide | `JENKINS_SETUP_GUIDE.md` Section 1-2 |
| 2. Creation of first build job | FreeStyle project guide | `JENKINS_SETUP_GUIDE.md` Section 3 |
| 3. Developing delivery pipeline (Build & Test) | Pipeline with 2 stages | `Jenkinsfile.Declarative` |
| 4. Transforming to scripted pipeline | Full scripted version | `Jenkinsfile` |
| 5. Developing Jenkinsfile for application | Both variants provided | `Jenkinsfile`, `Jenkinsfile.Declarative` |

## 🧪 Testing

### Unit Tests
```bash
mvn test
```

### Integration Tests
```bash
mvn integration-test
```

### View Test Reports
- After Jenkins build: `target/surefire-reports/`
- In Jenkins: Pipeline → Test Results

## 📦 Build Artifacts

Build produces:
- **JAR File**: `target/spring-petclinic-2.7.0.jar`
- **Test Reports**: `target/surefire-reports/*.xml`
- **Source JAR**: `target/spring-petclinic-2.7.0-sources.jar`

Artifacts are automatically archived in Jenkins.

## 🔍 Monitoring and Logs

### In Jenkins Dashboard
1. **Console Output**: Real-time build logs
2. **Stage View**: Visual pipeline progress
3. **Blue Ocean**: Modern pipeline visualization
4. **Test Results**: JUnit test report

### Common Commands
```bash
# View Jenkins logs (Linux)
tail -f /var/log/jenkins/jenkins.log

# View build console output via CLI
curl http://localhost:8080/job/PetClinic-Pipeline/lastBuild/consoleText

# Check build status
curl http://localhost:8080/job/PetClinic-Pipeline/lastBuild/api/json
```

## 🛠️ Troubleshooting

### Common Issues

**Issue**: Maven not found
```bash
# Solution: Configure Maven in Jenkins Global Tool Configuration
Manage Jenkins → Global Tool Configuration → Maven
```

**Issue**: Java version mismatch
```bash
# Solution: Ensure Java 11+ is installed and configured
java -version  # Verify version
# Update Jenkins JDK configuration
```

**Issue**: Tests failing
```bash
# Solution: Run tests locally first
mvn clean test
# Check test logs for errors
cat target/surefire-reports/*.txt
```

**Issue**: Git connection errors
```bash
# Solution: Add Git credentials in Jenkins
Manage Jenkins → Manage Credentials
# Or use file:/// protocol for local repositories
```

## 📚 Additional Resources

- **Jenkins Documentation**: https://www.jenkins.io/doc/
- **Pipeline Syntax**: https://www.jenkins.io/doc/book/pipeline/syntax/
- **Spring Boot**: https://spring.io/projects/spring-boot
- **Maven Guide**: https://maven.apache.org/guides/

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-feature`
3. Make changes and test with: `mvn clean test`
4. Commit changes: `git commit -m "Add new feature"`
5. Push to branch: `git push origin feature/new-feature`
6. Create Pull Request

## 📄 License

This project is for educational purposes as part of the Spring PetClinic tutorial.

## 🎓 Learning Objectives

After completing this setup, you will understand:
- ✅ Jenkins dashboard navigation
- ✅ Maven configuration in Jenkins
- ✅ Creating build jobs (FreeStyle and Pipeline)
- ✅ Implementing CI/CD pipelines
- ✅ Scripted vs Declarative pipelines
- ✅ Jenkinsfile development
- ✅ Build automation
- ✅ Test automation
- ✅ Artifact management

## 📞 Support

For issues or questions:
1. Check `JENKINS_SETUP_GUIDE.md` for detailed steps
2. Review Jenkins logs for errors
3. Verify Maven and Java installation
4. Check pipeline syntax in Jenkinsfile

---

**Happy Building! 🚀**

#   d e v o p s _ o s t  
 