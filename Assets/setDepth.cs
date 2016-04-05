using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class setDepth : MonoBehaviour {

	private Material material;

	// Use this for initialization

	void Start () {
		gameObject.GetComponent<Camera>().depthTextureMode = DepthTextureMode.Depth;
//		camera.GetComponent<depthTextureMode>() = DepthTextureMode.Depth;
		material = new Material( Shader.Find("Custom/DepthShader") );

	}

	// Update is called once per frame
	void Update () {

	}

	void OnRenderImage (RenderTexture source, RenderTexture destination)
		{

		//material.SetFloat("_ImagePlaneLength", ImagePlaneLength);
		//material.SetFloat("_nearPlane", gameObject.GetComponent<Camera>().nearClipPlane);
		//material.SetFloat("_farPlane", gameObject.GetComponent<Camera>().farClipPlane);

		//material.SetTexture ("_Cam0", camZeroRenderTexture);
		//material.SetTexture ("_Cam1", camOneRenderTexture);
		//material.SetTexture ("_Cam2", camTwoRenderTexture);
		//material.SetTexture ("_Cam3", camThreeRenderTexture);


		//material.SetFloat("_Dif", dif);

			//if(Time.frameCount%100 == 0)
			//print (Screen.width + " " + Screen.height);
			Graphics.Blit (source, destination, material);
		}

}
