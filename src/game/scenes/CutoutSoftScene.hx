package game.scenes;

import core.Camera;
import core.Scene;
import core.Util;
import haxe.io.Bytes;
import kha.Assets;
import kha.Color;
import kha.Image;
import kha.graphics2.Graphics;

// https://stackoverflow.com/a/64054064
function setBytes (bytes:Bytes, imageWidth:Int, x:Int, y:Int, color:Int) {
    final bytePos = y * imageWidth + x;
    bytes.set(bytePos * 4, color & 0xff);
    bytes.set(bytePos * 4 + 1, (color & 0xFF00) >>> 8);
    bytes.set(bytePos * 4 + 2, (color & 0xFF0000) >>> 16);
    bytes.set(bytePos * 4 + 3, ((color & 0xFF000000) >>> 24));
}

class TestScene extends Scene {
    var image1:Image;
    var image2:Image;

    override function create () {        
        image1 = Image.create(256, 256);
        image2 = Image.create(256, 256);

        final bytes = image1.lock();
        // randomly set rgb colors
        for (b in 0...Std.int((bytes.length / 4))) {
            bytes.set(b * 4, Math.floor(Math.random() * 0xaa));
            bytes.set(b * 4 + 1, Math.floor(Math.random() * 0xcc));
            bytes.set(b * 4 + 2, Math.floor(Math.random() * 0x88));
            bytes.set(b * 4 + 3, 0xff);
        }
        image1.unlock();
    }

    override function update (delta:Float) {
        super.update(delta);

        image2 = Image.create(256, 256);
        // image2.clear(0, 0, 0, 256, 256, -1, 0xff000000);
        final bytes = image2.lock();
        for (b in 0...Std.int((bytes.length / 4))) {
            final imageWidth = 256;
            final imageHeight = 256;

            final pixelX = b % imageHeight;
            final pixelY = Math.floor(b / imageWidth);

            if (distanceBetween2(pixelX, pixelY, game.mouse.position.x, game.mouse.position.y) < 10.0) {
                bytes.set(b * 4, 0x00);
                bytes.set(b * 4 + 1, 0x00);
                bytes.set(b * 4 + 2, 0x00);
                bytes.set(b * 4 + 3, 0x00);
            } else {
                bytes.set(b * 4, 0x00);
                bytes.set(b * 4 + 1, 0x00);
                bytes.set(b * 4 + 2, 0x00);
                bytes.set(b * 4 + 3, 0xff);
            }
        }
        setBytes(bytes, 256, game.mouse.position.x, game.mouse.position.y, 0xffff00ff);
        image2.unlock();
    }

    override function render (g2:Graphics) {
        // super.render(g2);

        g2.drawImage(image1, 0, 0);
        g2.drawImage(image2, 0, 0);
    }
}
