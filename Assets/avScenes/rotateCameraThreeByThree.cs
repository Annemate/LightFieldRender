using UnityEngine;
using System.Collections;

public class rotateCameraThreeByThree : MonoBehaviour {

	public GameObject target;
	bool start;
	Transform initial;
	public float speed = 0.1f;
	float tmpTime;
	// Use this for initialization
	void Start () {
		initial = transform;
	}

	// Update is called once per frame
	void Update () {
		if(Input.GetKeyUp("q")){
			start = true;
			tmpTime = Time.time;
		}

		if(start){
    		//childCamera.transform.position = Vector3.Lerp(fromObject.transform.position, toObject.transform.position, Time.time * speed * 8);

	        transform.rotation = Quaternion.Lerp(initial.rotation, target.transform.rotation, (Time.time - tmpTime) * speed);
	    }
	}
}
