using UnityEngine;
using System.Collections;

public class videoOverlay : MonoBehaviour {

	//public MovieTexture myMovie;
	private Material material;
	public Texture2D emptyOverlayImage;
	public Texture2D overlayImage;
	private bool showOverlay = false;
	private bool canCheckButton = true;
	private float buttonCheckDelay = 1f;
	// Use this for initialization
	void Start () {
		//myMovie.loop = true;
		//myMovie.Play();
		material = new Material( Shader.Find("Custom/ScaleShader") );
	}

	void OnGUI()
	{
		if(showOverlay){
			//GUI.DrawTexture(new Rect(20, 20,20+ Screen.width,20+ Screen.height), myMovie);
			GUI.DrawTexture(new Rect(40, 21, 1205,643), overlayImage);
			//GUI.DrawTexture(new Rect(20, 20,20+ Screen.width,20+ Screen.height), overlayImage);
		}
	}

	void StartOverlay(){
		//myMovie.Play();
		showOverlay = true;

	}

	void StopOverlay(){
		showOverlay = false;
		//myMovie.Stop();
	}

	void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
		if(showOverlay){
			material.SetTexture ("_SubImages", overlayImage);
		}else{
			material.SetTexture ("_SubImages", emptyOverlayImage);
		}
	}


	// Update is called once per frame
	void Update () {
		if (Input.GetKeyDown("v") && canCheckButton){
			StartCoroutine(CanCheckButtonDelay(buttonCheckDelay));
			if(showOverlay){
				StopOverlay();
			}else{
				StartOverlay();
			}
		}
	}

	IEnumerator CanCheckButtonDelay(float delay){
		canCheckButton = false;
		yield return new WaitForSeconds(delay);
		canCheckButton = true;

	}

}
