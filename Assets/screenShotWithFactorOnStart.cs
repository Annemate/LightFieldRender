using UnityEngine;
using System.Collections;

public class screenShotWithFactorOnStart : MonoBehaviour {

	// Use this for initialization
	void Start () {
		Application.CaptureScreenshot("Screenshot.png",3);
	}

	// Update is called once per frame
	void Update () {

	}
}
