using UnityEngine;
using System.Collections;
using System;
using System.IO;
using System.Collections.Generic;

public class screenShotWithFactorOnStart : MonoBehaviour {

	// Use this for initialization
	void Start () {
		//Application.CaptureScreenshot("Screenshot.png",1);
		//StartCoroutine(DelayedScreenShot());
	}

	IEnumerator DelayedScreenShot() {

        yield return new WaitForSeconds(3);
        Application.CaptureScreenshot("Screenshot.png",1);
    }

	// Update is called once per frame
	void Update () {
		if (Input.GetKeyDown("space")){
			Application.CaptureScreenshot("Screenshot.png",1);
		}
	}
}
