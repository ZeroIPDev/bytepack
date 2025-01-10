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

		switch(args[0]) {
			case "encrypt":
				encrypt(args[1], args[2], args[3]);
			default:
				Sys.stdout().writeString("ERROR: Invalid command\n");
		}
		
		Sys.exit(0);
	}

	private static function encrypt(asset_path:String, arg_key:String, arg_iv:String)
	{
		var files = AssetFilesystem.getFilePaths(asset_path);
		AssetFilesystem.encryptAssets(files, arg_key, arg_iv, asset_path);
	}
}
