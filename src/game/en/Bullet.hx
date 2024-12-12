package en;

class Bullet extends Entity {
    public static var ALL:Array<Bullet> = [];
    public var speed = 1.0;
    public var angle: Float;
    public function new(e:Entity){
        super(0,0);
        setPosPixel(e.centerX, e.centerY);
        ALL.push(this);
        Game.ME.scroller.add(spr,Const.DP_BG);
        angle = e.dirToAng();
        vBase.frict = 1;
        hei = 2;
        spr.set(Assets.tiles, D.tiles.fxDot);
        spr.colorize(Yellow);
        spr.setCenterRatio(0.9,0.5);
        spr.blendMode = Add;
        sprScaleX = rnd(8,15);
    }

    override function dispose() {
        super.dispose();
        ALL.remove(this);
    }

    function onBulletHit(hitX:Float, hitY:Float) {
        destroy();
    }

    override function frameUpdate() {
        
        vBase.dx = Math.cos(angle) * 0.9 * speed;
        vBase.dy = Math.sin(angle) * 0.9 * speed;
        super.frameUpdate();

        dir = M.radDistance(angle,0)<=M.PIHALF ? 1 : -1;


        if(!level.isValid(cx,cy)  || level.hasCollision(cx,cy)) {
            onBulletHit(
                (cx+0.5)*Const.GRID - Math.cos(angle)*Const.GRID*0.5,
				(cy+0.5)*Const.GRID - Math.sin(angle)*Const.GRID*0.5
            );
        };
    }

    override function postUpdate() {
        super.postUpdate();
        spr.scaleX = M.fabs(spr.scaleX);
        spr.rotation = angle;
    }
}