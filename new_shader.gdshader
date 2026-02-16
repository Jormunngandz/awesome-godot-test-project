shader_type spatial;

uniform float scale = .01;
uniform sampler2D img; //import a pattern png. You can actually replace this with a white noise texture for the usual alpha hash

void fragment() {
    ALPHA = UV.g*2.-0.3; // sample UV code

// The part below this is the part that actually matters. Make sure you have the scale and img parameters (or replace the scale parameter with a number) then add the script below.

// You can also remove the ALPHA=1. part and replace ALPHA with a variable for honestly slightly cleaner code.

    vec2 screenpos = SCREEN_UV*VIEWPORT_SIZE / VIEWPORT_SIZE.y /(scale);
    float alphatexture = texture(img, (screenpos)).r;
    if (ALPHA < alphatexture) {
         discard;
    }
    ALPHA = 1.;
}
