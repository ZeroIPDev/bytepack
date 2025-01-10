package;

import openfl.display.Sprite;
import openfl.media.Sound;

import zeroip.BytePack;

class Main extends Sprite
{
	public function new()
	{
		super();
		BytePack.init();

		var pingas = BytePack.getAsset("img/pingas.png", BytePack.TYPE_BITMAP);
		addChild(pingas);
		var pingas_sound:Sound = BytePack.getAsset("sound/pingas.ogg", BytePack.TYPE_SOUND);
		pingas_sound.play();
	}
}
