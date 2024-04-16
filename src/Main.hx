package;

import openfl.display.Sprite;

import com.zip.asset.AssetFilesystem;

class Main extends Sprite
{
	public function new()
	{
		super();

		var args = Sys.args();
		checkArgCmd(args);
		Sys.exit(0);
	}

	private function checkArgCmd(args:Array<String>):Void {
		switch(args[0]) {
			case "-pack":
				var asset_path = args[1];
				var arg_key = args[2];
				var arg_iv = args[3];
				var files = AssetFilesystem.getFilePaths(asset_path);
				AssetFilesystem.encryptAssets(files, arg_key, arg_iv, asset_path);
			default:
				Sys.stdout().writeString("ERROR: Invalid command");
		}
	}
}
