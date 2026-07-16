#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

// Variables externas obligatorias para Balatro
extern MY_HIGHP_OR_MEDIUMP vec2 blackout;        // Parámetro del shader (nombre debe coincidir con el archivo)
extern MY_HIGHP_OR_MEDIUMP number dissolve;  // Intensidad del efecto de disolución (0 a 1)
extern MY_HIGHP_OR_MEDIUMP number time;      // Tiempo global del juego
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;  // (x,y) posición del sprite en atlas, (z,w) tamaño del sprite
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;    // Tamaño total de la textura atlas
extern bool shadow;                          // Indica si se está renderizando como sombra
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_1; // Color primario de quemado
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_2; // Color secundario de quemado

// ---------------------------------------------------------------------
// Función de máscara de disolución (obligatoria, se usa al final del effect)
// Controla el efecto de "quemado" cuando se consume una carta.
// No es necesario modificarla.
// ---------------------------------------------------------------------
vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01;

    float t = time * 10.0 + 2003.;
    vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
    
    vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
    vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
    vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

// ---------------------------------------------------------------------
// Funciones de utilidad para ruido (simulación de Perlin simple)
// ---------------------------------------------------------------------

float random (vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (vec2 _st) {
    vec2 i = floor(_st);
    vec2 f = fract(_st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

#define NUM_OCTAVES 5

float fbm (vec2 _st) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5),
                    -sin(0.5), cos(0.50));
    for (int i = 0; i < NUM_OCTAVES; ++i) {
        v += a * noise(_st);
        _st = rot * _st * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

// ---------------------------------------------------------------------
// Función principal del efecto
// ---------------------------------------------------------------------
vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 tex = Texel(texture, texture_coords);
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;
    
    // Escalar UV para que el ruido tenga un tamaño apropiado (equivalente a st*3. en el original)
    vec2 st = uv * 0.5;
    
    // Parámetros de control externos
    float speed = blackout.x * 0.005;     // velocidad (blackout.x entre 0 y 2 aproximadamente)
    float intensity = blackout.y;       // intensidad de la niebla (0.0 - 1.0)
    
    // -----------------------------------------------------------------
    // Lógica inspirada en el shader original
    // -----------------------------------------------------------------
    vec2 q = vec2(0.0);
    q.x = fbm(st + 0.00 * time * speed);
    q.y = fbm(st + vec2(1.0));
    
    vec2 r = vec2(0.0);
    r.x = fbm(st + 1.0 * q + vec2(1.7, 9.2) + 0.15 * time * speed);
    r.y = fbm(st + 1.0 * q + vec2(8.3, 2.8) + 0.126 * time * speed);
    
    float f = fbm(st + r);
    
    // Mezcla de colores (originalmente cyan/negro/amarillo; lo cambiamos a púrpuras)
    vec3 colorA = vec3(0.15, 0.15, 0.15);  // Púrpura medio
    vec3 colorB = vec3(0.38, 0.38, 0.38);  // Púrpura claro
    vec3 colorC = vec3(0.00, 0.00, 0.00);  // Púrpura oscuro (en lugar del azul oscuro original)
    vec3 colorD = vec3(0.3, 0.3, 0.3);  // Lila claro (reemplazando cyan claro)
    
    vec3 color = mix(colorA, colorB, clamp((f*f)*4.0, 0.0, 1.0));
    color = mix(color, colorC, clamp(length(q), 0.0, 1.0));
    color = mix(color, colorD, clamp(length(r.x), 0.0, 1.0));
    
    // Factor de brillo basado en f (original: (f*f*f + 0.6*f*f + 0.5*f))
    float brightness = (f*f*f + 0.6*f*f + 0.5*f);
    vec3 fogColor = brightness * color;
    
    // -----------------------------------------------------------------
    // Combinar con la textura de la carta
    // -----------------------------------------------------------------
    // La niebla será traslúcida, aplicada con intensidad variable
    float fogAlpha = clamp(intensity * brightness, 0.7, 0.95);
    
    // Mezcla: color original de la carta + niebla púrpura
    vec3 blended = mix(tex.rgb, fogColor, fogAlpha);
    vec4 final_color = vec4(blended, tex.a);
    
    // Aplicar el tinte de colour (parámetro global de Balatro para coloración)
    final_color *= colour;
    
    return dissolve_mask(final_color, texture_coords, uv);
}

// ---------------------------------------------------------------------
// Vertex shader para el efecto de "hover" (distorsión al pasar el ratón)
// No es necesario modificar, se incluye tal cual.
// ---------------------------------------------------------------------

// Variables para el efecto de hover (distorsión al pasar el ratón)
extern MY_HIGHP_OR_MEDIUMP vec2 mouse_screen_pos;
extern MY_HIGHP_OR_MEDIUMP float hovering;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    if (hovering <= 0.) {
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy) / length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy) / screen_scale;
    float scale = 0.2 * (-0.03 - 0.3*max(0., 0.3 - mid_dist))
                * hovering * (length(mouse_offset) * length(mouse_offset)) / (2. - mid_dist);
    return transform_projection * vertex_position + vec4(0, 0, 0, scale);
}
#endif