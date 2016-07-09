using UnityEngine;
using System.Collections;

public class modeSvitcherForCalibration : MonoBehaviour {

	public GameObject myInterpolation;
	public GameObject myVirtual;
	private bool myState = true;
	void ActivateInterpolation(bool state){
		if(state){
			myInterpolation.SetActive(false);
			myVirtual.SetActive(true);
		}else{
			myInterpolation.SetActive(true);
			myVirtual.SetActive(false);
		}
	}
	// Use this for initialization
	void Start () {
		ActivateInterpolation(myState);
	}

	// Update is called once per frame
	void Update () {
		if (Input.GetKeyUp("space")){
			myState = !myState;
			ActivateInterpolation(myState);

		}

	}
}
