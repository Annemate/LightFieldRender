using UnityEngine;
using System.Collections;

public class camMosaic : MonoBehaviour {

	private Material material;

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

	public int yIndex;

	// Use this for initialization
	void Start () {
		material = new Material( Shader.Find("Custom/camMosaic") );
	}

	// Update is called once per frame
	void Update () {

	}

		void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
		material.SetTexture ("_RealCam0",  realCam0RenderTexture);
		material.SetTexture ("_RealCam1",  realCam1RenderTexture);
		material.SetTexture ("_RealCam2",  realCam2RenderTexture);
		material.SetTexture ("_RealCam3",  realCam3RenderTexture);
		material.SetTexture ("_RealCam4",  realCam4RenderTexture);
		material.SetTexture ("_RealCam5",  realCam5RenderTexture);
		material.SetTexture ("_RealCam6",  realCam6RenderTexture);
		material.SetTexture ("_RealCam7",  realCam7RenderTexture);
		material.SetTexture ("_RealCam8",  realCam8RenderTexture);
		material.SetTexture ("_RealCam9",  realCam9RenderTexture);
		material.SetTexture ("_RealCam10", realCam10RenderTexture);
		material.SetTexture ("_RealCam11", realCam11RenderTexture);
		material.SetTexture ("_RealCam12", realCam12RenderTexture);
		material.SetTexture ("_RealCam13", realCam13RenderTexture);
		material.SetTexture ("_RealCam14", realCam14RenderTexture);
		material.SetFloat("_offset", (float)yIndex);



		Graphics.Blit (source, destination, material);
	}
}
