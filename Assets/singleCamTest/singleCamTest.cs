using UnityEngine;
using System.Collections;

public class singleCamTest : MonoBehaviour {

	private Material material;
	float ImagePlaneLength;
	public RenderTexture camZeroRenderTexture;
	public RenderTexture cleanCamZeroRenderTexture;
	public RenderTexture cleanCamOneRenderTexture;

	// Use this for initialization
	void Start () {
		material = new Material( Shader.Find("Custom/singleCamTest") );

		ImagePlaneLength = (Mathf.Sin(Mathf.Deg2Rad * (90 - (gameObject.GetComponent<Camera>().fieldOfView/2.0f))) 
			* (camZeroRenderTexture.height / 2.0f)) / Mathf.Sin(Mathf.Deg2Rad * (gameObject.GetComponent<Camera>().fieldOfView / 2.0f));
		print (ImagePlaneLength);
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
		material.SetFloat("_ImagePlaneLength", ImagePlaneLength);
		material.SetFloat("_nearPlane", gameObject.GetComponent<Camera>().nearClipPlane);
		material.SetFloat("_farPlane", gameObject.GetComponent<Camera>().farClipPlane);

		material.SetTexture ("_Cam0", camZeroRenderTexture);
		material.SetTexture ("_RealCam0", cleanCamZeroRenderTexture);
		material.SetTexture ("_RealCam1", cleanCamOneRenderTexture);

		Graphics.Blit (source, destination, material);
	}

}
