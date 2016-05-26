using UnityEngine;
using System.Collections;
using System.IO;

public class SaveTextureToFile : MonoBehaviour {

	public RenderTexture textureToExport;
	private Texture2D myTexture;
	private Camera myCamera;
	private camMosaic myCameraScript;
	private bool captureIsRunning = false;
	private bool canStartCapture = true;
	private int imageCounter = 0;
	// Use this for initialization
	void Start () {

		myCameraScript = gameObject.GetComponent<camMosaic>();
		//captureIsRunning = true;

		myCamera = gameObject.GetComponent<Camera>();
		if(myCamera == null){
			print("script not attached to a camera");
		}else{
				print(myCamera.name);
		}



	}

	Texture2D GetRTPixels(RenderTexture rt)
     {
         RenderTexture currentActiveRT = RenderTexture.active;
         RenderTexture.active = rt;
         Texture2D tex = new Texture2D(rt.width, rt.height, TextureFormat.RGB24, true);
         tex.ReadPixels(new Rect(0, 0, tex.width, tex.height), 0, 0, false);
         RenderTexture.active = currentActiveRT;
         tex.Apply(true);
         return tex;
     }

	// Update is called once per frame
	void Update () {

		if (Input.GetKeyUp("space") && canStartCapture){
			captureIsRunning = true;
			canStartCapture = false;

			if(myCamera == null){
				myTexture = GetRTPixels(textureToExport);
				//myTexture.ReadPixels(textureToExport, 0,0);
				myTexture.Apply();
				byte[] bytes = myTexture.EncodeToPNG();
				File.WriteAllBytes(Application.dataPath + "/../SavedScreen" + Time.time + ".png", bytes);
				print("saved image");
				captureIsRunning = false;
				canStartCapture = true;
			}
		}


		if (captureIsRunning && imageCounter < 8 && myCamera != null){
			gameObject.transform.position = new Vector3(gameObject.transform.position.x, (float)imageCounter ,gameObject.transform.position.z);
			myCameraScript.yIndex = imageCounter + 2;
			myTexture = GetRTPixels(textureToExport);
			//myTexture.ReadPixels(textureToExport, 0,0);
			myTexture.Apply();
			byte[] bytes = myTexture.EncodeToPNG();
			File.WriteAllBytes(Application.dataPath + "/../SavedScreen" + Time.time + ".png", bytes);
			print("saved image " + (imageCounter + 1) + " : " + gameObject.transform.position.y);

			imageCounter ++;
		}else if(imageCounter >= 8 && myCamera != null){
			captureIsRunning = false;
			gameObject.transform.position = new Vector3(gameObject.transform.position.x, 0f ,gameObject.transform.position.z);
			myCameraScript.yIndex = 0;
			imageCounter = 0;
			print("capture completet");
			canStartCapture = true;
		}

	}
}
