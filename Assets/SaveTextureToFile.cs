using UnityEngine;
using System.Collections;
using System.IO;

public class SaveTextureToFile : MonoBehaviour {

	public RenderTexture textureToExport;
	private Texture2D myTexture;
	// Use this for initialization
	void Start () {


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
		if (Input.GetKeyUp("space")){
			myTexture = GetRTPixels(textureToExport);
			//myTexture.ReadPixels(textureToExport, 0,0);
			myTexture.Apply();
			byte[] bytes = myTexture.EncodeToPNG();
			File.WriteAllBytes(Application.dataPath + "/../SavedScreen" + Time.time + ".png", bytes);
			print("saved image");
		}

	}
}
