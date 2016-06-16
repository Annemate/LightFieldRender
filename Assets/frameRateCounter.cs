using UnityEngine;
using System.Collections;

public class frameRateCounter : MonoBehaviour {

	private float[] frameArray;
	private int frameCounter;
	private bool printOnce = true;
	private float arraySum;
	// Use this for initialization
	void Start () {
		frameArray = new float[100];
	}

	// Update is called once per frame
	void Update () {
		if(frameCounter < frameArray.Length){
			//print(frameCounter);
			frameArray[frameCounter] = Time.deltaTime;
			frameCounter ++;
		}else if(printOnce){
			printOnce = false;
			for(int i = 0; i < frameArray.Length; i ++){
				print(frameArray[i]);
				arraySum += frameArray[i];
			}
			print("mean is: " + arraySum / frameArray.Length);
			print("fps is: " +  1.0 / (arraySum / frameArray.Length));
		}

	}
}
