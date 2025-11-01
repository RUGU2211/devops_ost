# ⚡ Quick Reference Card

## 🎯 Current Status

- **Jenkins URL**: http://localhost:9090
- **Status**: ✅ Running in Docker
- **Container**: jenkins-petclinic

---

## 📋 STEP 5: Configure Tools (5 minutes)

### Web Navigation
```
Dashboard → Manage Jenkins → Global Tool Configuration
```

### Configure JDK
```
1. JDK Section → Add JDK
2. Name: JDK-17
3. ☑ Install automatically
4. Version: openjdk-17
5. Save
```

### Configure Maven
```
1. Maven Section → Add Maven
2. Name: Maven-3.8.6
3. ☑ Install automatically
4. Version: 3.8.6
5. Save
```

**Wait**: Tools download may take 5-10 minutes

---

## 📋 STEP 6: Create Pipeline (10 minutes)

### Create Job
```
Dashboard → New Item → PetClinic-Pipeline → Pipeline → OK
```

### Configuration
```
Pipeline Section:
- Definition: Pipeline script from SCM
- SCM: Git
- Repository URL: file:///E:/OST
- Branch: */main
- Script Path: Jenkinsfile
- Save
```

### Build
```
Click "Build Now" → Watch Console Output
```

---

## 🔍 Key Items to Look For

### ✅ Success Indicators
- Build shows **blue icon**
- Console shows: `BUILD SUCCESS`
- Tests: `Tests run: 2, Failures: 0`
- Artifacts: JAR file available

### ❌ Common Errors
- "mvn not found" → Reconfigure Maven
- "JAVA_HOME not defined" → Reconfigure JDK
- "Permission denied" → Check Git URL

---

## 🛠️ Useful Commands

```bash
# View Jenkins logs
docker logs jenkins-petclinic -f

# Restart Jenkins
docker-compose restart

# Stop Jenkins
docker-compose down

# Get admin password
docker exec jenkins-petclinic cat /var/jenkins_home/secrets/initialAdminPassword

# Check container status
docker ps | grep jenkins
```

---

## 📚 Documentation Files

- **Main Guide**: README.md
- **Detailed Steps**: STEP_BY_STEP_GUIDE.md
- **Quick Ref**: This file (QUICK_REFERENCE.md)

---

## 🎯 Next Actions

1. Open http://localhost:9090
2. Configure JDK and Maven (Step 5)
3. Create pipeline job (Step 6)
4. Run first build
5. Check results

**Need help?** Read STEP_BY_STEP_GUIDE.md for detailed instructions.

