#version 450

uniform sampler2D tex;
in vec2 texCoord;
in vec4 color;
in float time;
out vec4 FragColor;

uniform sampler2D mask;

void main() {
	vec4 texcolor = texture(tex, texCoord) * color;
    vec4 maskcolor = texture(mask, texCoord) * color;

    if (maskcolor.a == 1.0) {
        discard;
    }

    FragColor = texcolor;
}
