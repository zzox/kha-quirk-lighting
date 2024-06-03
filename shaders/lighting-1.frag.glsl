#version 450

uniform sampler2D tex;
in vec2 texCoord;
in vec4 color;
out vec4 FragColor;

uniform sampler2D mask;
uniform float uTime;

void main() {
	vec4 texcolor = texture(tex, texCoord);
    vec4 maskcolor = texture(mask, texCoord);
	// texcolor.rgb *= color.a;
    texcolor.bgr = texcolor.rgb;

    if (maskcolor.a == 1.0) {
        discard;
    }

    // texcolor.r += sin(uTime / 3.0);
    // texcolor.g += cos(uTime / 0.1);
    // texcolor.b += sin(uTime / 1.0);

    FragColor = texcolor;
}
