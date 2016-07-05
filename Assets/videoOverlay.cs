using UnityEngine;
using System.Collections;

public class videoOverlay : MonoBehaviour {

	public MovieTexture myMovie;
	// Use this for initialization
	void Start () {
		myMovie.loop = true;
		myMovie.Play();

	}

	void OnGUI()
	{
		GUI.DrawTexture(new Rect(0, 0, Screen.width, Screen.height), myMovie);
	}



	// Update is called once per frame
	void Update () {

	}
}
