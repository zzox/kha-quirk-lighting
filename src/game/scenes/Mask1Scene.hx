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
        // maskId = shader.pipeline.getTextureUnit('mask');
        mask = Assets.images.spotlight_32;

        game.setBackbufferShader(new ImageShader(Shaders.lighting_frag));
    }

    override function update (delta:Float) {
        super.update(delta);

        time += delta;
    }

    override function render (g2:Graphics, g4:kha.graphics4.Graphics) {
        g4.setPipeline(game.backbufferPipeline);

        target.clear(0, 0, 0, 256, 256, 1, 0x00000000);
        target.g2.drawImage(mask, 0, 0);

        maskId = game.backbufferPipeline.getTextureUnit('mask');
        // timeId = game.backbufferPipeline.getConstantLocation('uTime');
        g4.setTexture(maskId, mask);
        g2.drawImage(image1, 0, 0);
    }
}
