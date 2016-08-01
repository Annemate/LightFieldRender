using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class showPixels : MonoBehaviour {

	bool state = false;
	public float initialdelay;
	public float interCameraDelay;
	int activationCounter;
	public List<GameObject> Pixels;
	public GameObject realPixel;
	// Use this for initialization
	void Start () {
		realPixel.GetComponent<Renderer>().material.color = Color.green;
		state = true;
		for(int i = 0; i < Pixels.Count; i++){
				Pixels[i].SetActive(false);
				//Pixels[i].transform.position += new Vector3(0f,0.1f*i,0f);
		}
	}

	// Update is called once per frame
	void Update () {

		if(Input.GetKeyUp("b")){
			state = true;
			initialdelay = Time.time;

		}

		if(state){
			if(Time.time > (interCameraDelay * activationCounter) + initialdelay){

				Pixels[activationCounter].GetComponent<Renderer>().material.color = Color.black;
				Pixels[activationCounter].SetActive(true);

				if(activationCounter == Pixels.Count - 1){
					Pixels[activationCounter].GetComponent<Renderer>().material.color = Color.green;
					state = false;
					Pixels[activationCounter - 1].GetComponent<Renderer>().material.color = Color.red;
				}
				else if(activationCounter > 0){
					Pixels[activationCounter - 1].GetComponent<Renderer>().material.color = Color.red;

				}

				activationCounter ++;

			}
		}

	}
}
