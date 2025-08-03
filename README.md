# BytePack
 An asset encryption/decryption & delivery system for OpenFL.

## What is BytePack?
BytePack is a library/toolchain that will protect your project assets with AES-256 encryption. New keys are generated automatically on each successful build and passed to the compiler, meaning you barely have to do any work to keep your assets secure!

BytePack is built with ease of use in mind, and tries to resemble the default OpenFL asset system. All that is required is you run `BytePack.init()` somewhere at the start of your program, and then use `BytePack.getAsset()` to load recognizable data types.

```haxe
import openfl.display.Sprite;
import zeroip.BytePack;

class Main extends Sprite
{
	public function new()
	{
		super();
		BytePack.init();

		var image = BytePack.getAsset("image.png", BytePack.TYPE_BITMAP);
		addChild(image);
	}
}
```
## Compatibility
| Platform | Support                                      |
| -------- | -------------------------------------------- |
| Windows  | :white_check_mark: Fully Supported |
| Linux    | :white_check_mark: Fully Supported |
| Mac      | :ballot_box_with_check: Supported (Untested) |
| HTML5    | :x: Not Supported |

:warning: Please note Mac support is provided but not tested. Please report an issue if it's not working so we can fix it!

## Prerequisites (Windows)
1. Download and install [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/); ensure you have the `Desktop development with C++` package enabled in the installer
2. Download and install [Haxe](https://haxe.org/download/); ensure both the Haxe and Neko components are selected during installation
3. Install [OpenSSL binaries](https://slproweb.com/products/Win32OpenSSL.html) (the Win64 OpenSSL *full* package is recommended, not light); afterwards you will need to add the `bin` folder to your system path

## Prerequisites (Linux/Mac)
1. Download and install [Haxe](https://haxe.org/download/) using the preferred method for your distro
2. Ensure openssl is installed by entering `openssl` from your terminal; search for instructions if it's not present

## Installation
1. Download the required libraries using `haxelib install requirements.hxml` from this repo
2. Enter `haxelib run openfl setup` to complete OpenFL installation
3. Next, enter `haxelib dev bytepack .` to point Haxe to this directory
4. Finally, enter `cd scripts && haxe run.hxml` to compile the runtime script

## Testing
A simple test app is available to ensure everything is working as intended post-installation.

1. From this repo, enter `cd testApp`, then `openfl test linux` or `openfl test windows` to compile & launch
2. After building, the application should start; it will display a bitmap, play a sound, and trace some text in the terminal window

## Usage
To get started on your own project, enter `haxelib run bytepack template [name]`. This will create a directory with all the required project files already setup.

Any additional files placed inside `assets` will automatically be encrypted at compile time. Please note additional asset folders, or changing the asset folder name/location are not currently supported. Nested folders *inside* `assets` work as intended.

If you wish to skip encryption, for example while compiling debug builds, simply add `noencrypt` as a flag for the compiler.
