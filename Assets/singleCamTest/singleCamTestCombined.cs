using UnityEngine;
using System.Collections;

public class singleCamTestCombined : MonoBehaviour {

	private Material material;
	float ImagePlaneLength;
	public RenderTexture camZeroRenderTexture;
	public RenderTexture camOneRenderTexture;
	public RenderTexture camTwoRenderTexture;
	public RenderTexture camThreeRenderTexture;
	float space;
//	public RenderTexture cleanCamZeroRenderTexture;
//	public RenderTexture cleanCamOneRenderTexture;

	public RenderTexture xAxisOnly;
	public RenderTexture realCam0RenderTexture;
	public RenderTexture realCam1RenderTexture;
	public RenderTexture realCam2RenderTexture;
	public RenderTexture realCam3RenderTexture;
	public RenderTexture realCam4RenderTexture;
	public RenderTexture realCam5RenderTexture;
	public RenderTexture realCam6RenderTexture;
	public RenderTexture realCam7RenderTexture;
	public RenderTexture realCam8RenderTexture;
	public RenderTexture realCam9RenderTexture;

	public RenderTexture realCam10RenderTexture;
	public RenderTexture realCam11RenderTexture;
	public RenderTexture realCam12RenderTexture;
	public RenderTexture realCam13RenderTexture;
	public RenderTexture realCam14RenderTexture;
	public RenderTexture realCam15RenderTexture;

	// Use this for initialization
	void Start () {
		material = new Material( Shader.Find("Custom/singleCamTestCombined") );

		ImagePlaneLength = (Mathf.Sin(Mathf.Deg2Rad * (90 - (gameObject.GetComponent<Camera>().fieldOfView/2.0f)))
			* (camZeroRenderTexture.height / 2.0f)) / Mathf.Sin(Mathf.Deg2Rad * (gameObject.GetComponent<Camera>().fieldOfView / 2.0f));
		print (ImagePlaneLength);
	}

	// Update is called once per frame
	void Update() {
        if (Input.GetKeyUp("space")){
        	if(space < 1){
        		space = 2;
        	}else{
        		space = 0;
        	}
            print("space key was released");
        }

    }



	void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
		material.SetFloat("_ImagePlaneLength", ImagePlaneLength);
		material.SetFloat("_nearPlane", gameObject.GetComponent<Camera>().nearClipPlane);
		material.SetFloat("_farPlane", gameObject.GetComponent<Camera>().farClipPlane);
		material.SetFloat("_Space", space);

		material.SetTexture ("_Cam0", camZeroRenderTexture);
		material.SetTexture ("_Cam1", camOneRenderTexture);
		material.SetTexture ("_Cam2", camTwoRenderTexture);
		material.SetTexture ("_Cam3", camThreeRenderTexture);
	//	material.SetTexture ("_RealCam0", cleanCamZeroRenderTexture);
	//	material.SetTexture ("_RealCam1", cleanCamOneRenderTexture);

		material.SetTexture ("_RealCam0", realCam0RenderTexture);
		material.SetTexture ("_RealCam1", realCam1RenderTexture);
		material.SetTexture ("_RealCam2", realCam2RenderTexture);
		material.SetTexture ("_RealCam3", realCam3RenderTexture);
		material.SetTexture ("_RealCam4", realCam4RenderTexture);
		material.SetTexture ("_RealCam5", realCam5RenderTexture);
		material.SetTexture ("_RealCam6", realCam6RenderTexture);
		material.SetTexture ("_RealCam7", realCam7RenderTexture);
		material.SetTexture ("_RealCam8", realCam8RenderTexture);
		material.SetTexture ("_RealCam9", realCam9RenderTexture);
		material.SetTexture ("_RealCam10", realCam10RenderTexture);
		material.SetTexture ("_RealCam11", realCam11RenderTexture);
		material.SetTexture ("_RealCam12", realCam12RenderTexture);
		material.SetTexture ("_RealCam13", realCam13RenderTexture);
		material.SetTexture ("_RealCam14", realCam14RenderTexture);
		material.SetTexture ("_RealCam15", realCam15RenderTexture);
		material.SetTexture("_xAxisTexture", xAxisOnly);

		Graphics.Blit (source, destination, material);
	}

}
