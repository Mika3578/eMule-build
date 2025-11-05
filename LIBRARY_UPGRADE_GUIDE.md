# Library Upgrade Guide

This document explains how to upgrade the eMule library dependencies to their latest versions.

## Current vs Latest Versions

| Library | Current | Latest Stable | Status |
|---------|---------|---------------|--------|
| cryptopp | 8.4.0 | 8.9.0 | Outdated |
| zlib | 1.2.12 | 1.3.1 | Outdated |
| mbedtls | 2.28.x | 3.6.5 (LTS) | Outdated (major version) |
| libpng | 1.5.30 | 1.6.x | Outdated (major version) |
| miniupnp | 2.2.3 | 2.3.3 | Outdated |
| CxImage | 7.02 | 7.02 | Current (unmaintained) |
| id3lib | 3.9.1 | 3.9.1 | Current (unmaintained) |
| ResizableLib | Fork | Fork | Current |

## Why Libraries Haven't Been Updated

The eMule build uses forked repositories maintained by [@itlezy](https://github.com/itlezy) that contain eMule-specific modifications and Visual Studio 2019 project files. These forks need to be updated individually to incorporate newer upstream versions while preserving the eMule-specific changes.

## Upgrade Process for Fork Maintainers

### Prerequisites
- Git installed and configured
- Visual Studio 2019 or later
- Understanding of the library's purpose in eMule

### General Upgrade Steps

For each library, follow these steps:

#### 1. Fetch Upstream Changes

```bash
cd eMule-[library]-[version]
git remote add upstream [upstream-repo-url]
git fetch upstream
```

#### 2. Create New Branch for Upgrade

```bash
git checkout -b [new-version]-eMule
```

#### 3. Merge or Cherry-pick Changes

**Option A - Merge (if few eMule changes):**
```bash
git merge [upstream-tag]
# Resolve conflicts, focusing on preserving eMule modifications
```

**Option B - Rebase (for clean history):**
```bash
git rebase [upstream-tag]
# Resolve conflicts for each commit
```

**Option C - Fresh start (for major versions):**
```bash
# Create a fresh clone from upstream
git clone [upstream-repo] temp-upgrade
cd temp-upgrade
git checkout [new-version-tag]
# Manually apply eMule-specific changes from old fork
```

#### 4. Update Visual Studio Project Files

Ensure the `.vcxproj` files are compatible with VS2019:
- Update include paths
- Verify library output paths
- Test both Debug and Release configurations
- Ensure x64 platform support

#### 5. Test the Build

```bash
# In the eMule-build repo
cd ..
# Update version in setup_emule.cmd and build scripts
build_all_libs.cmd
# Verify library builds successfully
```

#### 6. Test eMule Integration

```bash
build_emule.cmd
# Run eMule and test relevant functionality
```

#### 7. Push Updated Fork

```bash
git push origin [new-version]-eMule
git tag [new-version]-eMule
git push origin [new-version]-eMule --tags
```

## Library-Specific Upgrade Instructions

### cryptopp (8.4.0 → 8.9.0)

**Upstream:** https://github.com/weidai11/cryptopp

**eMule Fork:** https://github.com/itlezy/eMule-cryptopp

**Steps:**
```bash
git clone https://github.com/itlezy/eMule-cryptopp eMule-cryptopp-8.9.0
cd eMule-cryptopp-8.9.0
git remote add upstream https://github.com/weidai11/cryptopp
git fetch upstream
git checkout -b CRYPTOPP_8_9_0-eMule
git merge CRYPTOPP_8_9_0
# Resolve conflicts in .vcxproj if any
# Test build
```

**Changes needed:**
- Update project files for any new source files
- Verify output paths remain consistent

### zlib (1.2.12 → 1.3.1)

**Upstream:** https://github.com/madler/zlib

**eMule Fork:** https://github.com/itlezy/eMule-zlib

**Breaking changes in 1.3.x:**
- Security fixes for minizip
- API changes (mostly compatible)

**Steps:**
```bash
git clone https://github.com/itlezy/eMule-zlib eMule-zlib-1.3.1
cd eMule-zlib-1.3.1
git remote add upstream https://github.com/madler/zlib
git fetch upstream
git checkout -b v1.3.1-eMule
git merge v1.3.1
# The VS project is in contrib/vstudio/vc17
```

### mbedtls (2.28.x → 3.6.5)

**Upstream:** https://github.com/Mbed-TLS/mbedtls

**eMule Fork:** https://github.com/itlezy/eMule-mbedtls

**⚠️ WARNING:** This is a MAJOR version upgrade with breaking API changes.

**Breaking changes:**
- PSA Crypto API is now the primary API
- Many deprecated functions removed
- Configuration changes required

**Recommendation:** 
- Consider staying on 2.28.x LTS (supported until 2027)
- OR plan for significant code changes in eMule to support 3.x API

**Steps (if upgrading):**
```bash
git clone https://github.com/itlezy/eMule-mbedtls eMule-mbedtls-3.6.5
cd eMule-mbedtls-3.6.5
git remote add upstream https://github.com/Mbed-TLS/mbedtls
git fetch upstream
git checkout -b mbedtls-3.6.5-eMule
git merge mbedtls-3.6.5
# Extensive testing required
# May need eMule code changes
```

### libpng (1.5.30 → 1.6.x)

**Upstream:** https://github.com/pnggroup/libpng

**eMule Fork:** https://github.com/itlezy/eMule-libpng

**Breaking changes:**
- Some API changes from 1.5 → 1.6
- Better performance and security

**Steps:**
```bash
git clone https://github.com/itlezy/eMule-libpng eMule-libpng-1.6.x
cd eMule-libpng-1.6.x
git remote add upstream https://github.com/pnggroup/libpng
git fetch upstream
# Use latest 1.6.x tag
git checkout -b 1.6.50-eMule
git merge v1.6.50
```

### miniupnp (2.2.3 → 2.3.3)

**Upstream:** https://github.com/miniupnp/miniupnp

**eMule Fork:** https://github.com/itlezy/eMule-miniupnp

**Steps:**
```bash
git clone https://github.com/itlezy/eMule-miniupnp eMule-miniupnp-2.3.3
cd eMule-miniupnp-2.3.3
git remote add upstream https://github.com/miniupnp/miniupnp
git fetch upstream
git checkout -b miniupnpc_2_3_3-eMule
git merge miniupnpc_2_3_3
```

## Updating Build Scripts After Library Upgrades

After upgrading a library in its fork, update these files in the eMule-build repository:

### 1. Update `setup_emule.cmd`
```cmd
REM Change directory names and branch names
CALL :CloneRepo "https://github.com/itlezy/eMule-cryptopp.git" "eMule-cryptopp-8.9.0" "CRYPTOPP_8_9_0-eMule"
```

### 2. Update `build_all_libs.cmd`
```cmd
REM Update paths to match new directory names
CALL :BuildLib "cryptopp" "eMule-cryptopp-8.9.0" "cryptlib.vcxproj" ...
```

### 3. Update `build_all_libs_debug.cmd`
```cmd
REM Same changes as build_all_libs.cmd
```

### 4. Update symlink creation in `setup_emule.cmd`
```cmd
CALL :CreateSymlink "cryptopp" "..\eMule-cryptopp-8.9.0"
```

### 5. Update `README.md`
Update the library versions table and directory structure.

### 6. Update `CHANGELOG.md`
Document the library version changes.

## Testing Checklist

After upgrading any library:

- [ ] Library builds successfully (Release)
- [ ] Library builds successfully (Debug)
- [ ] eMule builds successfully with new library
- [ ] eMule runs without crashes
- [ ] Library-specific features work correctly:
  - **cryptopp**: Encryption/hashing works
  - **zlib**: File compression/decompression works
  - **mbedtls**: SSL/TLS connections work
  - **libpng**: Image loading/display works
  - **miniupnp**: Port forwarding works
- [ ] No new compiler warnings introduced
- [ ] Memory leaks check (if applicable)

## Rollback Procedure

If an upgrade causes issues:

1. Revert to previous branch in fork:
   ```bash
   cd eMule-[library]-[version]
   git checkout [old-version]-eMule
   ```

2. Update build scripts to use old version

3. Rebuild everything:
   ```bash
   build_all_libs.cmd
   build_emule.cmd
   ```

## Getting Help

- Check the library's official migration guides
- Review upstream CHANGELOG and release notes
- Search for eMule-specific integration issues
- Test incrementally, one library at a time

## Contribution

If you successfully upgrade a library:

1. Document any eMule-specific changes needed
2. Submit PR to the fork repository
3. Update this guide with your findings
4. Share test results with the community
