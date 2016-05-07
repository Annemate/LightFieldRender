Shader "Custom/ScaleShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_SubImages ("_SubImages", 2D) = "white" {}
		_SubImagesOffsetX ("_SubImagesOffsetX", 2D) = "white" {}
		_SubImagesOffsetY ("_SubImagesOffsetY", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _SubImages;
			float2 SubImageSizeInMm;
			float2 ScreenResolutionInPixels;
			float2 ScreenResolutionInMm;
			int _SubImagesOffsetX;
			int _SubImagesOffsetY;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
			    float4 pos : SV_POSITION;
			    float2 depth : TEXCOORD0;
			};

			v2f vert (appdata v) {
			    v2f o;
			    o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
			    o.depth = float2(0.0,0.0);
			    return o;
			}

			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target
			{
				SubImageSizeInMm = float2(10.0, 6.0);
 				ScreenResolutionInPixels = float2(1280,720);
				ScreenResolutionInMm = float2(15.36, 8.64);
				//_SubImagesOffsetX = 40;
				//_SubImagesOffsetY = 60;

				fixed4 col = tex2D(_SubImages, float2((((i.pos.x - _SubImagesOffsetX)*(ScreenResolutionInMm.x / ScreenResolutionInPixels.x)) / SubImageSizeInMm.x), (((i.pos.y - _SubImagesOffsetY) * (ScreenResolutionInMm.y / ScreenResolutionInPixels.y)) / SubImageSizeInMm.y)));
				col = lerp(col, float4(0.0,0.0,0.0,1.0),step(1,(((i.pos.x - _SubImagesOffsetX)*(ScreenResolutionInMm.x / ScreenResolutionInPixels.x)) / SubImageSizeInMm.x)));

				col = lerp(col, float4(0.0,0.0,0.0,1.0),step((((i.pos.x - _SubImagesOffsetX)*(ScreenResolutionInMm.x / ScreenResolutionInPixels.x)) / SubImageSizeInMm.x),0.0));

				col = lerp(col, float4(0.0,0.0,0.0,1.0),step(1,(((i.pos.y - _SubImagesOffsetY)*(ScreenResolutionInMm.y / ScreenResolutionInPixels.y)) / SubImageSizeInMm.y)));

				col = lerp(col, float4(0.0,0.0,0.0,1.0),step((((i.pos.y - _SubImagesOffsetY)*(ScreenResolutionInMm.y / ScreenResolutionInPixels.y)) / SubImageSizeInMm.y),0.0));
				return col;
			}
			ENDCG
		}
	}
}
