SHADER_DEFS = {

  ['beautiful-colors'] = love.graphics.newShader([[

  varying vec4 vpos;

  #ifdef VERTEX
  extern number time;
  vec4 position( mat4 transform_projection, vec4 vertex_position )
  {
      vpos = vertex_position;
      return transform_projection * vertex_position;
  }
  #endif

  #ifdef PIXEL
  extern number time;
  vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
  {
      vec4 pixel = Texel(tex, texture_coords);
      number average = (pixel.r+pixel.g+pixel.b)/3.0;
      number factor = screen_coords.x/love_ScreenSize.x;

      pixel.r = pixel.r - (1.0*sin(time)/2.0) * factor;
      // pixel.g = pixel.g - abs(cos(time)) / factor;
      pixel.b = pixel.b - abs(cos(time)) * factor;


      return pixel;
  }
  #endif

  ]]),

  ['lights'] = love.graphics.newShader([[ #define NUM_LIGHTS 32
  struct Light {
      vec2 position;
      vec3 diffuse;
      float power;
  };
  extern Light lights[NUM_LIGHTS];
  extern int num_lights;
  extern vec2 screen;
  const float constant = 1.0;
  const float linear = 0.09;
  const float quadratic = 0.032;

  vec4 effect(vec4 colors, Image texture, vec2 texture_coords, vec2 screen_coords){
    vec4 pixel = Texel(texture, texture_coords);


    vec2 norm_screen = screen_coords / screen;
    vec3 diffuse = vec3(0);

    for(int i = 0; i < num_lights; i++) {
      Light light = lights[i];
      vec2 norm_pos = light.position / screen;

      float distance = length(norm_pos - norm_screen)  * screen.x / light.power;
      float attenuation = 1.0 / (constant + linear * distance + quadratic * (distance * distance));
      diffuse += light.diffuse * attenuation;
    }

    diffuse = clamp(diffuse, 0.0, 1.0);


    return pixel * vec4(diffuse, 1);
  }

  ]]),

  ['blink'] = love.graphics.newShader([[

  extern number blinkColor;
  vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords){
    vec4 pixel = Texel(texture, texture_coords);
    number average = (pixel.r+pixel.g+pixel.b)/3.0;
    // number factor = love_ScreenSize.x / screen_coords.x;
    vec4 blink = vec4(blinkColor);


    pixel.r = pixel.r - average;
    pixel.g = pixel.g - average;
    pixel.b = pixel.b - average;


    // pixel.r = pixel.r + (pixel.r - average) / factor;
    // pixel.g = pixel.g + (pixel.g - average) / factor;
    // pixel.b = pixel.b + (pixel.b - average) / factor;

    return pixel * blink;
  }

  ]]),

  ['gradient'] = love.graphics.newShader([[

  vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords){
    vec4 pixel = Texel(texture, texture_coords);
    number average = (pixel.r+pixel.g+pixel.b)/3.0;
    number factorY = screen_coords.y/texture_coords.y;
    number factorX = screen_coords.x/love_ScreenSize.x;

    pixel.r = clamp(pixel.r - average * factorY, .7, 1);
    pixel.g = clamp(pixel.g - average * factorX, .7, 1);
    pixel.b = clamp(pixel.b - average / factorX, .7, 1);


    return pixel;
  }

  ]]),

  ['transparent'] = love.graphics.newShader([[
  vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords){
    vec4 pixel = Texel(texture, texture_coords);
    pixel.a = 0.0;
    return pixel;
  }
  ]])


}
