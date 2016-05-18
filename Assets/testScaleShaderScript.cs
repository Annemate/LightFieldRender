using UnityEngine;
using System.Collections;

public class testScaleShaderScript : MonoBehaviour {

	private Material material;

	public int ScreenOffsetX;
	public int ScreenOffsetY;
	public static int count = 0; //0 = black, 1 = interpolated image (II), 2 = virtual cameras (VC)

	public Texture2D black;
	public Texture2D interpolatedImage;
	public Texture2D virtualCamera;
	public Texture2D choose;


	// Use this for initialization
	void Start () {
		material = new Material( Shader.Find("Custom/ScaleShader") );

	}

	// Update is called once per frame
	void Update () {

	}

		void OnRenderImage (RenderTexture source, RenderTexture destination)
	{

		if(count == 0){
			material.SetTexture ("_SubImages", black);  
		}
		else if(count == 1){ 
			material.SetTexture ("_SubImages", interpolatedImage); 
		}
		else if(count == 2){
			material.SetTexture ("_SubImages", virtualCamera);
		}
		else if(count == 3){
			material.SetTexture ("_SubImages", choose);
		}

		material.SetFloat ("_SubImagesOffsetX", (float) ScreenOffsetX);
		material.SetFloat ("_SubImagesOffsetY", (float) ScreenOffsetY);
		Graphics.Blit (source, destination, material);
	}
}
