# BytePack

An asset encryption/decryption toolchain for Haxe/OpenFL.

### Prerequisites

1. Download and install [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/); ensure you have the `Desktop development with C++` package enabled in the installer
2. A working copy of the `ziptools` repo
3. Download and install [Haxe](https://haxe.org/download/); ensure both the Haxe and Neko components are selected during installation
4. Download the required libraries using `haxelib install [library]`:

* `openfl`
* `crypto`

5. Enter `haxelib run openfl setup` to complete OpenFL installation

### Installation

1. Enter `install` from the root of this repo to setup required environment variables; a restart of your terminal is recommended before continuing to step 2
2. Enter `build` to compile the toolchain application; this will take several minutes

### Testing

A simple test app is available to ensure everything is working as intended post-installation.

1. Enter `cd testApp` followed by `build` to compile the application; this will take several minutes
2. Once completed, you should be able to enter `build\windows\bin` and run `TestApp.exe`
3. The application should launch and display a bitmap
