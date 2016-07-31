using UnityEngine;
using System.Collections;

public class rotateCamera : MonoBehaviour {

	public GameObject childCamera;
	public GameObject fromObject;
	public GameObject toObject;
     Transform from;
     Transform CameraPosition;
    public Transform to;
    float tmpTime;
    int state = 0;
    public float speed = 0.1F;

    void Start(){
    	//childCamera = transform.GetChild(0).GetComponent<GameObject>();
    	CameraPosition = childCamera.transform;
    	from = transform;
    }
    void Update() {
    	if(childCamera.transform.position.y < 60 && state == 0){
    		childCamera.transform.position = Vector3.Lerp(fromObject.transform.position, toObject.transform.position, Time.time * speed * 8);
		    //childCamera.transform.Translate(Vector3.back * Time.deltaTime * 8);
	        transform.rotation = Quaternion.Lerp(from.rotation, to.rotation, Time.time * speed);
	    }

	    if(childCamera.transform.position.x < 8 && state == 1){
		 	childCamera.transform.position = Vector3.Lerp(childCamera.transform.position, childCamera.transform.position + new Vector3(16,0,0), Time.time * speed);
		  //  childCamera.transform.Translate(Vector3.right * Time.deltaTime * 5);
	    }

	    if(childCamera.transform.position.y > 1 && state == 2){
		    childCamera.transform.position = Vector3.Lerp(from.position, fromObject.transform.position, Time.time * speed * 0.1f);

		   // childCamera.transform.Translate(Vector3.forward * Time.deltaTime * 8);
	        transform.rotation = Quaternion.Lerp(to.rotation, Quaternion.identity, (Time.time - tmpTime) * speed);
	    }

        if(Input.GetKeyUp("space") && state == 0){
			state = 1;
		}

		if(Input.GetKeyUp("a") && state == 1){
			state = 2;
			to = from;
			from = childCamera.transform;
			tmpTime = Time.time;
		}
    }
}
