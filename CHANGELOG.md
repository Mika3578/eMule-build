# Changelog

## 2025-11-05 - Build Script Simplification

### New Simplified Scripts

#### All-in-One Scripts
- **`setup_emule.cmd`** - Complete environment setup (replaces `001_clone_git_repos.cmd` and `002_create_symlinks.cmd`)
  - Clones all required repositories
  - Creates directory structure (libs, libs_debug)
  - Sets up symbolic links automatically
  - Provides clear status messages and error handling

- **`build_complete.cmd`** - One-command complete build
  - Runs setup if needed
  - Builds all libraries
  - Builds eMule executable
  - Complete end-to-end automation

#### Individual Build Scripts
- **`build_all_libs.cmd`** - Build all libraries in Release mode (replaces `003_build_MSBuild_ALL_libs.cmd`)
  - Sequential building with progress indicators
  - Better error handling and reporting
  - Automatic library copying to `libs/` directory

- **`build_all_libs_debug.cmd`** - Build all libraries in Debug mode (replaces `003_build_MSBuild_ALL_libs_debug.cmd`)
  - Debug configuration with proper output paths
  - Copies to `libs_debug/` directory

- **`build_emule.cmd`** - Build eMule in Release mode (replaces `build_MSBuild_eMule.cmd`)
  - Simple, focused eMule build
  - Pre-checks for required libraries

- **`build_emule_debug.cmd`** - Build eMule in Debug mode
  - Debug configuration build
  - Pre-checks for debug libraries

### Improvements

#### Better User Experience
- Clear progress messages during all operations
- Consistent output formatting with [OK], [ERROR], [SKIP] indicators
- Proper error handling with meaningful messages
- PAUSE at end of scripts for review
- Helpful "next steps" guidance

#### Code Quality
- Consolidated duplicate code into helper functions
- Reduced script count (6 new scripts replace 50+ scattered scripts)
- Better organization with clear separation of concerns
- Improved maintainability

#### Directory Structure
- Cleaner root directory with fewer scripts
- Better organization of build artifacts
- Clear separation of release and debug builds

### Legacy Script Compatibility

The following legacy scripts remain for backward compatibility but are superseded by the new simplified scripts:

| Legacy Script | Replaced By |
|--------------|-------------|
| `001_clone_git_repos.cmd` | `setup_emule.cmd` |
| `002_create_symlinks.cmd` | `setup_emule.cmd` |
| `003_build_MSBuild_ALL_libs.cmd` | `build_all_libs.cmd` |
| `003_build_MSBuild_ALL_libs_debug.cmd` | `build_all_libs_debug.cmd` |
| `004_build_MSBuild_eMule.cmd` | `build_emule.cmd` |
| Individual `build_MSBuild_*.cmd` scripts | Integrated into `build_all_libs.cmd` |

### Migration Guide

**Old Workflow:**
```cmd
001_clone_git_repos.cmd
002_create_symlinks.cmd
003_build_MSBuild_ALL_libs.cmd
004_build_MSBuild_eMule.cmd
```

**New Workflow (Option 1 - All-in-one):**
```cmd
build_complete.cmd
```

**New Workflow (Option 2 - Step by step):**
```cmd
setup_emule.cmd
build_all_libs.cmd
build_emule.cmd
```

### Library Versions

Current library versions used:
- cryptopp: **8.4.0** (latest available: 8.9.0)
- zlib: **1.2.12** (latest available: 1.3.1)
- mbedtls: **2.28.x** (latest LTS: 3.6.x)
- libpng: **1.5.30** (latest available: 1.6.x)
- miniupnp: **2.2.3** (latest available: 2.3.3)
- CxImage: **7.02**
- id3lib: **3.9.1**
- ResizableLib: **Latest from fork**

> **Note**: Library versions are constrained by the available forks with eMule-specific modifications. Upgrading to newer versions would require updating the forked repositories.

### Future Improvements

Potential areas for future enhancement:
- Automated library version checking
- Parallel library building for faster compilation
- Continuous integration support
- Automated testing framework
- Library update automation
