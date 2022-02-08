#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform float time;
uniform int pointerCount;
uniform vec3 pointers[10];
uniform vec2 resolution;

float speed = 0.5;
float diff = 0.02;

vec3 pink = vec3(0.6, 0.0, 1.0);

float wave(in float d) {
  return (sin(d*50.0-time*speed)+1.0)*0.5;
}

void main(void) {
  float ratio = 1./max(resolution.x, resolution.y);
  vec2 wh = resolution.xy * ratio;
  vec2 uv = gl_FragCoord.xy * ratio;

  if ((uv.y) < (wh.y*0.85)-wave(uv.x)*0.02){
    vec2 c1 = wh * 0.50;
    vec2 g = vec2(cos(time*speed), sin(time*speed));
    vec2 c2 = c1+g*diff;
    float d1 = distance(uv, c1);
    float d2 = distance(uv, c2);
    float wave_sum = wave(d1) / (wave(d1) + wave(d2));
    vec3 color = mix(vec3(0.0,0,0.5),pink, wave_sum);
    gl_FragColor = vec4(color, 1.0);
  }
}
