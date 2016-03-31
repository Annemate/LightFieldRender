Shader "Custom/camInterpolation" {

Properties {
		_Cam0 ("Cam0", 2D) = "white" {}
		_Cam1 ("Cam1", 2D) = "white" {}
		_Cam2 ("Cam2", 2D) = "white" {}
		_Cam3 ("Cam3", 2D) = "white" {}

		_nearPlane ("_nearPlane", float) = 0
		_farPlane ("_farPlane", float) = 0
		_ImagePlaneLength ("_ImagePlaneLength", float) = 0
	}

	SubShader {
	    Tags { "RenderType"="Opaque" }
	    Pass {
	CGPROGRAM

	#pragma vertex vert
	#pragma fragment frag
	#include "UnityCG.cginc"

	sampler2D _Cam0;
	sampler2D _Cam1;
	sampler2D _Cam2;
	sampler2D _Cam3;

	float4 _Cam0_TexelSize;

	float _ImagePlaneLength;

	float _nearPlane;
	float _farPlane;

	float4 realCamera0Colors;
	float4 realCamera1Colors;

	float4 tmpCam0Value;
	float4 tmpCam1Value;

	float ze;
	float xe;
	float ye;

	float3 posE;

	float xp;
	float yp;

	float2 posP;

	struct v2f {
	    float4 pos : SV_POSITION;
	    float2 depth : TEXCOORD0;
	};


	v2f vert (appdata_base v) {
	    v2f o;
	    o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

	    return o;
	}


	float4 frag(v2f i) : SV_Target {

		//find screen index x
		int screenIndexX = i.pos.x / (1.0/_Cam0_TexelSize.x);
		tmpCam0Value = float4(0.0,0.0,0.0,2.0);
		//go through
		for(int j = 84 ; j > 0; j--){

			//Look-up in tex2D
			realCamera0Colors = tex2D(_Cam0, float2(j/(1.0/_Cam0_TexelSize.x), (-(i.pos.y * (_Cam0_TexelSize.x)))+1.0));

			//get z position in eye space
			ze = (realCamera0Colors.w) * (_farPlane - _nearPlane) + _nearPlane;

			//Convert from projection space to eye space
			xe = ( (j-((1.0/_Cam0_TexelSize.x) / 2.0)) * ze)/_ImagePlaneLength;
			xe = xe - screenIndexX;

			//Convert back from eye space to projection space
			xp = -(_ImagePlaneLength * xe) / -ze;
			xp = xp + ((1.0/_Cam0_TexelSize.x)/2.0);

			int lol = i.pos.x - (1.0/_Cam0_TexelSize.x) * screenIndexX;
			int lol2 = xp;

			if(abs(lol2 - lol) < 0.1 && xp < (1.0/_Cam0_TexelSize.x)) {

				if(tmpCam0Value.w > realCamera0Colors.w){ 
					tmpCam0Value = realCamera0Colors;
				
				}
			}
			//test grayscale
			//return float4(screenIndexX/8.0, screenIndexX/8.0, screenIndexX/8.0, 0);
		}

		return tmpCam0Value;

		//if shit goes wrong - return yellow
		return float4(1,1,0,1);
	}


	ENDCG
	    }
	}
		FallBack "Diffuse"
}
