package;

import flixel.system.FlxAssets.FlxShader;

// adapted from https://gist.github.com/AustinEast/d3892fdf6a6079366fffde071f0c2bae
class FlxOutlineShader extends FlxShader {
	@:glFragmentSource('
        #pragma header

        // bit not great efficiency but :p
        bool sampleWithOffset(vec2 offset) {
            return texture2D(bitmap, openfl_TextureCoordv + offset).a != 0.0;
        }

        void main() {
            vec4 sample = texture2D(bitmap, openfl_TextureCoordv);
            if (sample.a < 1.0) {
                float size = 0.0;

                if (hasColorTransform) {
                    size = openfl_ColorOffsetv.x;
                }

                vec2 texSize = vec2(1.0) / openfl_TextureSize;

                int roundedSize = int(max(ceil(size), 0.0));
                float decimal = size - floor(size);
                bool goodSample = false;
                float returnAlpha = 1.0;

                for (int i = 0; i < roundedSize; ++i) {
                    vec2 offsets = texSize * float(i + 1);
                    if (i > 0 && decimal > 0.05) {
                        returnAlpha = (1.0 - decimal * float(i)) / float(i + 1);
                    }

                    // first passes
                    if (goodSample = sampleWithOffset(vec2(offsets.x, 0.0))) {
                        break;
                    }

                    if (goodSample = sampleWithOffset(vec2(-offsets.x, 0.0))) {
                        break;
                    }

                    if (goodSample = sampleWithOffset(vec2(0.0, offsets.y))) {
                        break;
                    }

                    if (goodSample = sampleWithOffset(vec2(0.0, -offsets.y))) {
                        break;
                    }

                    if (decimal > 0.05) {
                        returnAlpha /= 2.0;
                    }

                    // second passes
                    if (goodSample = sampleWithOffset(vec2(offsets.x, offsets.y))) {
                        break;
                    }

                    if (goodSample = sampleWithOffset(vec2(-offsets.x, offsets.y))) {
                        break;
                    }

                    if (goodSample = sampleWithOffset(vec2(offsets.x, -offsets.y))) {
                        break;
                    }

                    if (goodSample = sampleWithOffset(vec2(-offsets.x, -offsets.y))) {
                        break;
                    }
                }

                if (goodSample) {
                    // btw returnAlpha only works on FlxColor.BLACK for some reason???????? :/
                    if (!hasColorTransform) {
                        sample = vec4(1.0, 1.0, 1.0, (1.0 - sample.a) * returnAlpha);
                    } else {
                        sample = openfl_ColorMultiplierv * vec4(1.0, 1.0, 1.0, (1.0 - sample.a) * returnAlpha);
                    }
                }
            }
            gl_FragColor = sample * openfl_Alphav;
        }')
	public function new(width:Float = 1, height:Float = 1) {
		super();
	}
}