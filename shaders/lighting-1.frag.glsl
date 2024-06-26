#version 450

uniform sampler2D tex;
in vec2 texCoord;
in vec4 color;
in float time;
out vec4 FragColor;

uniform sampler2D mask;

void main() {
	vec4 texcolor = texture(tex, texCoord);
    vec4 maskcolor = texture(mask, texCoord);
	// texcolor.rgb *= color.a;
    texcolor.bgr = texcolor.rgb;

    if (maskcolor.a == 1.0) {
        discard;
    }

    FragColor = texcolor;
}
