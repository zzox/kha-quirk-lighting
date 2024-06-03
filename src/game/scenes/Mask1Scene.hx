package game.scenes;

import core.ImageShader;
import core.Scene;
import kha.Assets;
import kha.Image;
import kha.Shaders;
import kha.graphics2.Graphics;
import kha.graphics4.ConstantLocation;
import kha.graphics4.TextureUnit;

class Mask1Scene extends Scene {
    var image1:Image;

    var maskId:TextureUnit;
    var timeId:ConstantLocation;
    var mask:Image;
    var target:Image;

    var time:Float = 0;

    override function create () {        
        image1 = Image.create(256, 256);

        target = Image.createRenderTarget(32, 32);

        final bytes = image1.lock();
        // randomly set rgb colors
        for (b in 0...Std.int((bytes.length / 4))) {
            bytes.set(b * 4, Math.floor(Math.random() * 0xaa));
            bytes.set(b * 4 + 1, Math.floor(Math.random() * 0xcc));
            bytes.set(b * 4 + 2, Math.floor(Math.random() * 0x88));
            bytes.set(b * 4 + 3, 0xff);
        }
        image1.unlock();

        final shader = new ImageShader(Shaders.lighting_1_frag);
        maskId = shader.pipeline.getTextureUnit('mask');
        // timeId = shader.pipeline.getConstantLocation('uTime');
        mask = Assets.images.spotlight_32;

        game.setBackbufferShader(shader);
    }

    override function update (delta:Float) {
        super.update(delta);

        time += delta;
    }

    override function render (g2:Graphics, g4:kha.graphics4.Graphics) {
        g4.begin();
        g4.setTexture(maskId, mask);
        g4.end();

        g2.begin();
        g2.clear();
        // g4.setFloat(timeId, time);
        g2.pipeline = game.backbufferPipeline;
        g2.drawImage(image1, 0, 0);
        // g2.drawImage(mask, 0, 0);

        g2.end();
    }
}
