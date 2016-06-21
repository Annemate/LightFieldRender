using UnityEngine;
using System.Collections;

public class xyInterpolation : MonoBehaviour {

	private Material material;
	private float ImagePlaneLength;
	private float space;

	public RenderTexture camZeroRenderTexture;
	public RenderTexture camOneRenderTexture;
	public RenderTexture camTwoRenderTexture;
	public RenderTexture camThreeRenderTexture;

	// Use this for initialization
	void Start () {
		material = new Material( Shader.Find("Custom/xyInterpolation") );

		ImagePlaneLength = (Mathf.Sin(Mathf.Deg2Rad * (90 - (gameObject.GetComponent<Camera>().fieldOfView/2.0f)))
			* (camZeroRenderTexture.height / 2.0f)) / Mathf.Sin(Mathf.Deg2Rad * (gameObject.GetComponent<Camera>().fieldOfView / 2.0f));
		print (ImagePlaneLength);
	}

	// Update is called once per frame
	void Update() {
        /*if (Input.GetKeyUp("space")){
        	if(space < 1){
        		space = 2;
        	}else{
        		space = 0;
        	}
            print("space key was released");
        }*/

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

		Graphics.Blit (source, destination, material);
	}

}
