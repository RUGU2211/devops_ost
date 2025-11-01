# 🔧 Fix: "No tool named Maven-3.8.6 found"

## ❌ Error You're Seeing
```
ERROR: No tool named Maven-3.8.6 found
Finished: FAILURE
```

**Why this happened:** Your `Jenkinsfile` is trying to use Jenkins tools, but Maven isn't configured.

---

## ✅ QUICK FIX (2 Steps)

### Option 1: Use Jenkinsfile.System (EASIEST!)

**Change Script Path in your Pipeline:**

1. Go to your pipeline job: `PetClinic-Pipeline`
2. Click **"Configure"**
3. Scroll to **Pipeline** section
4. Find **Script Path** field
5. Change it from: `Jenkinsfile`
6. To: `Jenkinsfile.System` ✅
7. Click **"Save"**
8. Click **"Build Now"**

**Done! Works immediately!** 🎉

---

### Option 2: Configure Maven in Jenkins

If you want to use the regular `Jenkinsfile`:

1. Go to: **Manage Jenkins** → **Global Tool Configuration**
2. Scroll to **Maven** section
3. Click **"+ Add Maven"**
4. Fill in:
   - **Name**: `Maven-3.8.6`
   - ☑ **Install automatically**
   - **Version**: `3.8.6`
5. Click **Save** (bottom)
6. Wait 5-10 minutes for download
7. Rebuild pipeline

---

## 🎯 RECOMMENDATION

**Use Option 1** - It's instant and works perfectly!

Your Docker container already has:
- ✅ Java 21 installed
- ✅ Maven 3.9.9 installed

No configuration needed!

---

## 📝 What's the Difference?

| File | What It Does | Need Config? |
|------|--------------|--------------|
| `Jenkinsfile` | Uses Jenkins tools | ❌ Yes, configure Maven |
| `Jenkinsfile.System` | Uses container tools | ✅ No! Works now! |

---

## 🔄 Fix Your Current Pipeline

**Right now:**

1. Open: http://localhost:9090
2. Click on: **PetClinic-Pipeline**
3. Click: **"Configure"**
4. Change Script Path to: `Jenkinsfile.System`
5. Click: **"Save"**
6. Click: **"Build Now"**

**Expected:** Build succeeds! ✅

---

## ✅ After Fixing

You'll see:
- ✅ Blue build icon
- ✅ All stages green
- ✅ Tests passed
- ✅ Artifacts archived

---

**Need more help?** Check `SETUP_COMPLETE.md`

