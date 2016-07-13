Shader "Custom/SuperSampling"
{
	Properties
	{
		//_MainTex ("Texture", 2D) = "white" {}
		_SuperResImage("SuperRes", 2D) = "white" {}
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


			// float4 bestGuessColor;
			// float bestGuessDistance;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
			    float4 pos : SV_POSITION;
			    float2 depth : TEXCOORD0;
			};

			//sampler2D _MainTex;
			sampler2D _SuperResImage;
			float4 tmpColor;
			float4 _SuperResImage_TexelSize;
			float SuperImageSizeX;
			float SuperImageSizeY;


			v2f vert (appdata v) {
			    v2f o;
			    o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
			    o.depth = float2(0.0,0.0);
			    return o;
			}

			sampler2D _MainTex;

			fixed4 frag (v2f i) : SV_Target
			{

				float myPosX = i.pos.x;
				float myPosY = i.pos.y;

				SuperImageSizeX = 1.0/_SuperResImage_TexelSize.x;
				SuperImageSizeY = 1.0/_SuperResImage_TexelSize.y;

				//float4 tmp = float4(tex2D(_SuperResImage,float2((myPosX*2)/SuperImageSizeX, (myPosY*2)/SuperImageSizeY)));
				//return float4(tmp.x, tmp.y, tmp.z, 1);
				for (int i = 0; i < 4; i++){
					for (int j = 0; j < 4; j++){

						//tex2D(_Cam3, float2());
						tmpColor += tex2D(_SuperResImage, float2((myPosX * 2.0 + (j - 2.0)) / SuperImageSizeX, (myPosY * 2.0 + (i - 2.0)) / SuperImageSizeY));
				    }
				}

				return tmpColor / 16.0;

				return float4(1,1,0,2);
			}
			ENDCG
		}
	}
}
