using UnityEngine;
using System.Collections;

public class addInitialForce : MonoBehaviour {

	Rigidbody MyBody;
	// Use this for initialization
	void Start () {
		MyBody = gameObject.GetComponent<Rigidbody>();
	//	MyBody.AddForce(new Vector3(1,0,0));
		transform.position += new Vector3(2,0,0);
	}

	// Update is called once per frame
	void Update () {

	}
}
