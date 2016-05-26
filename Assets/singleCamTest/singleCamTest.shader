Shader "Custom/singleCamTest"
{
	Properties
	{
		_Cam0 ("Cam0", 2D) = "white" {}
		_Cam1 ("Cam1", 2D) = "white" {}
		_Cam2 ("Cam2", 2D) = "white" {}
		_Cam3 ("Cam3", 2D) = "white" {}
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
		_RealCam15 ("RealCam15", 2D) = "white" {}

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

			sampler2D _Cam0;
			sampler2D _Cam1;
			sampler2D _Cam2;
			sampler2D _Cam3;

			sampler2D _RealCam0; //remove
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

			float4 _Cam0_TexelSize;
			float _ImagePlaneLength;
			float _nearPlane;
			float _farPlane;

			//colors being read from the render textures from the real cameras
			float4 realCamera0Colors;
			float4 realCamera1Colors;
			float4 realCamera2Colors;
			float4 realCamera3Colors;

			//if realCameraColors is at the correct position then the value is put into outputCamValue
			float4 outputCam0Value;
			float4 outputCam1Value;
			float4 outputCam2Value;
			float4 outputCam3Value;

			//position in eye space
			float3 eCam0;
			float3 eCam1;
			float3 eCam2;
			float3 eCam3;

			//position on the projection plane
			float2 pCam0;
			float2 pCam1;
			float2 pCam2;
			float2 pCam3;

			//slope from current subimage to cameras (in the corners)
			float4	slope;
			int testSlope;

			//camera positions
			float2	cam0pos;
			float2	cam1pos;
			float2	cam2pos;
			float2	cam3pos;

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

				//return tex2D(_Cam0, float2((i.pos.x % 100) / 100, (i.pos.y % 100) / 100));

				if(_Space > 1){
					return float4(1,1,1,1);
				}

				cam0pos = float2(0.0,0.0);
				cam1pos = float2(14.0,0.0);
				cam2pos = float2(14.0,7.0);
				cam3pos = float2(0.0,7.0);




				//Initializing values
				subImageWidth = 1.0/_Cam0_TexelSize.x;
				screenIndexX = i.pos.x / subImageWidth;
				screenIndexY = i.pos.y / subImageWidth;


				//return float4(screenIndexY/4.0,screenIndexY/4.0,screenIndexY/4.0,1.0);

				 // if(i.pos.y > subImageWidth && i.pos.x < subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	return tex2D(_RealCam0, float2(((i.pos.x))
				 // 	/ subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 1 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	return tex2D(_RealCam1, float2(((i.pos.x%subImageWidth))
				 // 	/ subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 2 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	//return tex2D(_RealCam2, float2(((i.pos.x%subImageWidth))
				 // 	/// subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 3 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	//return tex2D(_RealCam3, float2(((i.pos.x%subImageWidth))
				 // 	/// subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 4 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	//return tex2D(_RealCam4, float2(((i.pos.x%subImageWidth))
				 // 	/// subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 5 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	//return tex2D(_RealCam5, float2(((i.pos.x%subImageWidth))
				 // 	/// subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 6 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	//return tex2D(_RealCam6, float2(((i.pos.x%subImageWidth))
				 // 	/// subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 7 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	//return tex2D(_RealCam7, float2(((i.pos.x%subImageWidth))
				 // 	/// subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 8 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	return tex2D(_RealCam8, float2(((i.pos.x%subImageWidth))
				 // 	/ subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 9 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	return tex2D(_RealCam9, float2(((i.pos.x%subImageWidth))
				 // 	/ subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }

				 // else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 10 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	return tex2D(_RealCam10, float2(((i.pos.x%subImageWidth))
				 // 	/ subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 11 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	return tex2D(_RealCam11, float2(((i.pos.x%subImageWidth))
				 // 	/ subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 12 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	return tex2D(_RealCam12, float2(((i.pos.x%subImageWidth))
				 // 	/ subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 13 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	return tex2D(_RealCam13, float2(((i.pos.x%subImageWidth))
				 // 	/ subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 14 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	return tex2D(_RealCam14, float2(((i.pos.x%subImageWidth))
				 // 	/ subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }else if(i.pos.y > subImageWidth && i.pos.x < subImageWidth * 15 + subImageWidth && i.pos.y < subImageWidth * 7){
				 // 	return tex2D(_RealCam15, float2(((i.pos.x%subImageWidth))
				 // 	/ subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth))));
				 // }


				//Initializing values with extreme depth (these variables will be overwritten by the first calculations in the for-loop)
				outputCam0Value = float4(0.0,0.0,0.0,2.0);
				outputCam1Value = float4(0.0,0.0,0.0,2.0);
				outputCam2Value = float4(0.0,0.0,0.0,2.0);
				outputCam3Value = float4(0.0,0.0,0.0,2.0);

				loopDuration = 100;
				for (int j = 0; j <= loopDuration; j++)
				{



					//calculates the sub-image position from the current position of the fragment in screen space
					//look-up in the real camera +-half of the for-loop duration
					realCamera0Colors = tex2D(_Cam0, float2(((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))))
					/ subImageWidth, ((((i.pos.y % subImageWidth )) / subImageWidth))));

					realCamera1Colors = tex2D(_Cam1, float2(((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))))
					/ subImageWidth, ((((i.pos.y % subImageWidth  )) / subImageWidth))));

					realCamera2Colors = tex2D(_Cam2, float2(((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))))
					/ subImageWidth, ((((i.pos.y % subImageWidth  )) / subImageWidth))));

					realCamera3Colors = tex2D(_Cam3, float2(((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))))
					/ subImageWidth, ((((i.pos.y % subImageWidth  )) / subImageWidth))));


					//get z position in eye/view space
					eCam0.z = (realCamera0Colors.w) * (_farPlane);
					eCam1.z = (realCamera1Colors.w) * (_farPlane);
					eCam2.z = (realCamera2Colors.w) * (_farPlane);
					eCam3.z = (realCamera3Colors.w) * (_farPlane);

					//Convert from the projection plane to eye/view space
					eCam0.x = ( (((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam0.z)/_ImagePlaneLength;
					eCam0.x = eCam0.x - screenIndexX;



					eCam1.x = ( (((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam1.z)/_ImagePlaneLength;
					//The camera offset is the position of the camera realtive to the first camera cam0 minus one
					eCam1.x = eCam1.x - screenIndexX + 15.0;



					eCam2.x = ( (((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam2.z)/_ImagePlaneLength;
					//The camera offset is the position of the camera realtive to the first camera cam0 minus one
					eCam2.x = eCam2.x - screenIndexX + 15.0;



					eCam3.x = ( (((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam3.z)/_ImagePlaneLength;
					//The camera offset is the position of the camera realtive to the first camera cam0 minus one
					eCam3.x = eCam3.x - screenIndexX;


					//Convert back from eye/view space to the projection plane
					pCam0.x = -(_ImagePlaneLength * eCam0.x) / -eCam0.z;
					pCam0.x = pCam0.x + (subImageWidth/2.0);



					pCam1.x = -(_ImagePlaneLength * eCam1.x) / -eCam1.z;
					pCam1.x = pCam1.x + (subImageWidth/2.0);



					pCam2.x = -(_ImagePlaneLength * eCam2.x) / -eCam2.z;
					pCam2.x = pCam2.x + (subImageWidth/2.0);


					pCam3.x = -(_ImagePlaneLength * eCam3.x) / -eCam3.z;
					pCam3.x = pCam3.x + (subImageWidth/2.0);



					//position of our subimage on the screen
					currentSubImgPos.x = i.pos.x - (subImageWidth * (float)screenIndexX);


					//CAMERA 0
					//check if this distance between calculated value and the fragment position is less than half a pixel
					if(abs(pCam0.x - currentSubImgPos.x) < 0.5  && (i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) <= subImageWidth && (i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) >= 0.0) {
						//check if this depth value is less than the previous depth value (original depth = 2)
						if(outputCam0Value.w > realCamera0Colors.w){

								//read value from real camera texture
								//calculate difference between current subimage position and real camera position
								//this value is used in a subpixel look-up (linear interpolation)
								outputCam0Value = tex2D(_Cam0, float2((((i.pos.x % subImageWidth + ((float)j - ((float)loopDuration / 2.0))) + (currentSubImgPos.x - pCam0.x))) / subImageWidth, (((i.pos.y  ) / subImageWidth))));

								//texture look-up in the depth without linear interpolation
								outputCam0Value.w = tex2D(_Cam0, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) )) / subImageWidth, (((i.pos.y  ) / subImageWidth)))).w;
								// if((currentSubImgPos.x - pCam0.x) < 0.0){
								// 	outputCam0Value = float4(abs(currentSubImgPos.x - pCam0.x),0,0,1);
								// }else{
								// 	outputCam0Value = float4(0,abs(currentSubImgPos.x - pCam0.x),0,1);
								// }
						}
					}

					//CAMERA 1
					//check previous comments
					if(abs(pCam1.x - currentSubImgPos.x) < 0.5  && (i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) <= subImageWidth && (i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) >= 0.0) {
						if(outputCam1Value.w > realCamera1Colors.w){

								outputCam1Value = tex2D(_Cam1, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) - (currentSubImgPos.x - pCam1.x))) / subImageWidth, (((i.pos.y ) / subImageWidth))));

								outputCam1Value.w = tex2D(_Cam1, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) )) / subImageWidth, (((i.pos.y  ) / subImageWidth)))).w;
						}
					}

					//CAMERA 2
					//check previous comments
					if(abs(pCam2.x - currentSubImgPos.x) < 0.5  && (i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) <= subImageWidth && (i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) >= 0.0) {
						if(outputCam2Value.w > realCamera2Colors.w){

								outputCam2Value = tex2D(_Cam2, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) - (currentSubImgPos.x - pCam2.x))) / subImageWidth, (((i.pos.y - 700) / subImageWidth))));

								outputCam2Value.w = tex2D(_Cam2, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) )) / subImageWidth, (((i.pos.y % subImageWidth ) / subImageWidth)))).w;
						}
					}

					//CAMERA 3
					//check previous comments
					if(abs(pCam3.x - currentSubImgPos.x) < 0.5  && (i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) <= subImageWidth && (i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) >= 0.0) {
						if(outputCam3Value.w > realCamera3Colors.w){

								outputCam3Value = tex2D(_Cam3, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) - (currentSubImgPos.x - pCam3.x))) / subImageWidth, (((i.pos.y - 700 ) / subImageWidth))));

								outputCam3Value.w = tex2D(_Cam3, float2((((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))) )) / subImageWidth, (((i.pos.y % subImageWidth) / subImageWidth)))).w;
						}
					}
				}

				// float grayOutputCam2Value = (outputCam2Value.x + outputCam2Value.y + outputCam2Value.z) / 3.0;
				// float grayOutputCam3Value = (outputCam3Value.x + outputCam3Value.y + outputCam3Value.z) / 3.0;
				// if(outputCam2Value.w < outputCam3Value.w){
				// 	return outputCam2Value;
				// 	//return (grayOutputCam2Value + float4(0.3,0,0,0));
				// }
				// //return (grayOutputCam3Value + float4(0.0,0.3,0,0));
				// return outputCam3Value;

				//return outputCam0Value;

				if(i.pos.y < subImageWidth * 7 && i.pos.y > (subImageWidth * 7) - 15){
					//return float4(1,0,0,1);
				}

				//If none of the cameras can see the posnt (the point is occluded by the elements in the scene)
				if(outputCam0Value.w > 1.0 && outputCam1Value.w > 1.0 && outputCam2Value.w > 1.0 && outputCam3Value.w > 1.0){

					//return float4(0,0,1,1);
				}


				return(outputCam0Value);

				if(i.pos.y < subImageWidth + 15){
					//return(outputCam0Value);
					if(outputCam0Value.w <= outputCam1Value.w ){
					return(outputCam0Value);
					}
					if(outputCam1Value.w <= outputCam0Value.w){
					//return(outputCam1Value);
					}

				}

				if(i.pos.y < (subImageWidth * 8.0)  && i.pos.y > (subImageWidth * 7.0) - 15){

					//return(outputCam2Value);
					if(outputCam2Value.w <= outputCam3Value.w ){
					//	return(outputCam2Value);
					}
					 if(outputCam3Value.w <= outputCam2Value.w ){
					//	return(outputCam3Value);
					}
				}


				return float4(1,1,0,2);
			}
			ENDCG
		}
	}
}
