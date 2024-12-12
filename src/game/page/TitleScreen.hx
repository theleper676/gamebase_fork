package page;

import hxd.System;
import dn.heaps.HParticle;

class TitleScreen extends AppChildProcess {
    var cm : dn.Cinematic;
    var box : h2d.Bitmap;
    var bgCol: h2d.Bitmap;
    var ca : ControllerAccess<GameAction>;
    var pool : dn.heaps.HParticle.ParticlePool;
    var fxAdd : h2d.SpriteBatch;
    var fxNormal : h2d.SpriteBatch;

	public function new(){
		super();
		createRootInLayers(App.ME.root, Const.DP_BG);
		dn.Gc.runNow();
		
        ca = App.ME.controller.createAccess();
        cm = new dn.Cinematic(Const.FPS);
        pool = new dn.heaps.HParticle.ParticlePool(Assets.tiles.tile, 2048, Const.FPS);
 
        bgCol = new h2d.Bitmap(h2d.Tile.fromColor(Col.inlineHex("#210C29")));
        root.add(bgCol, Const.DP_MAIN);


		box = new h2d.Bitmap( hxd.Res.atlas.title.box3.toTile() );
		box.tile.setCenterRatio();
		root.add(box, Const.DP_FX_FRONT);
		box.setScale(2);
		box.setPosition( Std.int( stageWid *0.5 ), Std.int( stageHei *0.5 ) );

        fxNormal = new h2d.SpriteBatch(Assets.tiles.tile);
		root.add(fxNormal, Const.DP_FX_FRONT);
		fxNormal.hasRotationScale = true;

		fxAdd = new h2d.SpriteBatch(Assets.tiles.tile);
		root.add(fxAdd, Const.DP_FX_FRONT);
		fxAdd.blendMode = Add;
		fxAdd.hasRotationScale = true;
        
        run();
	}


    inline function allocAdd(id:String, x:Float, y:Float) : HParticle {
		return pool.alloc( fxAdd, Assets.tiles.getTile(id), x, y );
	};
    inline function allocNormal(id:String, x:Float, y:Float) : HParticle {
		return pool.alloc( fxNormal, Assets.tiles.getTile(id), x, y );
	}

    override function preUpdate() {
        super.preUpdate();
        pool.update(tmod);
    }

    override function postUpdate() {
        super.postUpdate();
        var w = stageWid / 1.;
        var h = stageHei / 1.;
        var xr = rnd(0,1);
      
        for(i in 0...5) {
            var p = allocAdd(D.tiles.pixel, rnd(0,w*0.8), rnd(0,h*0.7) );
            p.setFadeS(rnd(0.2, 0.5), 1, rnd(1,2) );
            p.colorAnimS( Col.inlineHex("#FFB272"), Col.inlineHex("#FFED95"), rnd(1,3) );
            p.alphaFlicker = rnd(0.2,0.5);
            p.setScale(irnd(1,2));
            p.dr = rnd(0,0.1,true);
            p.gx = rnd(0, 0.03);
            p.gy = rnd(-0.02, 0.08);
            p.dx = rnd(0,1);
            p.frict = R.aroundBO(0.98, 5);
            p.lifeS = rnd(1,2);
        }
    }

    override function onResize() {
        super.onResize();
        var upscale = dn.heaps.Scaler.bestFit_i(box.tile.height, box.tile.height);
        box.setScale(upscale);
        fxAdd.setScale(upscale);
        fxNormal.setScale(upscale);
        box.setPosition( Std.int( stageWid *0.5 ), Std.int( stageHei *0.5 ) );

    }

    override function update() {
        super.update();
        cm.update(tmod);
        if(ca.isPressed(MenuOk)){
            App.ME.startGame();
        }
    }

    function run(){
        var scale = 1.;
        box.alpha = 0;

        cm.create({
            700;
            tw.createS(box.alpha, 1, 2);
           /*  tw.createS(box.scaleX, scale, 0.15);
			tw.createS(box.scaleY, scale, 0.15);
            tw.createS(box.colorAdd.r, 0, 0.5);
			tw.createS(box.colorAdd.g, 0, 0.2);
			tw.createS(box.colorAdd.b, 0, 0.4); */
			200;
        });
        
        
    }

}