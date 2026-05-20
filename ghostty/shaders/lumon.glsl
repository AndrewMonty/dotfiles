// curved crt
#define WARP 0.2

// bloom
// x \in R : x >= 0
#define BLOOM_SPREAD 4.0
// [0, 1]
#define BLOOM_STRENGTH 0.09

// tint
// [0, 1]^3
#define TINT 0.8, 0.9, 1

// pixel grid
#define GRID_SIZE 4.0
#define LINE_WIDTH 1
#define CONTRAST 0.3

// scan line
#define SCAN_LINE_SPEED 0.2
#define SCAN_LINE_HEIGHT 0.01

#ifdef BLOOM_SPREAD
// Golden spiral samples used for bloom.
//   [x, y, weight] weight is inverse of distance.
const vec3[24] bloom_samples = {
    vec3( 0.1693761725038636,  0.9855514761735895,  1),
    vec3(-1.333070830962943,   0.4721463328627773,  0.7071067811865475),
    vec3(-0.8464394909806497, -1.51113870578065,    0.5773502691896258),
    vec3( 1.554155680728463,  -1.2588090085709776,  0.5),
    vec3( 1.681364377589461,   1.4741145918052656,  0.4472135954999579),
    vec3(-1.2795157692199817,  2.088741103228784,   0.4082482904638631),
    vec3(-2.4575847530631187, -0.9799373355024756,  0.3779644730092272),
    vec3( 0.5874641440200847, -2.7667464429345077,  0.35355339059327373),
    vec3( 2.997715703369726,   0.11704939884745152, 0.3333333333333333),
    vec3( 0.41360842451688395, 3.1351121305574803,  0.31622776601683794),
    vec3(-3.167149933769243,   0.9844599011770256,  0.30151134457776363),
    vec3(-1.5736713846521535, -3.0860263079123245,  0.2886751345948129),
    vec3( 2.888202648340422,  -2.1583061557896213,  0.2773500981126146),
    vec3( 2.7150778983300325,  2.5745586041105715,  0.2672612419124244),
    vec3(-2.1504069972377464,  3.2211410627650165,  0.2581988897471611),
    vec3(-3.6548858794907493, -1.6253643308191343,  0.25),
    vec3( 1.0130775986052671, -3.9967078676335834,  0.24253562503633297),
    vec3( 4.229723673607257,   0.33081361055181563, 0.23570226039551587),
    vec3( 0.40107790291173834, 4.340407413572593,   0.22941573387056174),
    vec3(-4.319124570236028,   1.159811599693438,   0.22360679774997896),
    vec3(-1.9209044802827355, -4.160543952132907,   0.2182178902359924),
    vec3( 3.8639122286635708, -2.6589814382925123,  0.21320071635561041),
    vec3( 3.3486228404946234,  3.4331800232609,     0.20851441405707477),
    vec3(-2.8769733643574344,  3.9652268864187157,  0.20412414523193154)
};
#endif

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Get texture coordinates
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 og = fragCoord.xy / iResolution.xy;

#ifdef WARP
    // squared distance from center
    vec2 dc = abs(0.5 - uv);
    dc *= dc;

    // warp the fragment coordinates
    uv.x -= 0.5;
    uv.x *= 1.0 + (dc.y * (0.3 * WARP));
    uv.x += 0.5;
    uv.y -= 0.5;
    uv.y *= 1.0 + (dc.x * (0.4 * WARP));
    uv.y += 0.5;

#endif

    // Sample the texture
    vec4 vColor = texture(iChannel0, uv);

    // Darken the pixels outside the warped area
    // Check if the warped UV coordinates are within the screen bounds
    float isInsideWarp = step(0.0, 1.0 - (abs(uv.x - 0.5) + abs(uv.y - 0.5)));
    vColor.rgb *= mix(0.5, 1.0, isInsideWarp); // Darken if outside, keep original if inside

    // Apply the color to fragColor
    fragColor = vColor;

#ifdef SCAN_LINE_SPEED
    float st = step(mod(uv.y + iTime * SCAN_LINE_SPEED, 1), SCAN_LINE_HEIGHT) * 0.1;
    uv.x = uv.x + st * 0.01;
    vec4 color = texture(iChannel0, uv);
    color = color * (1 + st * 3) + st * 0.5;
    fragColor = vec4(color);
#endif

#ifdef GRID_SIZE
    // pixel grid
    float sx = step(mod(fragCoord.x, GRID_SIZE), LINE_WIDTH);
    float sy = step(mod(fragCoord.y, GRID_SIZE), LINE_WIDTH);
    float s = clamp(sx+sy, 0.0, CONTRAST);
    vec4 col = texture(iChannel0, uv);
    col = clamp(col*(1. + CONTRAST) - s, 0.0, 1.0);
    fragColor = vec4(col);
    fragColor = clamp(fragColor, 0.0, 1.0);
#endif

#ifdef TINT
    // Tint all colors
    fragColor.rgb *= vec3(TINT);
#endif

#ifdef BLOOM_SPREAD
    // Add bloom
    vec2 step = BLOOM_SPREAD * vec2(1.414) / iResolution.xy;

    for (int i = 0; i < 24; i++) {
        vec3 bloom_sample = bloom_samples[i];
        vec4 neighbor = texture(iChannel0, uv + bloom_sample.xy * step);
        float luminance = 0.299 * neighbor.r + 0.587 * neighbor.g + 0.114 * neighbor.b;

        fragColor += luminance * bloom_sample.z * neighbor * BLOOM_STRENGTH;
    }

    fragColor = clamp(fragColor, 0.0, 1.0);
#endif
}

