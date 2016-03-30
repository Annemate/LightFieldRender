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

	float4 realCameraColors;

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
		
		//return float4(0,1,0,0);
		//return float4 (i.pos.y/_ScreenParams.y,0,0,0);

		//float4 lol = tex2D(_Cam0, float2((i.pos.x%(1.0/_Cam0_TexelSize.x)) * _Cam0_TexelSize.x, (i.pos.y * _Cam0_TexelSize.x)-(_ScreenParams.y / (1.0/_Cam0_TexelSize.x))+.0));
		//return float4(lol.w, lol.w, lol.w, 0);

		//find screen index x
		int screenIndexX = i.pos.x / (1.0/_Cam0_TexelSize.x);

		//go through 
		for(int j = 0 ; j < 84; j++){ 

			//Loop through real camera colors 			float4 realCameraColors = tex2D(_Cam0, float2(j/(1.0/_Cam0_TexelSize.x), (-(i.pos.y * (_Cam0_TexelSize.x)))+1.0));

			//get z position in eye space
			ze = (realCameraColors.w) * (_farPlane - _nearPlane) + _nearPlane;

			//Convert from projection space to eye space 			xe = ( (j-((1.0/_Cam0_TexelSize.x) / 2.0)) * -ze)/-_ImagePlaneLength;

			xe = xe - 1.0;//screenIndexX;

			//Convert back from eye space to projection space 			xp = -(_ImagePlaneLength * xe) / -ze;
			xp = xp + ((1.0/_Cam0_TexelSize.x)/2.0);

			int lol = (i.pos.x - (1.0/_Cam0_TexelSize.x));
			int lol2 = xp;

			if(lol == lol2) {
			return realCameraColors;
			}

			//if(abs((xp) - (i.pos.x - (1/_Cam0_TexelSize.x))) < 2){ 			//return realCameraColors; 			//}

		}
				



		//if shit goes wrong - return yellow
		return float4(1,1,0,1);
	}


	ENDCG
	    }
	}
		FallBack "Diffuse"
}
