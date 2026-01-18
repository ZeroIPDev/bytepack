package zeroip;

import zeroip.asset.Encryption;
import haxe.macro.Compiler;
import haxe.io.Bytes;
import haxe.Exception;
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
    public static inline var FILE_NOT_FOUND = "filenotfound";

    public static final instance:BytePack = new BytePack();

    private static var encryption:Encryption;

    private function new() {
        #if encrypt
        var arg_key = Compiler.getDefine("bp_key");
		var arg_iv = Compiler.getDefine("bp_iv");
        encryption = new Encryption(arg_key, arg_iv);
        #end
    }

    /**
     * Synchronously load an asset from the library
     * @param name The filepath, relative to the assets directory
     * @param type Supported asset type to cast object as
     * @return Any
     */
    public static function getAsset(name:String, type:Int):Any {
        var asset_name = name;
        var asset_file:File;
        var asset_data:ByteArray = new ByteArray();
        var stream:FileStream = new FileStream();
        // Get asset name and evaluate
        #if encrypt
        asset_name = "assets/" + Bytes.ofString(asset_name).toHex();
        #else
        asset_name = "assets/" + asset_name;
        #end
        asset_file = File.applicationDirectory.resolvePath(asset_name);
        if(!asset_file.exists)
            throw new Exception(FILE_NOT_FOUND);
        // Load asset data
        #if encrypt
        var encrypted_bytes:ByteArray = new ByteArray();
        stream.open(asset_file, FileMode.READ);
        stream.readBytes(encrypted_bytes, 0, stream.bytesAvailable);
        stream.close();
        asset_data = encryption.decrypt(encrypted_bytes);
        #else
        stream.open(asset_file, FileMode.READ);
        stream.readBytes(asset_data, 0, stream.bytesAvailable);
        stream.close();
        #end
        //Cast type & return
        switch(type) {
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