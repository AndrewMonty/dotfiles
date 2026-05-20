// source: https://gist.github.com/qwerasd205/c3da6c610c8ffe17d6d2d3cc7068f17f
// credits: https://github.com/qwerasd205
//==============================================================
//
//    [CRTS] PUBLIC DOMAIN CRT-STYLED SCALAR by Timothy Lottes
//
//    [+] Adapted with alterations for use in Ghostty by Qwerasd.
//    For more information on changes, see comment below license.
//
//==============================================================

// This shader is a modified version of the excellent
// FixingPixelArtFast by Timothy Lottes on Shadertoy.
//
// The original shader can be found at:
// https://www.shadertoy.com/view/MtSfRK

// The appearance of this shader can be altered
// by adjusting the parameters defined below.

#define SCALE 0.33333333
#define CRTS_WARP 1
#define MIN_VIN 0.2
#define CRTS_MASK_NONE 1

// Set scanline thinness and blur to zero to remove them
#define INPUT_THIN 0.0
#define INPUT_BLUR 0.0
#define INPUT_MASK 0.65

float FromSrgb1(float c) {
    return (c <= 0.04045) ? c * (1.0 / 12.92) :
           pow(c * (1.0 / 1.055) + (0.055 / 1.055), 2.4);
}

vec3 FromSrgb(vec3 c) {
    return vec3(FromSrgb1(c.r), FromSrgb1(c.g), FromSrgb1(c.b));
}

vec3 CrtsFetch(vec2 uv) {
    return FromSrgb(texture(iChannel0, uv.xy).rgb);
}

float CrtsSatF1(float x) {
    return clamp(x, 0.0, 1.0); // Clamp the value between 0.0 and 1.0
}

vec3 CrtsMask(vec2 pos, float dark) {
    return vec3(1.0, 1.0, 1.0); // No mask applied
}

vec3 CrtsFilter(
    vec2 ipos,
    vec2 inputSizeDivOutputSize,
    vec2 halfInputSize,
    vec2 rcpInputSize,
    vec2 rcpOutputSize,
    vec2 twoDivOutputSize,
    float inputHeight,
    vec2 warp,
    float thin,
    float blur,
    float mask,
    vec2 tone
) {
    // Optional apply warp
    vec2 pos;
    #ifdef CRTS_WARP
    pos = ipos * twoDivOutputSize - vec2(1.0, 1.0);
    pos *= vec2(1.0 + (pos.y * pos.y) * warp.x, 1.0 + (pos.x * pos.x) * warp.y);
    float vin = 1.0 - ((1.0 - CrtsSatF1(pos.x * pos.x)) * (1.0 - CrtsSatF1(pos.y * pos.y)));
    vin = CrtsSatF1((-vin) * inputHeight + inputHeight);
    pos = pos * halfInputSize + halfInputSize;
    #else
    pos = ipos * inputSizeDivOutputSize;
    #endif

    // Fetch the color directly without scanline filtering
    vec3 color = CrtsFetch(pos);

    // Apply phosphor mask (if needed, but here we keep it simple)
    color *= CrtsMask(ipos, mask);

    return color;
}

float ToSrgb1(float c) {
    return (c < 0.0031308 ? c * 12.92 : 1.055 * pow(c, 0.41666) - 0.055);
}

vec3 ToSrgb(vec3 c) {
    return vec3(ToSrgb1(c.r), ToSrgb1(c.g), ToSrgb1(c.b));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    float aspect = iResolution.x / iResolution.y;
    fragColor.rgb = CrtsFilter(
        fragCoord.xy,
        vec2(1.0),
        iResolution.xy * SCALE * 0.5,
        1.0 / (iResolution.xy * SCALE),
        1.0 / iResolution.xy,
        2.0 / iResolution.xy,
        iResolution.y,
        vec2(1.0 / (50.0 * aspect), 1.0 / 50.0),
        INPUT_THIN,
        INPUT_BLUR,
        INPUT_MASK,
        vec2(1.0) // Simplified tone input
    );

    // Linear to SRGB for output.
    fragColor.rgb = ToSrgb(fragColor.rgb);
}

