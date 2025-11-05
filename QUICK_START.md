# Quick Start Guide

## First Time Setup

### Prerequisites Check
```cmd
git --version           # Should show git version
mklink /?              # Should show mklink help
```

### One Command Build (Recommended)
```cmd
build_complete.cmd
```

This will:
✓ Clone all repositories  
✓ Create directory structure  
✓ Set up symbolic links  
✓ Build all libraries  
✓ Build eMule executable  

**Time**: ~15-30 minutes depending on your system

---

## Step-by-Step Build

### Step 1: Setup Environment
```cmd
setup_emule.cmd
```

### Step 2: Build Libraries
```cmd
build_all_libs.cmd
```

### Step 3: Build eMule
```cmd
build_emule.cmd
```

---

## Debug Build

```cmd
setup_emule.cmd              # Only needed once
build_all_libs_debug.cmd     # Build debug libraries
build_emule_debug.cmd        # Build eMule in debug mode
```

---

## Output Locations

| Build Type | Executable Location |
|------------|-------------------|
| **Release** | `eMule\srchybrid\x64\Release\emule.exe` |
| **Debug** | `eMule\srchybrid\x64\Debug\emule.exe` |

| Libraries | Location |
|-----------|----------|
| **Release** | `libs\*.lib` |
| **Debug** | `libs_debug\*.lib` |

---

## Common Issues

### "Git is not installed"
**Solution:** Install Git from https://git-scm.com/ and restart your terminal

### "MSBuild not found"
**Solution:** Ensure Visual Studio 2019+ is installed with C++ desktop development workload

### "mklink failed"
**Solution:** 
1. Run terminal as Administrator, OR
2. Use `junction` tool from Sysinternals

### "Library build failed"
**Solution:** Check that you have:
- Windows SDK 10.0
- MSVC v142 toolset
- Run scripts from repository root directory

### "Clean build needed"
```cmd
rmdir /s /q libs libs_debug
rmdir /s /q eMule eMule-*
setup_emule.cmd
build_complete.cmd
```

---

## File Structure After Setup

```
eMule-build/
│
├── setup_emule.cmd         ← Run first (once)
├── build_complete.cmd      ← Or run this for everything
├── build_all_libs.cmd      ← Build all libraries
├── build_emule.cmd         ← Build eMule
│
├── eMule/                  ← Main eMule source
├── eMule-cryptopp-8.4.0/   ← Crypto library
├── eMule-zlib-1.2.12/      ← Compression library
├── eMule-mbedtls-2.28/     ← SSL/TLS library
├── eMule-libpng-1.5.30/    ← PNG image library
├── eMule-miniupnp-2.2.3/   ← UPnP library
├── eMule-CxImage-7.02/     ← Image processing
├── eMule-id3lib-3.9.1/     ← MP3 ID3 tags
├── eMule-ResizableLib/     ← UI resizing
│
├── libs/                   ← Release libraries (created)
├── libs_debug/             ← Debug libraries (created)
└── eMule-zz-deps-links/    ← Symbolic links (created)
```

---

## Next Steps After Building

1. **Run eMule:**
   ```cmd
   cd eMule\srchybrid\x64\Release
   emule.exe
   ```

2. **Create Package:**
   ```cmd
   package_binary_eMule_release.cmd
   ```

3. **Development:**
   - Open `eMule\srchybrid\emule.sln` in Visual Studio
   - Use debug builds for development
   - Libraries are already built and linked

---

## Command Summary

| Command | Purpose |
|---------|---------|
| `setup_emule.cmd` | Initial setup (run once) |
| `build_complete.cmd` | Complete build (setup + libraries + eMule) |
| `build_all_libs.cmd` | Build all libraries (Release) |
| `build_all_libs_debug.cmd` | Build all libraries (Debug) |
| `build_emule.cmd` | Build eMule (Release) |
| `build_emule_debug.cmd` | Build eMule (Debug) |

---

## Getting Help

- **README.md** - Detailed documentation
- **CHANGELOG.md** - What's new
- **LIBRARY_UPGRADE_GUIDE.md** - Library version info

---

## Build Time Estimates

| Task | Estimated Time |
|------|----------------|
| Initial clone | 2-5 minutes |
| Build all libraries | 5-10 minutes |
| Build eMule | 3-5 minutes |
| **Total first build** | **10-20 minutes** |
| Incremental rebuild | 2-5 minutes |
