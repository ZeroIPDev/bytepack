package com.zip.asset;

import haxe.crypto.Aes;
import haxe.crypto.mode.*;
import haxe.crypto.padding.*;
import haxe.io.Bytes;

class Encryption
{

    public var aes: Aes;

    public function new(key:String, iv:String)
    {
        aes = new Aes();
        var byte_key = Bytes.ofHex(key);
        var byte_iv = Bytes.ofHex(iv);
        aes.init(byte_key, byte_iv);
    }

    public function encrypt(data:Bytes):Bytes {
        var data_encrypted = aes.encrypt(Mode.CTR, data);
        return data_encrypted;
    }

    public function decrypt(data:Bytes):Bytes {
        var data_decrypted = aes.decrypt(Mode.CTR, data);
        return data_decrypted;
    }
}
