using UnityEngine;
using System.Collections;

public class testScaleShaderScript : MonoBehaviour {

	private Material material;

	public int ScreenOffsetX;
	public int ScreenOffsetY;
	public static int count = 0; //0 = black, 1 = interpolated image (II), 2 = virtual cameras (VC)
	public float ScaleX;

	public Texture2D black;
	public Texture2D interpolatedImageOne;
	public Texture2D interpolatedImageTwo;
	public Texture2D interpolatedImageThree;
	public Texture2D interpolatedImageFour;
	public Texture2D interpolatedImageFive;

	public Texture2D virtualCameraOne;
	public Texture2D virtualCameraTwo;
	public Texture2D virtualCameraThree;
	public Texture2D virtualCameraFour;
	public Texture2D virtualCameraFive;

	public Texture2D screenInterpolatedImageOne;
	public Texture2D screenInterpolatedImageTwo;
	public Texture2D screenInterpolatedImageThree;
	public Texture2D screenInterpolatedImageFour;
	public Texture2D screenInterpolatedImageFive;

	public Texture2D screenVirtualCameraOne;
	public Texture2D screenVirtualCameraTwo;
	public Texture2D screenVirtualCameraThree;
	public Texture2D screenVirtualCameraFour;
	public Texture2D screenVirtualCameraFive;

	public Texture2D choose;
	public Texture2D thankYou;


	// Use this for initialization
	void Start () {
		material = new Material( Shader.Find("Custom/ScaleShader") );

	}

	// Update is called once per frame
	void Update () {

	}

	void OnGUI(){
		switch(count){
			case 13:
			 GUI.DrawTexture(new Rect(440, 160, 400,400), screenInterpolatedImageOne);
			 break;
			case 14:
			 GUI.DrawTexture(new Rect(440, 160, 400,400), screenVirtualCameraOne);
			 break;
			case 15:
			 GUI.DrawTexture(new Rect(440, 160, 400,400), screenInterpolatedImageTwo);
			 break;
			case 16:
			 GUI.DrawTexture(new Rect(440, 160, 400,400), screenVirtualCameraTwo);
			 break;
			case 17:
			 GUI.DrawTexture(new Rect(440, 160, 400,400), screenInterpolatedImageThree);
			 break;
			case 18:
			 GUI.DrawTexture(new Rect(440, 160, 400,400), screenVirtualCameraThree);
			 break;
			case 19:
			 GUI.DrawTexture(new Rect(440, 160, 400,400), screenInterpolatedImageFour);
			 break;
			case 20:
			 GUI.DrawTexture(new Rect(440, 160, 400,400), screenVirtualCameraFour);
			 break;
			case 21:
			 GUI.DrawTexture(new Rect(440, 160, 400,400), screenInterpolatedImageFive);
			 break;
			case 22:
			 GUI.DrawTexture(new Rect(440, 160, 400,400), screenVirtualCameraFive);
			 break;

		}

	}

		void OnRenderImage (RenderTexture source, RenderTexture destination)
	{

		if (count == 0) {
			material.SetTexture ("_SubImages", black);
		} else if (count == 1) {
			material.SetTexture ("_SubImages", choose);
		} else if (count == 2) {
			material.SetTexture ("_SubImages", thankYou);
		}else if(count == 3){
			material.SetTexture ("_SubImages", interpolatedImageOne);
		}else if(count == 4){
			material.SetTexture ("_SubImages", virtualCameraOne);
		}else if(count == 5){
			material.SetTexture ("_SubImages", interpolatedImageTwo);
		}else if(count == 6){
			material.SetTexture ("_SubImages", virtualCameraTwo);
		}else if(count == 7){
			material.SetTexture ("_SubImages", interpolatedImageThree);
		}else if(count == 8){
			material.SetTexture ("_SubImages", virtualCameraThree);
		}else if(count == 9){
			material.SetTexture ("_SubImages", interpolatedImageFour);
		}else if(count == 10){
			material.SetTexture ("_SubImages", virtualCameraFour);
		}else if(count == 11){
			material.SetTexture ("_SubImages", interpolatedImageFive);
		}else if(count == 12){
			material.SetTexture ("_SubImages", virtualCameraFive);
		}else{
			material.SetTexture ("_SubImages", black);
		}

		material.SetFloat("_testX", ScaleX);
		material.SetFloat ("_SubImagesOffsetX", (float) ScreenOffsetX);
		material.SetFloat ("_SubImagesOffsetY", (float) ScreenOffsetY);
		Graphics.Blit (source, destination, material);
	}
}
