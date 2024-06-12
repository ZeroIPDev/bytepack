package;

import openfl.display.Sprite;

import com.zeroip.BytePack;

class Main extends Sprite
{
	public function new()
	{
		super();

		BytePack.init();
		var pingas = BytePack.getAsset("img/pingas.png", BytePack.TYPE_BITMAP);
		addChild(pingas);
	}
}
