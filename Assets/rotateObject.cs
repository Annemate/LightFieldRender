using UnityEngine;
using System.Collections;

public class rotateObject : MonoBehaviour {

	public Vector3 directionAndSpeed;
	// Use this for initialization
	void Start () {

	}

	// Update is called once per frame
	void Update()
    {
        // Rotate the object around its local Y axis at 1 degree per second
        transform.Rotate(directionAndSpeed * Time.deltaTime);

        // ...also rotate around the World's Y axis
       // transform.Rotate(Vector3.up * Time.deltaTime, Space.World);
    }
}
