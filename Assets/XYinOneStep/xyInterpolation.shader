Shader "Custom/xyInterpolation"
{
	Properties
	{
		_Cam0 ("Cam0", 2D) = "white" {}
		_Cam1 ("Cam1", 2D) = "white" {}
		_Cam2 ("Cam2", 2D) = "white" {}
		_Cam3 ("Cam3", 2D) = "white" {}
		_Space ("Space", float) = 0

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

				cam0pos = float2(0,0);
				cam1pos = float2(14,0);
				cam2pos = float2(14,7);
				cam3pos = float2(0,7);

				if(_Space > 1){
					return float4(1,1,1,1);
				}

				//Initializing values


				subImageWidth = 1.0/_Cam0_TexelSize.x;
				screenIndexX = i.pos.x / subImageWidth;
				screenIndexY = i.pos.y / subImageWidth;

				float tmpX = screenIndexX;
				float tmpY = screenIndexY;
				// slope.x =  (cam1pos.y - cam0pos.y) / (cam1pos.x - cam0pos.x);
				// slope.y =  - (cam1pos.y - cam0pos.y) / ((cam2pos.x - cam0pos.x) - (cam1pos.x - cam0pos.x));
				// slope.z =  ((cam2pos.y - cam0pos.y) - (cam1pos.y - cam0pos.y)) / ((cam2pos.x - cam0pos.x) - (cam1pos.x - cam0pos.x));
				// slope.w =  - ((cam2pos.y - cam0pos.y) - ((cam1pos.y - cam0pos.y)) / (cam1pos.x - cam0pos.x));

				slope.x =  tmpY / tmpX;
				//slope.x = 1;
				slope.y =  - tmpY / (cam2pos.x - tmpX);
				slope.z =  (cam2pos.y - tmpY) / (cam2pos.x - tmpX);
				slope.w =  - (cam2pos.y - tmpY) / tmpX;

				//return float4(abs(slope.y), abs(slope.y), abs(slope.y), 1.0);

				//Initializing values with extreme depth (these variables will be overwritten by the first calculations in the for-loop)
				outputCam0Value = float4(1.0,0.0,0.0,2.0);
				outputCam1Value = float4(0.0,0.0,0.0,2.0);
				outputCam2Value = float4(0.0,1.0,0.0,2.0);
				outputCam3Value = float4(1.0,1.0,0.0,2.0);

				// //this section is used for finding the fov of the lens setup
				// if(screenIndexX == 7 && screenIndexY == 3){
				//  	return float4(0,1,0,1);
				//  }
				//  return float4(1,0,0,1);

				// // this section is used for aligning the lens to the screen½
				// if(screenIndexX % 2 == 0){
				// 	if(screenIndexY % 2 == 0){
				// 		return float4(0,0,0,1);
				// 	}
				// 	return float4(1,1,1,1);
				// }

				// if(screenIndexY % 2 != 0){
				// 	return float4(0,0,0,1);
				// }
				// return float4(1,1,1,1);
				float2 cam0tempPos;
				float2 cam1tempPos;
				float2 cam2tempPos;
				float2 cam3tempPos;


				loopDuration = 50;
				for (int j = 0; j <= loopDuration; j++)
				{
					//calculates the sub-image position from the current position of the fragment in screen space
					//look-up in the real camera +-half of the for-loop duration

					 //cam0
					 if(slope.x > 1.0){
						if(j%2 == 0 ){
							cam0tempPos.y = floor(j/2.0);
							cam0tempPos.x = ceil(floor(j/2.0) / slope.x);


						}
						else{
							cam0tempPos.y = floor(j/2.0);
							cam0tempPos.x = floor(floor(j/2.0) / slope.x);


						}
					}
					else{ //good for slopes under 1
						if(j%2 == 0.0 ){
							cam0tempPos.x = floor(j/2.0);
							cam0tempPos.y = ceil(floor(j/2.0) * slope.x);


						}
						else{
							cam0tempPos.x = floor(j/2.0);
							cam0tempPos.y = floor(floor(j/2.0) * slope.x);


						}
					}

					//cam1
					if(slope.y > -1.0){
						if(j%2 == 0 ){
							cam1tempPos.x = -floor(j/2.0);
							cam1tempPos.y = ceil(-floor(j/2.0) * slope.y);


						}
						else{
							cam1tempPos.x = -floor(j/2.0);
							cam1tempPos.y = floor(-floor(j/2.0) * slope.y);


						}
					}
					else{ //goo2 for slopes under 1
						if(j%2 == 0.0 ){
							cam1tempPos.y = floor(j/2.0);
							cam1tempPos.x = ceil(floor(j/2.0) / slope.y);


						}
						else{
							cam1tempPos.y = floor(j/2.0);
							cam1tempPos.x = floor(floor(j/2.0) / slope.y);


						}
					}

					//cam2
					if(slope.z < 1.0){
						if(j%2 == 0 ){
							cam2tempPos.x = -floor(j/2.0);
							cam2tempPos.y = ceil(-floor(j/2.0) * slope.z);


						}
						else{
							cam2tempPos.x = -floor(j/2.0);
							cam2tempPos.y = floor(-floor(j/2.0) * slope.z);


						}
					}
					else{ //goo2 for slopes under 1
						if(j%2 == 0.0 ){
							cam2tempPos.y = -floor(j/2.0);
							cam2tempPos.x = ceil(-floor(j/2.0) / slope.z);


						}
						else{
							cam2tempPos.y = -floor(j/2.0);
							cam2tempPos.x = floor(-floor(j/2.0) / slope.z);


						}
					}

					//cam3
					if(slope.w > -1.0){
						if(j%2 == 0 ){
							cam3tempPos.x = floor(j/2.0);
							cam3tempPos.y = ceil(floor(j/2.0) * slope.w);


						}
						else{
							cam3tempPos.x = floor(j/2.0);
							cam3tempPos.y = floor(floor(j/2.0) * slope.w);


						}
					}
					else{ //good for slopes under 1
						if(j%2 == 0.0 ){
							cam3tempPos.y = -floor(j/2.0);
							cam3tempPos.x = ceil(-floor(j/2.0) / slope.w);


						}
						else{
							cam3tempPos.y = -floor(j/2.0);
							cam3tempPos.x = floor(-floor(j/2.0) / slope.w);


						}
					}








					realCamera0Colors = tex2D(_Cam0, float2( ((i.pos.x % subImageWidth) + cam0tempPos.x) / subImageWidth, ((i.pos.y % subImageWidth) + cam0tempPos.y) / subImageWidth ));

					realCamera1Colors = tex2D(_Cam1, float2( ((i.pos.x % subImageWidth) + cam1tempPos.x) / subImageWidth, ((i.pos.y % subImageWidth) + cam1tempPos.y) / subImageWidth ));

					realCamera2Colors = tex2D(_Cam2, float2( ((i.pos.x % subImageWidth) + cam2tempPos.x) / subImageWidth, ((i.pos.y % subImageWidth) + cam2tempPos.y) / subImageWidth ));

					//realCamera1Colors = tex2D(_Cam1, float2( ((i.pos.x % subImageWidth) + cam1tempPos.x) / subImageWidth, ((i.pos.y % subImageWidth) + cam1tempPos.y) / subImageWidth ));

					realCamera3Colors = tex2D(_Cam3, float2( ((i.pos.x % subImageWidth) + cam3tempPos.x) / subImageWidth, ((i.pos.y % subImageWidth) + cam3tempPos.y) / subImageWidth ));



					//realCamera0Colors = tex2D(_Cam0, float2(((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) / subImageWidth, ((((i.pos.y % subImageWidth )) / subImageWidth))));

					//realCamera1Colors = tex2D(_Cam1, float2(((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))))/ subImageWidth, ((((i.pos.y % subImageWidth  )) / subImageWidth))));

					// realCamera2Colors = tex2D(_Cam2, float2(((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))))
					// / subImageWidth, ((((i.pos.y % subImageWidth  )) / subImageWidth))));

					// realCamera3Colors = tex2D(_Cam3, float2(((i.pos.x % subImageWidth + (j - (loopDuration / 2.0))))
					// / subImageWidth, ((((i.pos.y % subImageWidth  )) / subImageWidth))));


					//get z position in eye/view space
					eCam0.z = (realCamera0Colors.w) * (_farPlane);
					eCam1.z = (realCamera1Colors.w) * (_farPlane);
					eCam2.z = (realCamera2Colors.w) * (_farPlane);
					eCam3.z = (realCamera3Colors.w) * (_farPlane);

					//Convert from the projection plane to eye/view space
					eCam0.x = ( ((((i.pos.x % subImageWidth) + (cam0tempPos.x))) - (subImageWidth / 2.0)) * eCam0.z)/_ImagePlaneLength;
					eCam0.x = eCam0.x - screenIndexX;

					eCam0.y = ( ((((i.pos.y % subImageWidth) + (cam0tempPos.y))) - (subImageWidth / 2.0)) * eCam0.z)/_ImagePlaneLength;
					eCam0.y = eCam0.y - screenIndexY;

					eCam1.x = ( ((((i.pos.x % subImageWidth) + (cam1tempPos.x))) - (subImageWidth / 2.0)) * eCam1.z)/_ImagePlaneLength;
					eCam1.x = eCam1.x - screenIndexX + 14.0;

					eCam1.y = ( ((((i.pos.y % subImageWidth) + (cam1tempPos.y))) - (subImageWidth / 2.0)) * eCam1.z)/_ImagePlaneLength;
					eCam1.y = eCam1.y - screenIndexY;

					eCam2.x = ( ((((i.pos.x % subImageWidth) + (cam2tempPos.x))) - (subImageWidth / 2.0)) * eCam2.z)/_ImagePlaneLength;
					eCam2.x = eCam2.x - screenIndexX + 14.0;

					eCam2.y = ( ((((i.pos.y % subImageWidth) + (cam2tempPos.y))) - (subImageWidth / 2.0)) * eCam2.z)/_ImagePlaneLength;
					eCam2.y = eCam2.y - screenIndexY + 7.0;

					eCam3.x = ( ((((i.pos.x % subImageWidth) + (cam3tempPos.x))) - (subImageWidth / 2.0)) * eCam3.z)/_ImagePlaneLength;
					eCam3.x = eCam3.x - screenIndexX;

					eCam3.y = ( ((((i.pos.y % subImageWidth) + (cam3tempPos.y))) - (subImageWidth / 2.0)) * eCam3.z)/_ImagePlaneLength;
					eCam3.y = eCam3.y - screenIndexY + 7.0;



					// eCam1.x = ( (((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam1.z)/_ImagePlaneLength;
					// //The camera offset is the position of the camera realtive to the first camera cam0 minus one
					// eCam1.x = eCam1.x - screenIndexX + 14.0;



					// eCam2.x = ( (((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam2.z)/_ImagePlaneLength;
					// //The camera offset is the position of the camera realtive to the first camera cam0 minus one
					// eCam2.x = eCam2.x - screenIndexX + 14.0;



					// eCam3.x = ( (((i.pos.x % subImageWidth + (j - (loopDuration / 2.0)))) - (subImageWidth / 2.0)) * eCam3.z)/_ImagePlaneLength;
					// //The camera offset is the position of the camera realtive to the first camera cam0 minus one
					// eCam3.x = eCam3.x - screenIndexX;


					//Convert back from eye/view space to the projection plane
					pCam0.x = -(_ImagePlaneLength * eCam0.x) / -eCam0.z;
					pCam0.x = pCam0.x + (subImageWidth/2.0);

					pCam0.y = -(_ImagePlaneLength * eCam0.y) / -eCam0.z;
					pCam0.y = pCam0.y + (subImageWidth/2.0);

					pCam1.x = -(_ImagePlaneLength * eCam1.x) / -eCam1.z;
					pCam1.x = pCam1.x + (subImageWidth/2.0);

					pCam1.y = -(_ImagePlaneLength * eCam1.y) / -eCam1.z;
					pCam1.y = pCam1.y + (subImageWidth/2.0);

					pCam2.x = -(_ImagePlaneLength * eCam2.x) / -eCam2.z;
					pCam2.x = pCam2.x + (subImageWidth/2.0);

					pCam2.y = -(_ImagePlaneLength * eCam2.y) / -eCam2.z;
					pCam2.y = pCam2.y + (subImageWidth/2.0);

					pCam3.x = -(_ImagePlaneLength * eCam3.x) / -eCam3.z;
					pCam3.x = pCam3.x + (subImageWidth/2.0);

					pCam3.y = -(_ImagePlaneLength * eCam3.y) / -eCam3.z;
					pCam3.y = pCam3.y + (subImageWidth/2.0);


					//position of our subimage on the screen
					currentSubImgPos.x = i.pos.x - (subImageWidth * screenIndexX);
					currentSubImgPos.y = i.pos.y - (subImageWidth * screenIndexY);


					//CAMERA 0
					//check if this distance between calculated value and the fragment position is less than half a pixel
					if(abs(pCam0.x - currentSubImgPos.x) < 0.5  && ((i.pos.x % subImageWidth) + cam0tempPos.x) <= subImageWidth && abs(pCam0.y - currentSubImgPos.y) < 0.5  && ((i.pos.y % subImageWidth) + cam0tempPos.y) <= subImageWidth) {
						//check if this depth value is less than the previous depth value (original depth = 2)
						if(outputCam0Value.w > realCamera0Colors.w){

								//read value from real camera texture
								//calculate difference between current subimage position and real camera position
								//this value is used in a subpixel look-up (linear interpolation)

								outputCam0Value = tex2D(_Cam0, float2( (i.pos.x % subImageWidth + (currentSubImgPos.x - pCam0.x) + cam0tempPos.x) / subImageWidth, (i.pos.y % subImageWidth + (currentSubImgPos.y - pCam0.y) + cam0tempPos.y) / subImageWidth ));

								//outputCam0Value.w = realCamera0Colors.w;

								outputCam0Value.w = tex2D(_Cam0, float2( (i.pos.x % subImageWidth + (currentSubImgPos.x - pCam0.x) ) / subImageWidth, (i.pos.y % subImageWidth + (currentSubImgPos.y - pCam0.y) ) / subImageWidth )).w;


						}
					}

					//CAMERA 1
					//check if this distance between calculated value and the fragment position is less than half a pixel
					if(abs(pCam1.x - currentSubImgPos.x) < 0.5  && ((i.pos.x % subImageWidth) + cam1tempPos.x) <= subImageWidth && abs(pCam1.y - currentSubImgPos.y) < 0.5  && ((i.pos.y % subImageWidth) + cam1tempPos.y) <= subImageWidth) {
						//check if this depth value is less than the previous depth value (original depth = 2)
						if(outputCam1Value.w > realCamera1Colors.w){

								//read value from real camera texture
								//calculate difference between current subimage position and real camera position
								//this value is used in a subpixel look-up (linear interpolation)

								outputCam1Value = tex2D(_Cam1, float2( (i.pos.x % subImageWidth + (currentSubImgPos.x - pCam1.x) + cam1tempPos.x) / subImageWidth, (i.pos.y % subImageWidth + (currentSubImgPos.y - pCam1.y) + cam1tempPos.y) / subImageWidth ));

								//outputCam0Value.w = realCamera0Colors.w;

								outputCam1Value.w = tex2D(_Cam1, float2( (i.pos.x % subImageWidth + (currentSubImgPos.x - pCam1.x) ) / subImageWidth, (i.pos.y % subImageWidth + (currentSubImgPos.y - pCam1.y) ) / subImageWidth )).w;


						}
					}

					//CAMERA 2
					//check if this distance between calculated value and the fragment position is less than half a pixel
					if(abs(pCam2.x - currentSubImgPos.x) < 0.5  && ((i.pos.x % subImageWidth) + cam2tempPos.x) <= subImageWidth && abs(pCam2.y - currentSubImgPos.y) < 0.5  && ((i.pos.y % subImageWidth) + cam2tempPos.y) <= subImageWidth) {
						//check if this depth value is less than the previous depth value (original depth = 2)
						if(outputCam2Value.w > realCamera2Colors.w){

								//read value from real camera texture
								//calculate difference between current subimage position and real camera position
								//this value is used in a subpixel look-up (linear interpolation)

								outputCam2Value = tex2D(_Cam2, float2( (i.pos.x % subImageWidth + (currentSubImgPos.x - pCam2.x) + cam2tempPos.x) / subImageWidth, (i.pos.y % subImageWidth + (currentSubImgPos.y - pCam2.y) + cam2tempPos.y) / subImageWidth ));

								//outputCam0Value.w = realCamera0Colors.w;

								outputCam2Value.w = tex2D(_Cam2, float2( (i.pos.x % subImageWidth + (currentSubImgPos.x - pCam2.x) ) / subImageWidth, (i.pos.y % subImageWidth + (currentSubImgPos.y - pCam2.y) ) / subImageWidth )).w;


						}
					}

					//Camera3
					if(abs(pCam3.x - currentSubImgPos.x) < 0.5  && ((i.pos.x % subImageWidth) + cam3tempPos.x) <= subImageWidth && abs(pCam3.y - currentSubImgPos.y) < 0.5  && ((i.pos.y % subImageWidth) + cam3tempPos.y) <= subImageWidth) {
						//check if this depth value is less than the previous depth value (original depth = 2)
						if(outputCam3Value.w > realCamera3Colors.w){

								//read value from real camera texture
								//calculate difference between current subimage position and real camera position
								//this value is used in a subpixel look-up (linear interpolation)

								outputCam3Value = tex2D(_Cam3, float2( (i.pos.x % subImageWidth + (currentSubImgPos.x - pCam3.x) + cam3tempPos.x) / subImageWidth, (i.pos.y % subImageWidth + (currentSubImgPos.y - pCam3.y) + cam3tempPos.y) / subImageWidth ));

								//outputCam0Value.w = realCamera0Colors.w;

								outputCam3Value.w = tex2D(_Cam3, float2( (i.pos.x % subImageWidth + (currentSubImgPos.x - pCam3.x) ) / subImageWidth, (i.pos.y % subImageWidth + (currentSubImgPos.y - pCam3.y) ) / subImageWidth )).w;

						}
					}
				}

				if(i.pos.y < subImageWidth * 7 && i.pos.y > (subImageWidth * 7) - 15){
					//return float4(1,0,0,1);
				}

				//If none of the cameras can see the point (the point is occluded by the elements in the scene)
				if(outputCam0Value.w > 1.0 && outputCam1Value.w > 1.0 && outputCam2Value.w > 1.0 && outputCam3Value.w > 1.0){

					//return float4(0,0,1,1);
				}

				return(outputCam1Value);

				if(i.pos.y < subImageWidth + 15 && screenIndexX < 8){
					//return(outputCam0Value);
					if(outputCam0Value.w <= outputCam1Value.w ){
					return(outputCam0Value);
					}
					if(outputCam1Value.w <= outputCam0Value.w){
					return(outputCam1Value);
					}

				}

				if(i.pos.y < subImageWidth + 15 && screenIndexX > 7){
					//return(outputCam0Value);
					if(outputCam1Value.w <= outputCam0Value.w ){
					return(outputCam1Value);
					}
					if(outputCam0Value.w <= outputCam1Value.w){
					return(outputCam0Value);
					}

				}

				if(i.pos.y < (subImageWidth * 8.0)  && i.pos.y > (subImageWidth * 7.0) - 15 && screenIndexX < 8){

					//return(outputCam2Value);
					if(outputCam3Value.w <= outputCam2Value.w ){
						return(outputCam3Value);
					}
					 if(outputCam2Value.w <= outputCam3Value.w ){
						return(outputCam2Value);
					}
				}

				if(i.pos.y < (subImageWidth * 8.0)  && i.pos.y > (subImageWidth * 7.0) - 15 && screenIndexX > 7){

					//return(outputCam2Value);
					if(outputCam2Value.w <= outputCam3Value.w ){
						return(outputCam2Value);
					}
					 if(outputCam3Value.w <= outputCam2Value.w ){
						return(outputCam3Value);
					}
				}


				return float4(1,1,0,2);
			}
			ENDCG
		}
	}
}
