package com.zeroip.asset;

import sys.FileSystem;
import sys.io.File;
import haxe.io.Bytes;
import com.zeroip.asset.Encryption;

class AssetFilesystem
{   
    public static function AssetFilesystem() {}
    
    public static function getFilePaths(path:String):Array<String> {
        var IGNORE_FILES = [".gitignore"];
        var files = FileSystem.readDirectory(path);
        var files_final:Array<String> = new Array<String>();
        for(i in 0...files.length) {
            var sub_path = path + "\\" + files[i];
            var sub_path_name = files[i];
            if(FileSystem.isDirectory(sub_path)) {
                //replace with individual item paths
                var sub_files = FileSystem.readDirectory(sub_path);
                for(i2 in 0...sub_files.length) {
                    sub_files[i2] = sub_path_name + "\\" + sub_files[i2];
                }
                files_final = files_final.concat(sub_files);
            }
            else if(!IGNORE_FILES.contains(files[i])) {
                files_final.push(files[i]);
            }
        }
        return files_final;
    }

    public static function encryptAssets(files:Array<String>, key:String, iv:String, assetdir:String):Void {
        var encryption:Encryption = new Encryption(key, iv);
        Sys.stdout().writeString("Encrypting files...\n");
        for(v in files) {
            Sys.stdout().writeString(v);
            var bytes = File.getBytes(assetdir + "\\" + v);
            var encrypted_file = encryption.encrypt(bytes);
            var encrypted_name = Bytes.ofString(v).toHex();
            var asset_path = assetdir + "\\.bytepack\\" + encrypted_name;
            File.saveBytes(asset_path, encrypted_file);
            if(FileSystem.exists(asset_path)) {
                Sys.stdout().writeString(" OK\n");
            } else {
                Sys.stdout().writeString("\nERROR! Asset could not be encrypted.");
                break;
            }
        }
    }
}
