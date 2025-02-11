#version 450

in vec3 vertexPosition;
in vec2 vertexUV;
in vec4 vertexColor;
uniform mat4 projectionMatrix;
uniform float uTime;
out highp float posX;
out highp float posY;
out vec2 texCoord;
out vec4 color;
out float time;

void main() {
	gl_Position = projectionMatrix * vec4(vertexPosition, 1.0);
	texCoord = vertexUV;
	color = vertexColor;
    time = uTime;
    posX = vertexUV.x * 256;
    posY = vertexUV.y * 256;
}
