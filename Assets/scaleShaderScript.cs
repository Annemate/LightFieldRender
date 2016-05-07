using UnityEngine;
using System.Collections;

public class scaleShaderScript : MonoBehaviour {

	private Material material;
	public RenderTexture subImageTexture;
	public int ScreenOffsetX;
	public int ScreenOffsetY;


	// Use this for initialization
	void Start () {
		material = new Material( Shader.Find("Custom/ScaleShader") );

	}

	// Update is called once per frame
	void Update () {

	}

		void OnRenderImage (RenderTexture source, RenderTexture destination)
	{


		material.SetTexture ("_SubImages", subImageTexture);
		material.SetFloat ("_SubImagesOffsetX", (float) ScreenOffsetX);
		material.SetFloat ("_SubImagesOffsetY", (float) ScreenOffsetY);
		Graphics.Blit (source, destination, material);
	}
}
