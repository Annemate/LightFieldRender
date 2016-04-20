Shader "Custom/camInterpolation" {

Properties {
		_Cam0 ("Cam0", 2D) = "white" {}
		_Cam1 ("Cam1", 2D) = "white" {}
		_Cam2 ("Cam2", 2D) = "white" {}
		_Cam3 ("Cam3", 2D) = "white" {}
		_DifX ("_DifX", float) = 0
		_DifY ("_DifX", float) = 0

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

	float _DifX;
	float _DifY;

	float4 _Cam0_TexelSize;

	float _ImagePlaneLength;

	float _nearPlane;
	float _farPlane;

	float4 realCamera0Colors;
	float4 realCamera1Colors;
	float4 realCamera2Colors;
	float4 realCamera3Colors;

	float4 tmpCam0Value;
	float4 tmpCam1Value;
	float4 tmpCam2Value;
	float4 tmpCam3Value;

	float ze;
	float xe;
	float ye;

	float ze1;
	float xe1;
	float ye1;

	float ze2;
	float xe2;
	float ye2;

	float ze3;
	float xe3;
	float ye3;

	float xp;
	float yp;

	float xp1;
	float yp1;

	float xp2;
	float yp2;

	float xp3;
	float yp3;

	int screenIndexX;
	int screenIndexY;

	float4 tmp1;
	float4 tmp2;

	int loopNumber;
	int loopOffset;

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

		loopNumber = 14;
		loopOffset = loopNumber / 2.0;


		//find screen index x
		screenIndexX = i.pos.x / (1.0/_Cam0_TexelSize.x);
		screenIndexY = i.pos.y / (1.0/_Cam0_TexelSize.x);

		tmpCam0Value = float4(0.0,0.0,0.0,2.0);
		tmpCam1Value = float4(0.0,0.0,0.0,2.0);
		tmpCam2Value = float4(0.0,0.0,0.0,2.0);
		tmpCam3Value = float4(0.0,0.0,0.0,2.0);

		//return tex2D(_Cam0, float2(((i.pos.x % (1.0/_Cam0_TexelSize.x) + 0 )) / (1.0/_Cam0_TexelSize.x), (-(i.pos.y * (_Cam0_TexelSize.x))) + 1.0)) + float4(0,0,0.5,1);

		//go through

		for(int j = loopNumber; j > 0; j--){

			//Look-up in tex2D
			realCamera0Colors = tex2D(_Cam0, float2(((i.pos.x % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) / (1.0/_Cam0_TexelSize.x), (-((i.pos.y % (1.0/_Cam0_TexelSize.x)) * (_Cam0_TexelSize.x))) + 1.0));


			realCamera1Colors = tex2D(_Cam1, float2(((i.pos.x % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) / (1.0/_Cam0_TexelSize.x), (-((i.pos.y % (1.0/_Cam0_TexelSize.x)) * (_Cam0_TexelSize.x))) + 1.0));

			realCamera2Colors = tex2D(_Cam2, float2(((i.pos.x % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) / (1.0/_Cam0_TexelSize.x), (-((i.pos.y % (1.0/_Cam0_TexelSize.x)) * (_Cam0_TexelSize.x))) + 1.0));

			realCamera3Colors = tex2D(_Cam3, float2(((i.pos.x % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) / (1.0/_Cam0_TexelSize.x), (-((i.pos.y % (1.0/_Cam0_TexelSize.x)) * (_Cam0_TexelSize.x))) + 1.0));

			//get z position in eye space
			ze  = (realCamera0Colors.w) * (_farPlane - _nearPlane) + _nearPlane;
			ze1 = (realCamera1Colors.w) * (_farPlane - _nearPlane) + _nearPlane;
			ze2 = (realCamera2Colors.w) * (_farPlane - _nearPlane) + _nearPlane;
			ze3 = (realCamera3Colors.w) * (_farPlane - _nearPlane) + _nearPlane;


			//Convert from projection space to eye space
			xe = ( (((i.pos.x % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) -((1.0/_Cam0_TexelSize.x) / 2.0)) * ze)/_ImagePlaneLength;
			xe = xe - (screenIndexX);

			ye = ( (((i.pos.y % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) -((1.0/_Cam0_TexelSize.x) / 2.0)) * ze)/_ImagePlaneLength;
			ye = ye - (screenIndexY);


			xe1 = ( (((i.pos.x % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) -((1.0/_Cam0_TexelSize.x) / 2.0)) * ze1)/_ImagePlaneLength;
			xe1 = xe1 -  (screenIndexX) + _DifX;

			ye1 = ( (((i.pos.y % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) -((1.0/_Cam0_TexelSize.x) / 2.0)) * ze1)/_ImagePlaneLength;
			ye1 = ye1 -  (screenIndexY) + _DifY;


			xe2 = ( (((i.pos.x % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) -((1.0/_Cam0_TexelSize.x) / 2.0)) * ze2)/_ImagePlaneLength;
			xe2 = xe2 -  (screenIndexX) + _DifX;

			ye2 = ( (((i.pos.y % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) -((1.0/_Cam0_TexelSize.x) / 2.0)) * ze2)/_ImagePlaneLength;
			ye2 = ye2 -  (screenIndexY) + _DifY;


			xe3 = ( (((i.pos.x % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) -((1.0/_Cam0_TexelSize.x) / 2.0)) * ze3)/_ImagePlaneLength;
			xe3 = xe3 -  (screenIndexX) + _DifX;

			ye3 = ( (((i.pos.y % (1.0/_Cam0_TexelSize.x) + j - loopOffset)) -((1.0/_Cam0_TexelSize.x) / 2.0)) * ze3)/_ImagePlaneLength;
			ye3 = ye3 -  (screenIndexY) + _DifY;




			//Convert back from eye space to projection space
			xp = -(_ImagePlaneLength * xe) / -ze;
			xp = xp + ((1.0/_Cam0_TexelSize.x)/2.0);

			yp = -(_ImagePlaneLength * ye) / -ze;
			yp = yp + ((1.0/_Cam0_TexelSize.x)/2.0);

			xp1 = -(_ImagePlaneLength * xe1) / -ze1;
			xp1 = xp1 + ((1.0/_Cam0_TexelSize.x)/2.0);

			yp1 = -(_ImagePlaneLength * ye1) / -ze1;
			yp1 = yp1 + ((1.0/_Cam0_TexelSize.x)/2.0);

			xp2 = -(_ImagePlaneLength * xe2) / -ze2;
			xp2 = xp2 + ((1.0/_Cam0_TexelSize.x)/2.0);

			yp2 = -(_ImagePlaneLength * ye2) / -ze2;
			yp2 = yp2 + ((1.0/_Cam0_TexelSize.x)/2.0);

			xp3 = -(_ImagePlaneLength * xe3) / -ze3;
			xp3 = xp3 + ((1.0/_Cam0_TexelSize.x)/2.0);

			yp3 = -(_ImagePlaneLength * ye3) / -ze3;
			yp3 = yp3 + ((1.0/_Cam0_TexelSize.x)/2.0);

			float lol = i.pos.x - (1.0/_Cam0_TexelSize.x) * screenIndexX;

			tmpCam0Value = lerp(tmpCam0Value, lerp(realCamera0Colors, tmpCam0Value, step(tmpCam0Value.w, realCamera0Colors.w)), step(abs(xp - lol), 1.01) * step() );
				tmpCam0Value += float4(0.8,0,0,0);

			tmpCam1Value = lerp(tmpCam1Value, lerp(realCamera1Colors, tmpCam1Value, step(tmpCam1Value.w, realCamera1Colors.w)), step(abs(xp1 - lol), 1.01) );
				tmpCam1Value += float4(0,0.8,0,0);

			tmpCam2Value = lerp(tmpCam2Value, lerp(realCamera2Colors, tmpCam2Value, step(tmpCam2Value.w, realCamera2Colors.w)), step(abs(xp2 - lol), 1.01) );
				//tmpCam2Value += float4(0.8,0,0.8,0);

			tmpCam3Value = lerp(tmpCam3Value, lerp(realCamera3Colors, tmpCam3Value, step(tmpCam3Value.w, realCamera3Colors.w)), step(abs(xp3 - lol), 1.01) );
				//tmpCam3Value += float4(0,0.8,0.8,0);

			//if(abs(lol2 - lol) <= 1) {
			//	if(tmpCam0Value.w > realCamera0Colors.w){
			//		tmpCam0Value = realCamera0Colors;
			//		tmpCam0Value += float4(0.8,0,0,0);

			//	}
			//}

			//if(abs(lol3 - lol) <= 1) {
			//	if(tmpCam1Value.w > realCamera1Colors.w){
			//		tmpCam1Value = realCamera1Colors;
			//		tmpCam1Value += float4(0,0.8,0,0);
			//	}
			//}

		}
		//	return tmpCam0Value;
		//tmp1 =
		return lerp(tmpCam0Value, tmpCam1Value, step(tmpCam1Value.w, tmpCam0Value.w));
		tmp2 = lerp(tmpCam2Value, tmpCam3Value, step(tmpCam3Value.w, tmpCam2Value.w));

		//return lerp(tmp1, tmp2, step(tmp2, tmp1));


		//if(tmpCam0Value.w < tmpCam1Value.w){
		//	return tmpCam0Value;
		//}
		//return tmpCam1Value;

	}


	ENDCG
	    }
	}
		FallBack "Diffuse"
}
