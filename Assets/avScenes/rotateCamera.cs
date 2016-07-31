using UnityEngine;
using System.Collections;

public class rotateCamera : MonoBehaviour {

	public GameObject childCamera;
     Transform from;
     Transform CameraPosition;
    public Transform to;
    int state = 0;
    public float speed = 0.1F;

    void Start(){
    	//childCamera = transform.GetChild(0).GetComponent<GameObject>();
    	CameraPosition = childCamera.transform;
    	from = transform;
    }
    void Update() {
    	if(childCamera.transform.position.y < 60 && state == 0){
		    childCamera.transform.Translate(Vector3.back * Time.deltaTime * 8);
	        transform.rotation = Quaternion.Lerp(from.rotation, to.rotation, Time.time * speed);
	    }

	    if(childCamera.transform.position.x < 8 && state == 1){
		 	childCamera.transform.position = Vector3.Lerp(childCamera.transform.position, childCamera.transform.position + new Vector3(16,0,0), Time.time * speed);
		  //  childCamera.transform.Translate(Vector3.right * Time.deltaTime * 5);
	    }

	    if(childCamera.transform.position.y > 0 && state == 2){
		    childCamera.transform.Translate(Vector3.forward * Time.deltaTime * 8);
	        transform.rotation = Quaternion.Lerp(to.rotation, from.rotation, Time.time * speed);
	    }

        if(Input.GetKeyUp("space") && state == 0){
			state = 1;
		}

		if(Input.GetKeyUp("a") && state == 1){
			state = 2;

		}
    }
}
