using UnityEngine;
using System.Collections;
using XInputDotNetPure;

public class shake : MonoBehaviour {



	// Use this for initialization
	void Start () {
		//ActivateRumbler(0.5f,0.5f,0.5f);
	}

	public void ActivateRumbler(float leftForce, float rightForce, float duration){
		GamePad.SetVibration(0, leftForce, rightForce);
		StartCoroutine(Stop(duration));
	}

	IEnumerator Stop(float delay){

		yield return new WaitForSeconds(delay);

		GamePad.SetVibration(0, 0, 0);

	}

	// Update is called once per frame
	void Update () {

	}
}
