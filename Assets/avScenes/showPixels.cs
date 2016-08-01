using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class showPixels : MonoBehaviour {

	bool state = false;
	public float initialdelay;
	public float interCameraDelay;
	int activationCounter;
	public List<GameObject> Pixels;
	// Use this for initialization
	void Start () {
		state = true;
	}

	// Update is called once per frame
	void Update () {

		if(Input.GetKeyUp("b")){
			state = true;
			initialdelay = Time.time;
		}

		if(state){
			if(Time.time > (interCameraDelay * activationCounter) + initialdelay){
				Pixels[activationCounter + 0].GetComponent<Renderer>().material.color = Color.black;
				Pixels[activationCounter + 1].GetComponent<Renderer>().material.color = Color.black;
				Pixels[activationCounter + 2].GetComponent<Renderer>().material.color = Color.black;
				Pixels[activationCounter + 3].GetComponent<Renderer>().material.color = Color.black;

				Pixels[activationCounter + 0].SetActive(true);
				Pixels[activationCounter + 1].SetActive(true);
				Pixels[activationCounter + 2].SetActive(true);
				Pixels[activationCounter + 3].SetActive(true);



				if(activationCounter > 0){
					//Pixels[activationCounter - 1].GetComponent<Renderer>().material.color = Color.red;
					//Pixels[activationCounter - 2].GetComponent<Renderer>().material.color = Color.red;
					//Pixels[activationCounter - 3].GetComponent<Renderer>().material.color = Color.red;
					//Pixels[activationCounter - 4].GetComponent<Renderer>().material.color = Color.red;


				}


				activationCounter += 4;



			}
		}

	}
}
