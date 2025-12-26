package zeroip.utils;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;

import sys.io.File;

import zeroip.asset.AssetFilesystem;

class EncryptMacro
{
    public static function callEncrypt()
    {
        #if encrypt
        var password = AssetFilesystem.generatePassword();
        var system = Sys.systemName();
        var txt:String;
        if(system == "Windows") {
            Sys.command("openssl enc -aes-256-cbc -pass pass:" + password + " -P -md sha512 -pbkdf2 >%tmp%/aes.txt");
            var tmp = Sys.getEnv("tmp");
            txt = File.getContent(tmp + "/aes.txt");
        } else {
            Sys.command("openssl enc -aes-256-cbc -pass pass:" + password + " -P -md sha512 -pbkdf2 >/tmp/aes.txt");
            txt = File.getContent("/tmp/aes.txt");
        }
        var arr = txt.split("\n");
        // identify each value and then set flags
        var salt = arr[0].split("=")[1];
        var key = arr[1].split("=")[1];
        var iv = arr[2].split("=")[1];
        Compiler.define("bp_key", key);
        Compiler.define("bp_iv", iv);
        // call asset encryption
        AssetFilesystem.clearAssets("assets");
        var files = AssetFilesystem.getFilePaths("assets");
        AssetFilesystem.encryptAssets(files, key, iv, "assets");
        #end
    }
}
#end
