using UnityEngine;
using System.Collections;
using XInputDotNetPure;

public class shake : MonoBehaviour {

	public float etllerandet1;
	public float etllerandet2;

	// Use this for initialization
	void Start () {
	// Set vibration according to triggers
        
	}
	
	// Update is called once per frame
	void Update () {
		GamePad.SetVibration(0, etllerandet1, etllerandet2);
	}
}
