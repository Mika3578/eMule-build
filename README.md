# Build package for eMule Community

Streamlined build scripts for eMule and its dependencies. All projects are configured for Visual Studio 2019 with correct path references and optimized libraries.

## Prerequisites

1. **Git** - Installed and available on `PATH`
2. **Windows** - `mklink` command available (built-in on Windows Vista+)
   - Alternative: Use `junction` from Sysinternals and modify `setup_emule.cmd`
3. **Visual Studio 2019** or later
   - Windows SDK 10.0
   - MSVC v142 toolset (x64/x86)
   - C++ desktop development workload

## Quick Start

### Workflow Diagram

```
┌─────────────────────────────────────────────────┐
│  Option 1: One Command (Recommended)            │
│  ┌────────────────────────────────────┐         │
│  │  build_complete.cmd                │         │
│  │  ├─> Setup environment             │         │
│  │  ├─> Build all libraries           │         │
│  │  └─> Build eMule                   │         │
│  └────────────────────────────────────┘         │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│  Option 2: Step-by-Step                          │
│  ┌────────────────────────────────────┐         │
│  │  1. setup_emule.cmd                │         │
│  │     ├─> Clone repositories         │         │
│  │     ├─> Create directories         │         │
│  │     └─> Setup symlinks             │         │
│  │                                     │         │
│  │  2. build_all_libs.cmd             │         │
│  │     ├─> Build cryptopp              │         │
│  │     ├─> Build CxImage               │         │
│  │     ├─> Build id3lib                │         │
│  │     ├─> Build libpng                │         │
│  │     ├─> Build mbedtls               │         │
│  │     ├─> Build miniupnp              │         │
│  │     ├─> Build ResizableLib          │         │
│  │     └─> Build zlib                  │         │
│  │                                     │         │
│  │  3. build_emule.cmd                │         │
│  │     └─> Build eMule executable     │         │
│  └────────────────────────────────────┘         │
└─────────────────────────────────────────────────┘
```

### One-Time Setup

```cmd
setup_emule.cmd
```

This script will:
- Clone all required repositories (eMule + dependencies)
- Create the proper directory structure
- Set up symbolic links for library includes
- Prepare the build environment

### Building

#### Complete Build (Easiest)
```cmd
build_complete.cmd    # Setup + Build everything
```

#### Release Build
```cmd
build_all_libs.cmd    # Build all libraries (Release)
build_emule.cmd       # Build eMule executable (Release)
```

#### Debug Build
```cmd
build_all_libs_debug.cmd    # Build all libraries (Debug)
build_emule_debug.cmd       # Build eMule executable (Debug)
```

## Directory Structure

After running `setup_emule.cmd`, you'll have:

```
eMule-build/
├── eMule/                      # Main eMule source
├── eMule-cryptopp-8.4.0/       # Crypto++ library
├── eMule-CxImage-7.02/         # Image processing library
├── eMule-id3lib-3.9.1/         # ID3 tag library
├── eMule-libpng-1.5.30/        # PNG library
├── eMule-mbedtls-2.28/         # TLS/SSL library
├── eMule-miniupnp-2.2.3/       # UPnP library
├── eMule-ResizableLib/         # UI resize library
├── eMule-zlib-1.2.12/          # Compression library
├── eMule-zz-deps-links/        # Symbolic links for includes
├── libs/                       # Built libraries (Release)
└── libs_debug/                 # Built libraries (Debug)
```

## Build Output

- **Release**: `eMule\srchybrid\x64\Release\emule.exe`
- **Debug**: `eMule\srchybrid\x64\Debug\emule.exe`

## Legacy Scripts

For compatibility, the old numbered scripts are still available:
- `001_clone_git_repos.cmd` → Use `setup_emule.cmd` instead
- `002_create_symlinks.cmd` → Integrated into `setup_emule.cmd`
- `003_build_MSBuild_ALL_libs.cmd` → Use `build_all_libs.cmd` instead
- `004_build_MSBuild_eMule.cmd` → Use `build_emule.cmd` instead

## Library Versions

Current versions (as of the forked repositories):
- **cryptopp**: 8.4.0
- **zlib**: 1.2.12
- **mbedtls**: 2.28.x
- **libpng**: 1.5.30
- **miniupnp**: 2.2.3
- **CxImage**: 7.02
- **id3lib**: 3.9.1
- **ResizableLib**: Latest from fork

> **Note**: These libraries are forks with eMule-specific modifications. The external libraries are maintained separately and require minimal changes to build on Visual Studio 2019.

## Troubleshooting

### Build Errors
1. Ensure all prerequisites are installed
2. Run scripts from the repository root directory
3. Check that Visual Studio 2019 is properly installed with C++ components

### Missing Libraries
If `build_emule.cmd` fails with missing libraries:
```cmd
build_all_libs.cmd
```

### Clean Build
To start fresh, delete these directories and re-run setup:
```cmd
rmdir /s /q libs libs_debug eMule-zz-deps-links
rmdir /s /q eMule eMule-*
setup_emule.cmd
```
