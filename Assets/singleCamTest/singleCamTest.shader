Shader "Custom/singleCamTest"
{
	Properties
	{
		_Cam0 ("Cam0", 2D) = "white" {}
		_Cam1 ("Cam1", 2D) = "white" {}

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
			sampler2D_float _Cam1;

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

			float4 _Cam0_TexelSize;

			float _ImagePlaneLength;

			float _nearPlane;
			float _farPlane;

			float4 realCamera0Colors;
			float4 realCamera1Colors;

			float4 outputCam0Value;
			float4 outputCam1Value;

			float3 eCam0;
			float2 pCam0; //our calculation of the position

			float3 eCam1;
			float2 pCam1;

			int screenIndexX;
			int screenIndexY;

			float subImageWidth;
			float subImageOffset;
			int loopDuration;

			float2 currentSubImgPos;

			float orgPos;
			float orgPosPlus;
			float orgPosMinus ;
		//	float orgPos1;
		//	float orgPosPlus1;
		//	float orgPosMinus1;

			float4 finalColor;

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

				subImageWidth = 1.0/_Cam0_TexelSize.x;
				screenIndexX = i.pos.x / subImageWidth;
				screenIndexY = i.pos.y / subImageWidth;
				subImageOffset = 1.0;

				//return float4(screenIndexY/4.0,screenIndexY/4.0,screenIndexY/4.0,1.0);

//				if(i.pos.y > subImageWidth && i.pos.x < subImageWidth){
//					return tex2D(_RealCam0, float2(((i.pos.x))
//					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
//				}else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 1 + subImageWidth){
//					return tex2D(_RealCam1, float2(((i.pos.x%subImageWidth))
//					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
//				}else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 2 + subImageWidth){
//					return tex2D(_RealCam2, float2(((i.pos.x%subImageWidth))
//					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
//				}else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 3 + subImageWidth){
//					return tex2D(_RealCam3, float2(((i.pos.x%subImageWidth))
//					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
//				}else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth* 4 + subImageWidth){
//					return tex2D(_RealCam4, float2(((i.pos.x%subImageWidth))
//					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
//				}else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 5 + subImageWidth){
//					return tex2D(_RealCam5, float2(((i.pos.x%subImageWidth))
//					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
//				}else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 6 + subImageWidth){
//					return tex2D(_RealCam6, float2(((i.pos.x%subImageWidth))
//					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
//				}else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 7 + subImageWidth){
//					return tex2D(_RealCam7, float2(((i.pos.x%subImageWidth))
//					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
//				}else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 8 + subImageWidth){
//					return tex2D(_RealCam8, float2(((i.pos.x%subImageWidth))
//					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
//				}else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 9 + subImageWidth){
//					return tex2D(_RealCam9, float2(((i.pos.x%subImageWidth))
//					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));
//				}

				outputCam0Value = float4(0.0,0.0,0.0,2.0);
				outputCam1Value = float4(0.0,0.0,0.0,2.0);

				loopDuration = 20;
				int failure = 0;
				for (int j = 0; j <= loopDuration; j++)
				{

					realCamera0Colors = tex2D(_Cam0, float2(((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))))
					/ subImageWidth, (-(((i.pos.y % subImageWidth)) * (_Cam0_TexelSize.x))) + 1.0));

					realCamera1Colors = tex2D(_Cam1, float2(((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))))
					/ subImageWidth, (-((i.pos.y % subImageWidth) * (_Cam0_TexelSize.x))) + 1.0));

					//get z position in eye/view space
					eCam0.z = (realCamera0Colors.w) * (_farPlane - _nearPlane) + _nearPlane;
					eCam1.z = (realCamera1Colors.w) * (_farPlane - _nearPlane) + _nearPlane;

					//Convert from the projection plane to eye/view space
					eCam0.x = ( (((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam0.z)/_ImagePlaneLength;
					eCam0.x = eCam0.x - (screenIndexX * subImageOffset);

					eCam1.x = ( (((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam1.z)/_ImagePlaneLength;
					eCam1.x = eCam1.x - (screenIndexX * subImageOffset) + 9.0;

					eCam0.y = ( (((i.pos.y % subImageWidth )) - (subImageWidth / 2.0)) * eCam0.z)/_ImagePlaneLength;
					eCam0.y = eCam0.y - (screenIndexY * subImageOffset);

					eCam1.y = ( (((i.pos.y % subImageWidth )) - (subImageWidth / 2.0)) * eCam1.z)/_ImagePlaneLength;
					eCam1.y = eCam1.y - (screenIndexY * subImageOffset) + 0.0;

					//Convert back from eye/view space to the projection plane
					pCam0.x = -(_ImagePlaneLength * eCam0.x) / -eCam0.z;
					pCam0.x = pCam0.x + (subImageWidth/2.0);

					pCam1.x = -(_ImagePlaneLength * eCam1.x) / -eCam1.z;
					pCam1.x = pCam1.x + (subImageWidth/2.0);

					pCam0.y = -(_ImagePlaneLength * eCam0.y) / -eCam0.z;
					pCam0.y = pCam0.y + (subImageWidth/2.0);

					pCam1.y = -(_ImagePlaneLength * eCam1.y) / -eCam1.z;
					pCam1.y = pCam1.y + (subImageWidth/2.0);

					currentSubImgPos.x = i.pos.x - (subImageWidth * screenIndexX * subImageOffset); //position on our subimage on the screen
					currentSubImgPos.y = i.pos.y - (subImageWidth * screenIndexY * subImageOffset);

					if(abs(pCam0.x - currentSubImgPos.x) < 0.5 && abs(pCam0.y - currentSubImgPos.y) < 0.5) {
						if(outputCam0Value.w > realCamera0Colors.w){

							//orgPos      =  abs(tex2D(_Cam0, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))))) / subImageWidth, (-(i.pos.y * (_Cam0_TexelSize.x))) + 1.0)).w);
							//orgPosPlus  = (tex2D(_Cam0, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) + 0.0 )) / subImageWidth, (-(i.pos.y * (_Cam0_TexelSize.x))) + 1.0)).w);
							//orgPosMinus = (tex2D(_Cam0, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) - 0.0 )) / subImageWidth, (-(i.pos.y * (_Cam0_TexelSize.x))) + 1.0)).w);

							//if( min(orgPos - orgPosPlus, orgPos - orgPosMinus) == 0.0||min(abs(orgPos - orgPosPlus), abs(orgPos - orgPosMinus))/max(abs(orgPos - orgPosPlus), abs(orgPos - orgPosMinus)) >= 0.0 ){
								//finalColor = float4(1.0,1.0,0.0,1.0);
								outputCam0Value = tex2D(_Cam0, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) - (currentSubImgPos.x - pCam0.x))) / subImageWidth, (-((i.pos.y % (1.0/_Cam0_TexelSize.x)) * (_Cam0_TexelSize.x))) + 1.0));

								outputCam0Value.w = tex2D(_Cam0, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) )) / subImageWidth, (-((i.pos.y % (1.0/_Cam0_TexelSize.x)) * (_Cam0_TexelSize.x))) + 1.0)).w;
								//outputCam0Value += float4(0.5,0.0,0.0,0.0);
							//} else{
								finalColor = float4(0.0,1.0,0.0,1.0);
								//return float4(1.0,0.0,0.0,1.0);
							//}

						}
					}

					if(abs(pCam1.x - currentSubImgPos.x) < 0.5 && abs(pCam1.y - currentSubImgPos.y) < 0.5) {
						if(outputCam1Value.w > realCamera1Colors.w){

							//orgPos     = (tex2D(_Cam1, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) )) / subImageWidth, (-(i.pos.y * (_Cam0_TexelSize.x))) + 1.0)).w);
							//orgPosPlus  = (tex2D(_Cam1, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) + 0.0 )) / subImageWidth, (-(i.pos.y * (_Cam0_TexelSize.x))) + 1.0)).w);
							//orgPosMinus = (tex2D(_Cam1, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) - 0.0 )) / subImageWidth, (-(i.pos.y * (_Cam0_TexelSize.x))) + 1.0)).w);

							//if( min(orgPos - orgPosPlus, orgPos - orgPosMinus) == 0.0 || min(abs(orgPos - orgPosPlus), abs(orgPos - orgPosMinus))/max(abs(orgPos - orgPosPlus), abs(orgPos - orgPosMinus)) >= 0.0 ){
								//finalColor = float4(1.0,1.0,0.0,1.0);
								outputCam1Value = tex2D(_Cam1, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) - abs(currentSubImgPos.x - pCam1.x))) / subImageWidth, (-((i.pos.y % (1.0/_Cam0_TexelSize.x)) * (_Cam0_TexelSize.x))) + 1.0));

								outputCam1Value.w = tex2D(_Cam1, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) )) / subImageWidth, (-((i.pos.y % (1.0/_Cam0_TexelSize.x)) * (_Cam0_TexelSize.x))) + 1.0)).w;
								//outputCam1Value += float4(0.0,0.5,0.0,0.0);

							//}else{
								finalColor = float4(0.0,1.0,0.0,1.0);
								//return
							//}

						}
					}

				}
				return lerp(outputCam0Value, outputCam1Value, step(outputCam1Value.w, outputCam0Value.w));
				//return finalColor;
				return lerp(float4(outputCam1Value.w, outputCam1Value.w, outputCam1Value.w, 1), float4(outputCam0Value.w , outputCam0Value.w , outputCam0Value.w, 1), step(outputCam0Value.w, outputCam1Value.w));
			}

			ENDCG
		}
	}
}
