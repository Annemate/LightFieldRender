﻿using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class camInterpolation : MonoBehaviour {

		//[Range(0f, 30f)]
		public float dif = 0.5f;

		public bool clean = false;
		private Material material;

		private float renderTextureWidth;

		public RenderTexture camZeroRenderTexture;
		public RenderTexture camOneRenderTexture;
		public RenderTexture camTwoRenderTexture;
		public RenderTexture camThreeRenderTexture;


		public float ImagePlaneLength;
		private float ImagePlaneRatio;
		// Creates a private material used to the effect
		void Start ()
		{
			material = new Material( Shader.Find("Custom/camInterpolation") );
			print (Screen.width + " " + Screen.height);

			if(camZeroRenderTexture != null){
				if(camZeroRenderTexture.height != camZeroRenderTexture.width){
					print("Aspect ratio for cam 1 is not 1:1");
				}
			}

			if(camOneRenderTexture != null){
				if(camOneRenderTexture.height != camOneRenderTexture.width){
					print("Aspect ratio for cam 4 is not 1:1");
				}
			}
			if(camTwoRenderTexture != null){
				if(camTwoRenderTexture.height != camTwoRenderTexture.width){
					print("Aspect ratio for cam 2 is not 1:1");
				}
			}

			if(camThreeRenderTexture != null){
				if(camThreeRenderTexture.height != camThreeRenderTexture.width){
					print("Aspect ratio for cam 3 is not 1:1");
				}
			}



			foreach (Transform child in transform)
			{
				if(child.GetComponent<Camera>() != null){
					child.GetComponent<Camera>().fieldOfView   = gameObject.GetComponent<Camera>().fieldOfView;
					child.GetComponent<Camera>().nearClipPlane = gameObject.GetComponent<Camera>().nearClipPlane;
					child.GetComponent<Camera>().farClipPlane  = gameObject.GetComponent<Camera>().farClipPlane;
				}
			}

			// The length to the image plane in pixels given a fov.
			ImagePlaneLength = (Mathf.Sin(Mathf.Deg2Rad * (90 - (gameObject.GetComponent<Camera>().fieldOfView/2.0f))) * (camZeroRenderTexture.height / 2.0f)) / Mathf.Sin(Mathf.Deg2Rad * (gameObject.GetComponent<Camera>().fieldOfView / 2.0f));

			// The ratio between the lenght to the image plane and the cameras near clipping plane. Not used!
			//ImagePlaneRatio = ImagePlaneLength / gameObject.GetComponent<Camera>().nearClipPlane;

			//print(x1 / x2);

			//if(camOneRenderTexture.height + camTwoRenderTexture.height + camTreeRenderTexture.height + camFourRenderTexture.height == camOneRenderTexture.height * 4){
			//	renderTextureWidth = camOneRenderTexture.height;
			//}else{
			//	print("The resolution of the render textures are not the same");
			//}
		}


		// Postprocess the image
		void OnRenderImage (RenderTexture source, RenderTexture destination)
		{
			if (clean)
			{
				Graphics.Blit (source, destination);
				return;
			}
			material.SetFloat("_ImagePlaneLength", ImagePlaneLength);
			material.SetFloat("_nearPlane", gameObject.GetComponent<Camera>().nearClipPlane);
			material.SetFloat("_farPlane", gameObject.GetComponent<Camera>().farClipPlane);

			material.SetTexture ("_Cam0", camZeroRenderTexture);
			material.SetTexture ("_Cam1", camOneRenderTexture);
			material.SetTexture ("_Cam2", camTwoRenderTexture);
			material.SetTexture ("_Cam3", camThreeRenderTexture);


			material.SetFloat("_Dif", dif);

			//if(Time.frameCount%100 == 0)
			//print (Screen.width + " " + Screen.height);
			Graphics.Blit (source, destination, material);
		}
	}
