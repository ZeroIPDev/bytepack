package com.zeroip;

import com.zeroip.asset.Encryption;
import haxe.macro.Compiler;
import sys.FileSystem;
import sys.io.File;
import haxe.io.Bytes;

import openfl.display.BitmapData;
import openfl.display.Bitmap;

class BytePack
{

    public static inline var TYPE_BITMAP = 1; 

    private static var encryption:Encryption;

    public static function BytePack() {}

    public static function init():Void {
        #if bytepack
        var arg_key = Compiler.getDefine("bp_key");
		var arg_iv = Compiler.getDefine("bp_iv");
        encryption = new Encryption(arg_key, arg_iv);
        #end
    }

    public static function getAsset(n:String, t:Int):Any {
        var asset_name = n;
        asset_name = StringTools.replace(asset_name, "/", "\\");
        var asset_data:Bytes;
        #if bytepack
        asset_name = "assets\\" + Bytes.ofString(asset_name).toHex();
        var encrypted_bytes = File.getBytes(asset_name);
        asset_data = encryption.decrypt(encrypted_bytes);
        #else
        asset_name = "assets\\" + asset_name;
        asset_data = File.getBytes(asset_name);
        #end
        //Cast type & return
        switch(t) {
            case TYPE_BITMAP:
                var bitmap_data = BitmapData.fromBytes(asset_data);
                return(new Bitmap(bitmap_data));
        }
        return null;
    }
}