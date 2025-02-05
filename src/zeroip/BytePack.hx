package zeroip;

import zeroip.asset.Encryption;

import haxe.macro.Compiler;
import haxe.io.Bytes;

import lime.media.AudioBuffer;

import openfl.filesystem.File;
import openfl.filesystem.FileStream;
import openfl.filesystem.FileMode;
import openfl.utils.ByteArray;
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
        var asset_file:File;
        var asset_data:ByteArray = new ByteArray();
        var stream:FileStream = new FileStream();
        #if encrypt
        var encrypted_bytes:ByteArray = new ByteArray();
        asset_name = "assets/" + Bytes.ofString(asset_name).toHex();
        asset_file = File.applicationDirectory.resolvePath(asset_name);
        stream.open(asset_file, FileMode.READ);
        stream.readBytes(encrypted_bytes, 0, stream.bytesAvailable);
        stream.close();
        asset_data = encryption.decrypt(encrypted_bytes);
        #else
        asset_name = "assets/" + asset_name;
        asset_file = File.applicationDirectory.resolvePath(asset_name);
        stream.open(asset_file, FileMode.READ);
        stream.readBytes(asset_data, 0, stream.bytesAvailable);
        stream.close();
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