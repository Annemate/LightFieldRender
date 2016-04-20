Shader "Custom/singleCamTest"
{
	Properties
	{
		_Cam0 ("Cam0", 2D) = "white" {}
		_RealCam0 ("RealCam0", 2D) = "white" {}
		_RealCam1 ("RealCam1", 2D) = "white" {}
		
		_nearPlane ("_nearPlane", float) = 0
		_farPlane ("_farPlane", float) = 0
		_ImagePlaneLength ("_ImagePlaneLength", float) = 0
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

			sampler2D_float _Cam0;
			sampler2D_float _RealCam0;
			sampler2D_float _RealCam1;

	
			float4 _Cam0_TexelSize;

			float _ImagePlaneLength;

			float _nearPlane;
			float _farPlane;

			float4 realCamera0Colors;

			float4 tmpCam0Value;

			float ze;
			float xe;
			float ye;

			float xp;
			float yp;

			float subImageWidth;
			int screenIndexX;
			float subImageOffset;

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

			    return o;
			}
			
			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target
			{

				
				
				subImageWidth = 1.0/_Cam0_TexelSize.x; 
				screenIndexX = i.pos.x / subImageWidth;
				subImageOffset = 1.0;

				tmpCam0Value = float4(0.0,0.0,0.0,2.0);

				if(i.pos.y > subImageWidth && i.pos.x < subImageWidth){
					//return float4(1,0,0,1);
					return tex2D(_RealCam0, float2(((i.pos.x)) 
					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
				}else if(i.pos.y > subImageWidth && i.pos.x > subImageWidth){
					return tex2D(_RealCam1, float2(((i.pos.x%subImageWidth)) 
					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
				}else

				for (int j = 99; j >= 0; j--)
				{

					realCamera0Colors = tex2D(_Cam0, float2(((j)) 
					/ subImageWidth, (-(i.pos.y * (_Cam0_TexelSize.x))) + 1.0));

					//get z position in eye/view space
					ze = (realCamera0Colors.w) * (_farPlane - _nearPlane) + _nearPlane;

					//Convert from the projection plane to eye/view space
					xe = ( (((j)) - (subImageWidth / 2.0)) * ze)/_ImagePlaneLength;
					xe = xe - (screenIndexX * subImageOffset);

					//Convert back from eye/view space to the projection plane
					xp = -(_ImagePlaneLength * xe) / -ze;
					xp = xp + (subImageWidth/2.0);

					float lol = i.pos.x - (subImageWidth * screenIndexX * subImageOffset);
					float lol2 = xp;

					if(abs(lol2 - lol) <= 0.4) {
						if(tmpCam0Value.w > realCamera0Colors.w){
							tmpCam0Value = realCamera0Colors;
							//tmpCam0Value += float4(0.8,0,0,0);

						}
					}

				}

				return tmpCam0Value;

			}
			ENDCG
		}
	}
}
