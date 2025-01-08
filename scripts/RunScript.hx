package;

import com.zeroip.asset.AssetFilesystem;

class RunScript
{
	public static function main()
	{
		var args = Sys.args();
		var wd = args.pop();

		try
		{
			Sys.setCwd(wd);
		}
		catch(e:Dynamic)
		{
			Sys.stdout().writeString("Cannot set directory to " + wd + "\n");
		}

		checkArgCmd(args);
		Sys.exit(0);
	}

	private static function checkArgCmd(args:Array<String>)
	{
		switch(args[0]) {
			case "-pack":
				var asset_path = args[1];
				var arg_key = args[2];
				var arg_iv = args[3];
				var files = AssetFilesystem.getFilePaths(asset_path);
				AssetFilesystem.encryptAssets(files, arg_key, arg_iv, asset_path);
			default:
				Sys.stdout().writeString("ERROR: Invalid command\n");
		}
	}
}
