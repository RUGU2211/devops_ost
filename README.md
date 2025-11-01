# Spring PetClinic - Jenkins CI/CD Pipeline

This project demonstrates a complete Jenkins CI/CD pipeline setup for the Spring PetClinic application with build and test stages.

## 📋 Prerequisites

- Docker Desktop installed and running
- Jenkins running in Docker (see `docker-compose.yml`)
- Git installed

## 🚀 Quick Start

### Step 1: Start Jenkins

```bash
docker-compose up -d
```

### Step 2: Get Admin Password

```bash
docker exec jenkins-petclinic cat /var/jenkins_home/secrets/initialAdminPassword
```

### Step 3: Access Jenkins

- Open: `http://localhost:9090`
- Enter the admin password from Step 2

### Step 4: Complete Initial Setup

1. Click "Install suggested plugins"
2. Wait for plugins to install
3. Create your admin user
4. Click "Save and Continue"
5. Click "Start using Jenkins"

## 🔧 Step 5: Configure Maven and JDK in Jenkins (DETAILED)

### 5.1: Navigate to Global Tool Configuration

1. In Jenkins dashboard, click **"Manage Jenkins"** (left sidebar)
2. Scroll down and click **"Global Tool Configuration"** or **"Tools"**

### 5.2: Configure JDK

1. Scroll to the **"JDK"** section
2. Click **"Add JDK"** button
3. Fill in the following:
   - **Name**: `JDK-17` (or any name you prefer)
   - **☑ Install automatically** (checked)
   - **Version**: Click dropdown and select **"openjdk-17"**
4. Click **"Save"** at the bottom

**Alternative (if auto-install doesn't work):**
- Uncheck "Install automatically"
- **JAVA_HOME**: `/usr/lib/jvm/java-17-openjdk` (or your JDK path)

### 5.3: Configure Maven

1. Scroll to the **"Maven"** section
2. Click **"Add Maven"** button
3. Fill in the following:
   - **Name**: `Maven-3.8.6` (or any name you prefer)
   - **☑ Install automatically** (checked)
   - **Version**: Click dropdown and select **"3.8.6"**
4. Click **"Save"** at the bottom

**Alternative (if auto-install doesn't work):**
- Uncheck "Install automatically"
- **MAVEN_HOME**: `/usr/share/maven` (or your Maven path)

### 5.4: Verify Configuration

1. Go back to Jenkins dashboard
2. Click **"Manage Jenkins"** → **"Global Tool Configuration"**
3. Verify both JDK and Maven are listed
4. Confirm names match what you set (e.g., `JDK-17` and `Maven-3.8.6`)

**Common Issues:**
- **Plugin Missing**: Go to "Manage Jenkins" → "Manage Plugins" → Install "Maven Integration"
- **Download Slow**: Wait for auto-install to complete (may take 5-10 minutes)
- **Installation Fails**: Use manual path configuration instead

## 🎯 Step 6: Create Pipeline Job (DETAILED)

### 6.1: Create New Pipeline Item

1. In Jenkins dashboard, click **"New Item"** (left sidebar)
2. Enter item name: **`PetClinic-Pipeline`**
3. Select **"Pipeline"** (radio button)
4. Click **"OK"** button

### 6.2: Configure Pipeline - General Settings

1. **Description** (optional):
   ```
   Spring PetClinic CI/CD Pipeline with Build and Test stages
   ```

2. Scroll down to **"Pipeline"** section

### 6.3: Configure Pipeline - Definition

Choose **"Pipeline script from SCM"**:

1. **Definition**: Dropdown → Select **"Pipeline script from SCM"**

2. **SCM**: Dropdown → Select **"Git"**

3. **Repository URL**: 
   - If code is on GitHub/GitLab: `https://github.com/your-username/your-repo.git`
   - If local: `file:///E:/OST` (Windows) or `file:///home/user/OST` (Linux)
   - **Note**: For local, use three slashes `///` not two

4. **Credentials**: 
   - Click "Add" if you need to add Git credentials
   - For public repos or local, leave empty

5. **Branch Specifier**: 
   - `*/main` or `*/master` (depending on your default branch)

6. **Script Path**: 
   - `Jenkinsfile` (default, keep as is)

7. **Lightweight checkout**: 
   - Leave unchecked

### 6.4: Alternative - Direct Pipeline Script

**If not using Git**, you can paste the pipeline directly:

1. **Definition**: Select **"Pipeline script"**

2. **Script**: Copy and paste from `Jenkinsfile`:

```groovy
// Jenkinsfile for Spring PetClinic Application
// Scripted Pipeline with Build and Test Stages

node {
    def mavenHome = tool 'Maven-3.8.6'
    def javaHome = tool 'JDK-17'
    
    env.PATH = "${mavenHome}/bin:${javaHome}/bin:${env.PATH}"
    env.JAVA_HOME = "${javaHome}"
    env.M2_HOME = "${mavenHome}"
    
    stage('Checkout') {
        echo 'Checking out source code...'
        checkout scm
    }
    
    stage('Build') {
        echo 'Building Spring PetClinic application...'
        try {
            sh """
                mvn clean compile -DskipTests
            """
            echo 'Build completed successfully!'
        } catch (Exception e) {
            echo "Build failed: ${e.getMessage()}"
            currentBuild.result = 'FAILURE'
            throw e
        }
    }
    
    stage('Test') {
        echo 'Running tests...'
        try {
            sh """
                mvn test
            """
            echo 'All tests passed successfully!'
        } catch (Exception e) {
            echo "Tests failed: ${e.getMessage()}"
            junit 'target/surefire-reports/*.xml'
            currentBuild.result = 'FAILURE'
            throw e
        }
    }
    
    stage('Archive Artifacts') {
        echo 'Archiving build artifacts...'
        try {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            junit 'target/surefire-reports/*.xml'
            echo 'Artifacts archived successfully!'
        } catch (Exception e) {
            echo "Warning: Failed to archive artifacts: ${e.getMessage()}"
        }
    }
    
    stage('Notify') {
        echo 'Build pipeline completed!'
    }
}
```

3. Click **"Save"**

### 6.5: Run First Build

1. Click **"Build Now"** (left sidebar or "Build with Parameters")

2. You'll see a build appear in **"Build History"** (bottom left)

3. Click on the build number (#1) to view details

4. Click **"Console Output"** to see real-time logs

### 6.6: Monitor Build Progress

Watch for these stages:
- ✅ **Checkout**: Downloads source code
- ✅ **Build**: Maven compiles the application
- ✅ **Test**: Runs unit tests
- ✅ **Archive Artifacts**: Saves JAR files
- ✅ **Notify**: Build complete

**Expected Output:**
```
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] checkout
[Pipeline] stage
[Pipeline] { (Build)
[Pipeline] echo
Building Spring PetClinic application...
[Pipeline] sh
+ mvn clean compile -DskipTests
[INFO] BUILD SUCCESS
[Pipeline] stage
[Pipeline] { (Test)
[Pipeline] echo
Running tests...
[Pipeline] sh
+ mvn test
[INFO] Tests run: 2, Failures: 0, Errors: 0, Skipped: 0
[Pipeline] stage
[Pipeline] { (Archive Artifacts)
[Pipeline] archiveArtifacts
Archiving artifacts
[Pipeline] }
```

### 6.7: View Build Results

1. **Console Output**: Click build → "Console Output" to see full logs
2. **Test Results**: Click build → "Test Result" to see test reports
3. **Artifacts**: Click build → "Artifacts" to download JAR files
4. **Stage View**: On pipeline page, see visual progress

### 6.8: Troubleshooting Common Issues

**Issue 1: "Maven not found"**
```
[Pipeline] sh
mvn: command not found
```
**Solution:**
- Verify Maven is configured in Step 5
- Check name matches in Jenkinsfile (`Maven-3.8.6`)
- Reinstall: Manage Jenkins → Global Tool Configuration → Maven

**Issue 2: "JDK not found"**
```
Error: JAVA_HOME is not defined correctly.
```
**Solution:**
- Verify JDK is configured in Step 5
- Check name matches in Jenkinsfile (`JDK-17`)
- Reinstall: Manage Jenkins → Global Tool Configuration → JDK

**Issue 3: "Git not found"**
```
[Pipeline] checkout
fatal: 'git' not found
```
**Solution:**
- Install Git in Jenkins container:
  ```bash
  docker exec -u root jenkins-petclinic apt-get update
  docker exec -u root jenkins-petclinic apt-get install -y git
  ```

**Issue 4: "Permission denied"**
```
Permission denied (publickey)
```
**Solution:**
- Add SSH credentials in Jenkins
- Or use HTTPS URL with credentials
- Or use local file path for local development

**Issue 5: "Tests failing"**
```
Tests run: 2, Failures: 1
```
**Solution:**
- Click "Test Result" to see which test failed
- Check console output for error details
- Run locally: `mvn test`

**Issue 6: "No artifacts found"**
```
No artifacts found that match the file pattern "target/*.jar"
```
**Solution:**
- Ensure build succeeded
- Change directory to project root in pipeline
- Check JAR file path

## 🎉 Success Indicators

Your pipeline is working correctly when you see:
- ✅ Build shows **blue icon** (success)
- ✅ All stages show **green checkmarks**
- ✅ Test results: **All tests passed**
- ✅ Artifacts available for download
- ✅ Build duration reasonable (< 5 minutes)

## 📊 Visual Pipeline Overview

```
┌─────────┐
│ Checkout│  ← Downloads source code from Git
└────┬────┘
     ↓
┌─────────┐
│  Build  │  ← Compiles application (mvn clean compile)
└────┬────┘
     ↓
┌─────────┐
│  Test   │  ← Runs unit tests (mvn test)
└────┬────┘
     ↓
┌──────────────────┐
│ Archive Artifacts│  ← Saves JAR files and test reports
└────────┬─────────┘
         ↓
┌─────────┐
│ Notify  │  ← Build complete!
└─────────┘
```

## 🔄 Next Steps

After successful build:
1. Set up webhooks for automatic builds on Git push
2. Add email notifications
3. Configure Blue Ocean for better visualization
4. Add deployment stages
5. Set up build triggers (polling or webhooks)

## 📝 Summary Checklist

- [ ] Step 1: Jenkins started in Docker
- [ ] Step 2: Admin password obtained
- [ ] Step 3: Jenkins dashboard accessed
- [ ] Step 4: Initial setup completed
- [ ] Step 5: Maven configured (`Maven-3.8.6`)
- [ ] Step 5: JDK configured (`JDK-17`)
- [ ] Step 6: Pipeline job created
- [ ] Step 6: Pipeline configured with Jenkinsfile
- [ ] Step 6: First build executed
- [ ] Step 6: All stages passed
- [ ] Step 6: Test results verified
- [ ] Step 6: Artifacts archived

## 📚 Additional Resources

- **Jenkins Documentation**: https://www.jenkins.io/doc/
- **Pipeline Syntax**: https://www.jenkins.io/doc/book/pipeline/syntax/
- **Maven Guide**: https://maven.apache.org/guides/

---

**Your Jenkins CI/CD Pipeline is Ready! 🚀**
