package;

import sys.io.File;
import sys.FileSystem;

class Run
{

	public static var libdir = Sys.getCwd();

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
			Sys.println("Cannot set directory to " + wd);
		}

		switch(args[0]) {
			case "template":
				copy_template(args[1]);
			default:
				Sys.println("ERROR: Invalid command");
		}
		
		Sys.exit(0);
	}

	private static function copy_template(name:String)
	{
		if(FileSystem.exists(name) && FileSystem.isDirectory(name)) {
			Sys.println("Directory '" + name + "' already exists. Aborting");
			return;
		}
		Sys.print("Creating template project '" + name + "'...");
		// create directories
		FileSystem.createDirectory(name);
		FileSystem.createDirectory(name + "/src");
		FileSystem.createDirectory(name + "/assets");
		// copy files
		var template = libdir + "/template";
		File.copy(template + "/Template.hxproj", name + "/" + name + ".hxproj");
		File.copy(template + "/.gitignore", name + "/.gitignore");
		File.copy(template + "/src/Main.hx", name + "/src/Main.hx");
		File.copy(template + "/assets/.gitignore", name + "/assets/.gitignore");
		// write project.xml
		var project = File.getContent(template + "/project.xml");
		project = StringTools.replace(project, "Template", name);
		File.saveContent(name + "/project.xml", project);
		Sys.print("OK\n");
	}
}
