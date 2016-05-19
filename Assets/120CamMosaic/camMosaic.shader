Shader "Custom/camMosaic"
{
	Properties
	{

		_Space ("Space", float) = 0

		_RealCam0 ("RealCam0", 2D) = "white" {}
		_RealCam1 ("RealCam1", 2D) = "white" {}
		_RealCam2 ("RealCam2", 2D) = "white" {}
		_RealCam3 ("RealCam3", 2D) = "white" {}
		_RealCam4 ("RealCam4", 2D) = "white" {}
		_RealCam5 ("RealCam5", 2D) = "white" {}
		_RealCam6 ("RealCam6", 2D) = "white" {}
		_RealCam7 ("RealCam7", 2D) = "white" {}
		_RealCam8 ("RealCam8", 2D) = "white" {}
		_RealCam9 ("RealCam9", 2D) = "white" {}
		_RealCam10 ("RealCam10", 2D) = "white" {}
		_RealCam11 ("RealCam11", 2D) = "white" {}
		_RealCam12 ("RealCam12", 2D) = "white" {}
		_RealCam13 ("RealCam13", 2D) = "white" {}
		_RealCam14 ("RealCam14", 2D) = "white" {}

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

			float _Space;


			sampler2D _RealCam0;
			sampler2D _RealCam1;
			sampler2D _RealCam2;
			sampler2D _RealCam3;
			sampler2D _RealCam4;
			sampler2D _RealCam5;
			sampler2D _RealCam6;
			sampler2D _RealCam7;
			sampler2D _RealCam8;
			sampler2D _RealCam9;
			sampler2D _RealCam10;
			sampler2D _RealCam11;
			sampler2D _RealCam12;
			sampler2D _RealCam13;
			sampler2D _RealCam14;
			sampler2D _RealCam15;

			float4 _RealCam0_TexelSize;


			//Subimage index
			int screenIndexX;
			int screenIndexY;

			int IndexPosition;

			float subImageWidth;//pixel width of each subimage
			int loopDuration; //number of cycles in the for-loop
			float2 currentSubImgPos; //current position in the sub-image

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
				IndexPosition = 1;

				//Initializing values
				subImageWidth = 1.0/_RealCam0_TexelSize.x;
				screenIndexX = i.pos.x / subImageWidth;
				screenIndexY = i.pos.y / subImageWidth;

				if( i.pos.x < (subImageWidth * (1.0)) && i.pos.y < (subImageWidth * 1.0)){
					return tex2D(_RealCam0, float2((i.pos.x % subImageWidth) / subImageWidth, (i.pos.y % subImageWidth) / subImageWidth));
				}else if(i.pos.x < (subImageWidth * (2.0)) && i.pos.x > (subImageWidth *(3.0))&& i.pos.y < (subImageWidth * (1.0)) ){
					return tex2D(_RealCam1, float2((i.pos.x % subImageWidth) / subImageWidth, (i.pos.y % subImageWidth) / subImageWidth));
				}else if(i.pos.x < (subImageWidth * (3.0)) && i.pos.x > (subImageWidth *(4.0))&& i.pos.y < (subImageWidth * (1.0)) ){
					return tex2D(_RealCam1, float2((i.pos.x % subImageWidth) / subImageWidth, (i.pos.y % subImageWidth) / subImageWidth));
				}else if(i.pos.x < (subImageWidth * (4.0)) && i.pos.x > (subImageWidth *(5.0))&& i.pos.y < (subImageWidth * (1.0)) ){
					return tex2D(_RealCam1, float2((i.pos.x % subImageWidth) / subImageWidth, (i.pos.y % subImageWidth) / subImageWidth));
				}else if(i.pos.x < (subImageWidth * (5.0)) && i.pos.x > (subImageWidth *(6.0))&& i.pos.y < (subImageWidth * (1.0)) ){
					return tex2D(_RealCam1, float2((i.pos.x % subImageWidth) / subImageWidth, (i.pos.y % subImageWidth) / subImageWidth));
				}else if(i.pos.x < (subImageWidth * (6.0)) && i.pos.x > (subImageWidth *(7.0))&& i.pos.y < (subImageWidth * (1.0)) ){
					return tex2D(_RealCam1, float2((i.pos.x % subImageWidth) / subImageWidth, (i.pos.y % subImageWidth) / subImageWidth));
				}else if(i.pos.x < (subImageWidth * (7.0)) && i.pos.x > (subImageWidth *(8.0))&& i.pos.y < (subImageWidth * (1.0)) ){
					return tex2D(_RealCam1, float2((i.pos.x % subImageWidth) / subImageWidth, (i.pos.y % subImageWidth) / subImageWidth));
				}else if(i.pos.x < (subImageWidth * (8.0)) && i.pos.x > (subImageWidth *(9.0))&& i.pos.y < (subImageWidth * (1.0)) ){
					return tex2D(_RealCam1, float2((i.pos.x % subImageWidth) / subImageWidth, (i.pos.y % subImageWidth) / subImageWidth));
				}else if(i.pos.x < (subImageWidth * (9.0)) && i.pos.x > (subImageWidth *(10.0))&& i.pos.y < (subImageWidth * (1.0)) ){
					return tex2D(_RealCam1, float2((i.pos.x % subImageWidth) / subImageWidth, (i.pos.y % subImageWidth) / subImageWidth));
				}else if(i.pos.x < (subImageWidth * (10.0)) && i.pos.x > (subImageWidth *(11.0))&& i.pos.y < (subImageWidth * (1.0)) ){
					return tex2D(_RealCam1, float2((i.pos.x % subImageWidth) / subImageWidth, (i.pos.y % subImageWidth) / subImageWidth));
				}
				 return float4(1.0,0.0,0.0,1.0);


			}
			ENDCG
		}
	}
}
