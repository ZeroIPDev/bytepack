package zeroip;

import zeroip.asset.Encryption;

import haxe.macro.Compiler;
import haxe.io.Bytes;

import sys.io.File;

import lime.media.AudioBuffer;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.media.Sound;

class BytePack
{
    public static inline var TYPE_BYTES = 0;
    public static inline var TYPE_BITMAP = 1;
    public static inline var TYPE_SOUND = 2;
    public static inline var TYPE_TEXT = 3;

    private static var encryption:Encryption;

    public static function BytePack() {}

    public static function init():Void {
        #if encrypt
        var arg_key = Compiler.getDefine("bp_key");
		var arg_iv = Compiler.getDefine("bp_iv");
        encryption = new Encryption(arg_key, arg_iv);
        #end
    }

    public static function getAsset(n:String, t:Int):Any {
        var asset_name = n;
        var asset_data:Bytes;
        #if encrypt
        asset_name = "assets/" + Bytes.ofString(asset_name).toHex();
        var encrypted_bytes = File.getBytes(asset_name);
        asset_data = encryption.decrypt(encrypted_bytes);
        #else
        asset_name = "assets/" + asset_name;
        asset_data = File.getBytes(asset_name);
        #end
        //Cast type & return
        switch(t) {
            case TYPE_BYTES:
                return asset_data;
            case TYPE_BITMAP:
                var bitmap_data = BitmapData.fromBytes(asset_data);
                return(new Bitmap(bitmap_data));
            case TYPE_SOUND:
                var buffer = AudioBuffer.fromBytes(asset_data);
                return(Sound.fromAudioBuffer(buffer));
            case TYPE_TEXT:
                return asset_data.toString();
        }
        return null;
    }
}