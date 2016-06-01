using UnityEngine;
using System.Collections;

public class scaleWithMovement : MonoBehaviour {

	public float scalefactor;
	// Use this for initialization
	void Start () {

	}

	// Update is called once per frame
	void Update () {
		transform.localScale = new Vector3(transform.position.z * scalefactor, transform.position.z * scalefactor, transform.position.z * scalefactor);

	}
}
