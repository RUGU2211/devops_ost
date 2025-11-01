# 🎯 Step-by-Step Jenkins Pipeline Setup Guide

This guide provides detailed instructions for setting up Jenkins CI/CD pipeline for Spring PetClinic.

---

## 📋 Prerequisites Checklist

Before starting, ensure you have:
- [x] Docker Desktop installed
- [x] Git installed
- [x] Jenkins container running

**Check Jenkins is running:**
```bash
docker ps | grep jenkins-petclinic
```

---

## 🚀 STEP 1-4: Quick Setup (Already Done)

These steps are already completed:
- ✅ Jenkins started: `docker-compose up -d`
- ✅ Password obtained
- ✅ Jenkins accessed at `http://localhost:9090`
- ✅ Initial setup completed

---

## 🔧 STEP 5: Configure Maven and JDK (DETAILED)

### Visual Guide: Navigate to Configuration

```
Jenkins Dashboard
    ↓
[Manage Jenkins] ← Click this button
    ↓
[Global Tool Configuration] ← Click this link
    ↓
Scroll down to find JDK and Maven sections
```

### Step 5.1: Configure JDK

#### 5.1.1: Add JDK Installation
```
JDK Section:
┌─────────────────────────────────────────┐
│ JDK                                      │
│ ┌─────────────────────────────────────┐ │
│ │ Name: [_________________]  ↓  (Add) │ │
│ └─────────────────────────────────────┘ │
│                                          │
│ Click "Add JDK" button                   │
└─────────────────────────────────────────┘
```

#### 5.1.2: Fill JDK Configuration

After clicking "Add JDK", you'll see form:

```
┌────────────────────────────────────────────────┐
│ Add JDK                                        │
├────────────────────────────────────────────────┤
│ Name: [JDK-17_________________________]        │
│                                                │
│ ☑ Install automatically                        │
│                                                │
│ Version: [Select version ▼]                    │
│   • openjdk-8                                  │
│   • openjdk-11                                 │
│   • openjdk-17 ← SELECT THIS                   │
│   • openjdk-21                                 │
│                                                │
│ ☐ Add Installer                                │
│                                                │
│ Note: This will download from:                 │
│ https://github.com/adoptium/temurin17-binaries/│
└────────────────────────────────────────────────┘
```

**Fill in exactly:**
- Name: `JDK-17`
- Check: ☑ Install automatically
- Version: Select `openjdk-17`

#### 5.1.3: Verify JDK

After saving, you should see:

```
JDK Section:
┌─────────────────────────────────────────┐
│ JDK                                      │
│ Name: JDK-17                             │
│    [Delete] [Save changes below]        │
└─────────────────────────────────────────┘
```

### Step 5.2: Configure Maven

#### 5.2.1: Add Maven Installation

Scroll down to Maven section:

```
Maven Section:
┌─────────────────────────────────────────┐
│ Maven                                    │
│ ┌─────────────────────────────────────┐ │
│ │ Name: [_________________]  ↓  (Add) │ │
│ └─────────────────────────────────────┘ │
│                                          │
│ Click "Add Maven" button                 │
└─────────────────────────────────────────┘
```

#### 5.2.2: Fill Maven Configuration

```
┌────────────────────────────────────────────────┐
│ Add Maven                                      │
├────────────────────────────────────────────────┤
│ Name: [Maven-3.8.6______________________]      │
│                                                │
│ ☑ Install automatically                        │
│                                                │
│ Version: [Select version ▼]                    │
│   • 3.6.0                                      │
│   • 3.6.3                                      │
│   • 3.8.6 ← SELECT THIS                        │
│   • 3.9.x                                      │
│                                                │
│ ☐ Add Installer                                │
│                                                │
│ Note: Downloads from:                          │
│ https://downloads.apache.org/maven/maven-3/    │
└────────────────────────────────────────────────┘
```

**Fill in exactly:**
- Name: `Maven-3.8.6`
- Check: ☑ Install automatically
- Version: Select `3.8.6`

#### 5.2.3: Verify Maven

After saving, you should see:

```
Maven Section:
┌─────────────────────────────────────────┐
│ Maven                                    │
│ Name: Maven-3.8.6                        │
│    [Delete] [Save changes below]        │
└─────────────────────────────────────────┘
```

### Step 5.3: Save Configuration

1. Scroll to bottom of page
2. Click **"Save"** button
3. Wait for page to reload
4. You should see: **"Tools saved successfully"** or similar

### Step 5.4: Verify Tools Installed

**Test in Jenkins:**
1. Go back to Jenkins Dashboard
2. Click **"New Item"** (just to test)
3. Notice tools section shows your configured tools
4. Go back to dashboard

---

## 🎯 STEP 6: Create Pipeline Job (DETAILED)

### Step 6.1: Create New Item

```
Jenkins Dashboard
    ↓
[New Item] ← Click this button (or link)
    ↓
Create new job page
```

**Fill in:**
```
Enter an item name: PetClinic-Pipeline
                                    ↑ Type this exactly

Project type:
○ Freestyle project
○ Organization Folder
○ Multibranch Pipeline
○ Pipeline  ← SELECT THIS (radio button)

[OK] ← Click OK button
```

### Step 6.2: Configure Pipeline - General Tab

You'll see tabs:
```
[General] [Build Triggers] [Pipeline] [Advanced Project Options]
```

#### 6.2.1: General Tab
```
☐ Discard old builds
☐ GitHub project
☐ This project is parameterized

Description (optional):
[Spring PetClinic CI/CD Pipeline with Build and Test stages]

Click "Advanced..." if you want more options
```

**Most users can leave defaults here.**

### Step 6.2: Scroll to Pipeline Tab

Click **"[Pipeline]"** tab or scroll down to Pipeline section.

### Step 6.3: Pipeline Configuration

You'll see this section:

```
┌────────────────────────────────────────────────┐
│ Pipeline                                       │
├────────────────────────────────────────────────┤
│ Definition: [Pipeline script ▼]                │
│   • Pipeline script                            │
│   • Pipeline script from SCM  ← SELECT THIS   │
│                                                │
│ SCM: [None ▼]                                  │
│   • None                                       │
│   • Git  ← SELECT THIS                         │
│                                                │
│ After selecting Git, more fields appear:       │
│                                                │
│ Repository URL: [https://github.com/user/repo] │
│                                                │
│ Credentials: [None ▼]                          │
│                                                │
│ Branch Specifier: [*/main]                     │
│                                                │
│ Script Path: [Jenkinsfile]                     │
│                                                │
│ ☐ Lightweight checkout                         │
└────────────────────────────────────────────────┘
```

#### Configuration A: Using Git Repository

**Fill in:**

1. **Definition**: `Pipeline script from SCM`
2. **SCM**: `Git`
3. **Repository URL**: 
   - GitHub example: `https://github.com/yourusername/petclinic.git`
   - GitLab example: `https://gitlab.com/yourusername/petclinic.git`
   - Local (Windows): `file:///E:/OST` (note three slashes)
   - Local (Linux): `file:///home/user/OST`
4. **Credentials**: Click "Add" if private repo, leave empty for public
5. **Branch**: `*/main` or `*/master`
6. **Script Path**: `Jenkinsfile`

#### Configuration B: Using Local File (Alternative)

If you can't use Git, use this:

1. **Definition**: `Pipeline script`
2. **Script**: Open your `Jenkinsfile` and copy entire content
3. Paste into the text box

**Copy this exact content:**

```groovy
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

### Step 6.4: Save Configuration

1. Scroll to bottom
2. Click **"Save"** button
3. You'll be taken to the pipeline job page

### Step 6.5: Run First Build

You'll see the pipeline job page:

```
┌────────────────────────────────────────────────┐
│ PetClinic-Pipeline              [Back to Dashboard] │
├────────────────────────────────────────────────┤
│                                                │
│ [←] [→] Dashboard                              │
│                                                │
│ [Build with Parameters ▼] [Pipeline Syntax]   │
│                                                │
│ Build History (No builds yet)                  │
│                                                │
│ This project has no builds yet.                │
│ Click "Build Now" to build it now.            │
└────────────────────────────────────────────────┘
```

**Click "Build Now"** (or "Build with Parameters" dropdown → "Build Now")

### Step 6.6: Monitor Build Progress

After clicking "Build Now":

#### 6.6.1: Build Appears in History

```
Build History:
┌──────────────────────────────────────┐
│ #1  [●]  Building...   12:34:45 PM   │
│     (in 5 minutes)                   │
└──────────────────────────────────────┘
```

The **●** will be:
- **🔄 Blue spinning**: Running
- **✅ Blue**: Success
- **❌ Red**: Failed
- **⚠️ Yellow**: Unstable

#### 6.6.2: Click Build to View Details

Click on **"#1"** to see details:

```
┌─────────────────────────────────────────────────┐
│ Build #1                                        │
├─────────────────────────────────────────────────┤
│ [Console Output] [Changes] [Build Status]      │
│                                                 │
│ Console Output ← CLICK THIS                     │
│                                                 │
│ This will show you real-time logs              │
└─────────────────────────────────────────────────┘
```

#### 6.6.3: Watch Console Output

You'll see output like this:

```
Started by user Admin
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/jenkins_home/workspace/PetClinic-Pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] echo
Checking out source code...
[Pipeline] checkout
Cloning the remote Git repository
Cloning repository https://github.com/...
[Pipeline] }
[Pipeline] stage
[Pipeline] { (Build)
[Pipeline] echo
Building Spring PetClinic application...
[Pipeline] sh
+ mvn clean compile -DskipTests
[INFO] Scanning for projects...
[INFO] --- clean:3.2.0:clean (default-clean) @ spring-petclinic ---
[INFO] --- compiler:3.8.1:compile (default-compile) @ spring-petclinic ---
[INFO] BUILD SUCCESS
[Pipeline] echo
Build completed successfully!
[Pipeline] }
[Pipeline] stage
[Pipeline] { (Test)
[Pipeline] echo
Running tests...
[Pipeline] sh
+ mvn test
[INFO] Tests run: 2, Failures: 0, Errors: 0, Skipped: 0
[Pipeline] echo
All tests passed successfully!
[Pipeline] }
[Pipeline] stage
[Pipeline] { (Archive Artifacts)
[Pipeline] echo
Archiving build artifacts...
[Pipeline] archiveArtifacts
Archiving artifacts
Finished: SUCCESS
```

**Look for:**
- ✅ `BUILD SUCCESS`
- ✅ `Tests run: 2, Failures: 0`
- ✅ `Finished: SUCCESS`

### Step 6.7: View Results

#### 6.7.1: Back to Build Page

Click **"Back to project"** or browser back button.

#### 6.7.2: View Test Results

On build page, you'll see:

```
┌─────────────────────────────────────────────────┐
│ Build #1                      [Build Status]   │
│                                                 │
│ [Console Output] [Changes] [Test Result]       │
│                           ↑ CLICK THIS          │
│                                                 │
│ Duration: 2 minutes 30 seconds                  │
│ Result: SUCCESS                                  │
│                                                 │
│ Artifacts (1):                                  │
│ 📦 spring-petclinic-2.7.0.jar                   │
└─────────────────────────────────────────────────┘
```

Click **"Test Result"** to see:
```
Test Results:
Tests run: 2
Failures: 0
Errors: 0
Skipped: 0

✅ org.springframework.samples.petclinic.PetclinicApplicationTests.contextLoads
✅ org.springframework.samples.petclinic.PetclinicApplicationTests.applicationStarts
```

#### 6.7.3: Download Artifacts

On build page, click on the JAR file name under "Artifacts" to download.

---

## 🐛 Troubleshooting Common Issues

### Issue 1: "mvn: command not found"

**Error in Console:**
```
[Pipeline] sh
mvn: command not found
```

**Solution:**
1. Go to: Manage Jenkins → Global Tool Configuration
2. Verify Maven is added with name `Maven-3.8.6`
3. Check "Install automatically" is checked
4. Wait 5 minutes for download
5. Save and rebuild

### Issue 2: "JAVA_HOME is not defined"

**Error:**
```
Error: JAVA_HOME is not defined correctly.
```

**Solution:**
1. Go to: Manage Jenkins → Global Tool Configuration
2. Verify JDK is added with name `JDK-17`
3. Check "Install automatically" is checked
4. Wait 5 minutes for download
5. Save and rebuild

### Issue 3: "Permission denied" in Git

**Error:**
```
Permission denied (publickey)
```

**Solutions:**

**Option A: Use HTTPS**
- Change Repository URL to HTTPS
- Add credentials if private repo

**Option B: Use Local Path**
- For Windows: `file:///E:/OST`
- For Linux: `file:///home/user/OST`
- (Note: three slashes)

### Issue 4: Build keeps failing

**Check:**
1. Console Output for specific error
2. Test Results for failing tests
3. Verify Maven and JDK installed
4. Check Jenkins has disk space

**Rebuild:**
```
1. Fix the issue
2. Click "Build Now" again
3. Watch Console Output
```

---

## ✅ Success Checklist

After following this guide, you should have:

- [x] JDK-17 configured in Jenkins
- [x] Maven-3.8.6 configured in Jenkins
- [x] Pipeline job created: "PetClinic-Pipeline"
- [x] First build successful (blue icon)
- [x] Tests passing (2 tests, 0 failures)
- [x] Artifacts archived
- [x] Console output shows SUCCESS

---

## 🎉 Congratulations!

Your Jenkins CI/CD pipeline is now fully set up and working!

### Next Steps:
1. Set up automatic builds on Git push
2. Add email notifications
3. Configure additional pipeline stages
4. Explore Blue Ocean interface

---

**Questions?** Check the main README.md for more details.

