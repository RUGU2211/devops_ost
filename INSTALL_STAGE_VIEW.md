# 📊 Install Stage View in Jenkins

Stage View provides a visual representation of your pipeline stages.

## 🚀 Quick Install

### Method 1: Install via Web UI (Easiest)

1. **Go to Jenkins**:
   - Open: http://localhost:9090
   - Login if needed

2. **Navigate to Plugin Management**:
   - Click: **Manage Jenkins** (left sidebar)
   - Click: **Manage Plugins**

3. **Install Stage View**:
   - Click: **"Available"** tab
   - In search box, type: **"Pipeline Stage View"**
   - Find: **"Pipeline: Stage View"**
   - ☑ Check the box
   - Click: **"Install without restart"** (bottom)
   - Wait for installation

4. **Refresh Jenkins**:
   - Installation complete! Stage view is now available

---

### Method 2: Install via Container (Advanced)

If you can't access web UI, use this:

```bash
# Access Jenkins container
docker exec -it jenkins-petclinic bash

# Run plugin installation script
# (Jenkins should auto-install recommended plugins)
```

---

## ✅ Verify Installation

1. Go to your pipeline: **PetClinic-Pipeline**
2. If Stage View is installed, you'll see:
   - **"Stage View"** icon or tab
   - Visual pipeline stages showing build progress
   - Green/blue checkmarks for each stage

---

## 📋 Alternative: Pipeline: Build Step Plugin

If "Stage View" isn't available, try these:

### Plugin Names to Search:
1. **"Pipeline: Stage View"**
2. **"Pipeline Stage View"**
3. **"Build Pipeline Plugin"**
4. **"Pipeline Graph Analysis"**

Install whichever is available.

---

## 🎯 After Installation

Once installed, you'll see:

```
╔═══════════════════════════════════════╗
║ Pipeline Stages Visualization         ║
╠═══════════════════════════════════════╣
║ Checkout   Build   Test   Archive     ║
║    ✅       ✅      ✅       ✅        ║
╚═══════════════════════════════════════╝
```

**Visual indicators:**
- ✅ Blue/Green: Stage passed
- ❌ Red: Stage failed
- ⏳ Spinning: Stage running
- ⚪ Gray: Stage pending

---

## 🔧 Recommended Plugins for Pipeline View

Install these for best experience:

1. **Pipeline: Stage View** ✅ (Main one)
2. **Pipeline Graph Analysis**
3. **Build Pipeline Plugin**
4. **Blue Ocean** (Modern UI)

---

## 🚨 Troubleshooting

**Can't find Stage View?**
- Search for: "Pipeline Stage View"
- Or: "Blue Ocean" (has better visualization)

**Installation fails?**
- Check internet connection
- Wait for installation to complete
- Restart Jenkins if needed: `docker-compose restart`

---

## 📝 Quick Reference

```bash
# View installed plugins
docker exec jenkins-petclinic cat /var/jenkins_home/config.xml | grep -i stage

# Restart Jenkins
docker-compose restart
```

---

**After install, rebuild your pipeline to see Stage View in action!** 🎉

