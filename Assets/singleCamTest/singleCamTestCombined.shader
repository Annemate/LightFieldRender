Shader "Custom/singleCamTestCombined"
{
	Properties
	{

		_Space ("Space", float) = 0
		_xAxisTexture ("xAxisTexture", 2D) = "white" {}



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

			float _Space;


			sampler2D _xAxisTexture;
			float4 _xAxisTexture_TexelSize;



			float4 _Cam0_TexelSize;
			float _ImagePlaneLength;
			float _nearPlane;
			float _farPlane;

			//colors being read from the render textures from the real cameras
			float4 realCamera0Colors;
			float4 realCamera1Colors;

			//if realCameraColors is at the correct position then the value is put into outputCamValue
			float4 outputCam0Value;
			float4 outputCam1Value;

			//position in eye space
			float3 eCam0;
			float3 eCam1;

			//position on the projection plane
			float2 pCam0;
			float2 pCam1;

			//slope from current subimage to cameras (in the corners)
			float4	slope;
			int testSlope;


			//Subimage index
			int screenIndexX;
			int screenIndexY;

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

				//Initializing values
				subImageWidth = 100;
				screenIndexX = i.pos.x / subImageWidth;
				screenIndexY = i.pos.y / subImageWidth;

				//float4 test = float4(tex2D(_xAxisTexture, float2(i.pos.x / (1.0 / _xAxisTexture_TexelSize.x), ((i.pos.y % subImageWidth + 700) ) / (1.0 / _xAxisTexture_TexelSize.y))));

				//return float4(test.w, test.w, test.w, 1.0);
				if(_Space > 1){
					return float4(1,1,1,1);
				}










				//Initializing values with extreme depth (these variables will be overwritten by the first calculations in the for-loop)
				outputCam0Value = float4(1.0,0.0,0.0,2.0);
				outputCam1Value = float4(1.0,0.0,0.0,2.0);

				loopDuration = 30;
				for (int j = 0; j <= loopDuration; j++)
				{


					//calculates the sub-image position from the current position of the fragment in screen space
					//look-up in the real camera +-half of the for-loop duration
					realCamera0Colors = (tex2D(_xAxisTexture, float2(i.pos.x / (1.0 / _xAxisTexture_TexelSize.x), ((i.pos.y % subImageWidth + (j - (loopDuration / 2.0))) ) / (1.0 / _xAxisTexture_TexelSize.y))));


					realCamera1Colors = (tex2D(_xAxisTexture, float2(i.pos.x / (1.0 / _xAxisTexture_TexelSize.x), ((i.pos.y % subImageWidth + 700.0 + (j - (loopDuration / 2.0))) ) / (1.0 / _xAxisTexture_TexelSize.y))));
					//realCamera0Colors = tex2D(_xAxisTexture, float2(i.pos.x, (i.pos.y % subImageWidth + (j - (loopDuration / 2.0))) / subImageWidth));


					//realCamera1Colors = tex2D(_xAxisTexture, float2(i.pos.x, (i.pos.y % subImageWidth + 700.0 + (j - (loopDuration / 2.0))) / subImageWidth));

					//get z position in eye/view space
					eCam0.z = (realCamera0Colors.w) * (_farPlane );
					eCam1.z = (realCamera1Colors.w) * (_farPlane );


					//Convert from the projection plane to eye/view space
					eCam0.x = ( (((i.pos.x % subImageWidth)) - (subImageWidth / 2.0)) * eCam0.z)/_ImagePlaneLength;

					eCam0.y = ( (((i.pos.y % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam0.z)/_ImagePlaneLength;
					eCam0.y = eCam0.y - screenIndexY;

					eCam1.x = ( (((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam1.z)/_ImagePlaneLength;
					//The camera offset is the position of the camera realtive to the first camera cam0 minus one


					eCam1.y = ( ((((i.pos.y % subImageWidth) + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam1.z)/_ImagePlaneLength;
					//The camera offset is the position of the camera realtive to the first camera cam0 minus one
					eCam1.y = eCam1.y - screenIndexY + 7.0;


					//Convert back from eye/view space to the projection plane
					pCam0.x = -(_ImagePlaneLength * eCam0.x) / -eCam0.z;
					pCam0.x = pCam0.x + (subImageWidth/2.0);

					pCam0.y = -(_ImagePlaneLength * eCam0.y) / -eCam0.z;
					pCam0.y = pCam0.y + (subImageWidth/2.0);

					pCam1.x = -(_ImagePlaneLength * eCam1.x) / -eCam1.z;
					pCam1.x = pCam1.x + (subImageWidth/2.0);

					pCam1.y = -(_ImagePlaneLength * eCam1.y) / -eCam1.z;
					pCam1.y = pCam1.y + (subImageWidth/2.0);



					//position of our subimage on the screen
					currentSubImgPos.x = i.pos.x - (subImageWidth * screenIndexX);
					currentSubImgPos.y = i.pos.y - (subImageWidth * screenIndexY);

					//CAMERA 0
					//check if this distance between calculated value and the fragment position is less than half a pixel


					if(abs(pCam0.y - currentSubImgPos.y) < 0.5 && (i.pos.y % subImageWidth + (j - (loopDuration / 2.0))) <= subImageWidth && (i.pos.y % subImageWidth + (j - (loopDuration / 2.0))) >= 0.0) {

						//check if this depth value is less than the previous depth value (original depth = 2)
						if(outputCam0Value.w > realCamera0Colors.w){

								//read value from real camera texture
								//calculate difference between current subimage position and real camera position
								//this value is used in a subpixel look-up (linear interpolation)
								outputCam0Value = (tex2D(_xAxisTexture, float2(i.pos.x / (1.0 / _xAxisTexture_TexelSize.x), ((i.pos.y % subImageWidth + (currentSubImgPos.y - pCam0.y) + (j - (loopDuration / 2.0))) ) / (1.0 / _xAxisTexture_TexelSize.y))));


								//texture look-up in the depth without linear interpolation

								outputCam0Value.w = tex2D(_xAxisTexture, float2(i.pos.x / (1.0 / _xAxisTexture_TexelSize.x), (i.pos.y % subImageWidth  ) / (1.0 / _xAxisTexture_TexelSize.y))).w;


						}
					}



					//CAMERA 1
					//check previous comments
					if(abs(pCam1.y - currentSubImgPos.y) < 0.5 && (i.pos.y % subImageWidth + (j - (loopDuration / 2.0))) <= subImageWidth && (i.pos.y % subImageWidth + (j - (loopDuration / 2.0))) >= 0.0) {

						if(outputCam1Value.w > realCamera1Colors.w){


								outputCam1Value = (tex2D(_xAxisTexture, float2((i.pos.x )/ (1.0 / _xAxisTexture_TexelSize.x), ((i.pos.y % subImageWidth + 700.0 + (currentSubImgPos.y - pCam1.y) + (j - (loopDuration / 2.0))) ) / (1.0 / _xAxisTexture_TexelSize.y))));

								outputCam1Value.w = tex2D(_xAxisTexture, float2(i.pos.x / (1.0 / _xAxisTexture_TexelSize.x), ((i.pos.y % subImageWidth + 700.0 + (j - (loopDuration / 2.0))) ) / (1.0 / _xAxisTexture_TexelSize.y))).w;

						}
					}



				}

				//return float4(outputCam1Value.w, outputCam1Value.w, outputCam1Value.w, 1.0);
				//return float4(outputCam0Value.w, outputCam0Value.w, outputCam0Value.w, 1.0);

				float grayOutputCam0Value = (outputCam0Value.x + outputCam0Value.y + outputCam0Value.z) / 3.0;
				float grayOutputCam1Value = (outputCam1Value.x + outputCam1Value.y + outputCam1Value.z) / 3.0;
				if(outputCam0Value.w < outputCam1Value.w){
					return outputCam0Value;
					//return (outputCam0Value); return (grayOutputCam1Value +
					//float4(0.3,0,0,0));
				}
				return outputCam1Value;
				//return (grayOutputCam0Value + float4(0,0.3,0,0));



			}
			ENDCG
		}
	}
}
