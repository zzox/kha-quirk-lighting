package game.scenes;

import core.ImageShader;
import core.Scene;
import kha.Assets;
import kha.Image;
import kha.Shaders;
import kha.graphics2.Graphics;
import kha.graphics4.ConstantLocation;
import kha.graphics4.PipelineState;
import kha.graphics4.TextureUnit;

class TestScene extends Scene {
    var image1:Image;

    var maskId:TextureUnit;
    var timeId:ConstantLocation;
    var mask:Image;
    var target:Image;

    var time:Float = 0;

    var pipeline:PipelineState;

    override function create () {        
        image1 = Assets.images.test_image;

        target = Image.createRenderTarget(320, 180);

        final shader = new ImageShader(Shaders.lighting_vert, Shaders.lighting_frag);
        maskId = shader.pipeline.getTextureUnit('mask');
        timeId = shader.pipeline.getConstantLocation('uTime');
        mask = Assets.images.spotlight_32;

        pipeline = shader.pipeline;
        game.setBackbufferShader(shader);
    }

    override function update (delta:Float) {
        super.update(delta);

        time += delta;
    }

    override function render (g2:Graphics, g4:kha.graphics4.Graphics, clears:Bool) {
        target.g2.begin();
        target.g2.clear(0x00000000);
        target.g2.drawImage(mask, game.mouse.position.x - 16, game.mouse.position.y - 16);
        target.g2.end();

        g4.begin();
        g4.setTexture(maskId, target);
        g4.end();

        g2.begin();
        g2.clear();
        g2.pipeline = pipeline;
        g2.drawImage(image1, 0, 0);
        g2.end();
    }
}
