using UnityEngine;
using System.Collections;

public class videoOverlay : MonoBehaviour {

	public MovieTexture myMovie;
	private bool showOverlay = false;
	private bool canCheckButton = true;
	private float buttonCheckDelay = 1f;
	// Use this for initialization
	void Start () {
		myMovie.loop = true;
		myMovie.Play();

	}

	void OnGUI()
	{
		if(showOverlay){
			GUI.DrawTexture(new Rect(20, 20,20+ Screen.width,20+ Screen.height), myMovie);
		}
	}

	void StartOverlay(){
		myMovie.Play();
		showOverlay = true;

	}

	void StopOverlay(){
		showOverlay = false;
		myMovie.Stop();
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
