using UnityEngine;
using System.Collections;

public class rotateCamera : MonoBehaviour {

	public GameObject childCamera;
	public GameObject fromObject;
	public GameObject toObject;
	public GameObject leftCamLeft;
	public GameObject leftCamRight;
	public GameObject leftCamGreen;
	public GameObject rightCamLeft;
	public GameObject rightCamRight;
	public GameObject rightCamGreen;

    Transform from;
    Transform CameraPosition;
    public Transform to;
    float tmpTime;
    int state = -1;
    public float speed = 0.1F;

    void Start(){
    	//childCamera = transform.GetChild(0).GetComponent<GameObject>();
    	CameraPosition = childCamera.transform;
    	from = transform;
    }
    void Update() {
    	if(childCamera.transform.position.y < 60 && state == 0){
    		childCamera.transform.position = Vector3.Lerp(fromObject.transform.position, toObject.transform.position, (Time.time - tmpTime) * speed * 8);
		    //childCamera.transform.Translate(Vector3.back * Time.deltaTime * 8);
	        transform.rotation = Quaternion.Lerp(from.rotation, to.rotation, (Time.time - tmpTime) * speed);
	    }

	    if(childCamera.transform.position.x > -16 && state == 1){
		 	childCamera.transform.position = Vector3.Lerp(childCamera.transform.position, childCamera.transform.position + new Vector3(-16,0,0), Time.time * speed);
		  //  childCamera.transform.Translate(Vector3.right * Time.deltaTime * 5);
	    }

	    if(childCamera.transform.position.y > 1 && state == 2){
		    childCamera.transform.position = Vector3.Lerp(from.position, fromObject.transform.position + new Vector3(-16,0,0), Time.time * speed * 0.1f);

		   // childCamera.transform.Translate(Vector3.forward * Time.deltaTime * 8);
	        transform.rotation = Quaternion.Lerp(to.rotation, Quaternion.identity, (Time.time - tmpTime) * speed);
	    }

        if(Input.GetKeyUp("space") && state == 0){
			state = 1;
		}

		if(Input.GetKeyUp("u")){

			if(leftCamLeft.activeSelf){
				leftCamLeft.SetActive(false);
				leftCamRight.SetActive(false);
			}else{
				leftCamLeft.SetActive(true);
				leftCamRight.SetActive(true);
			}

		}

		if(Input.GetKeyUp("i")){

			if(leftCamGreen.activeSelf){
				leftCamGreen.SetActive(false);
			}else{
				leftCamGreen.SetActive(true);
			}


		}

		if(Input.GetKeyUp("o")){
			if(rightCamLeft.activeSelf){
				rightCamLeft.SetActive(false);
				rightCamRight.SetActive(false);
			}else{
				rightCamLeft.SetActive(true);
				rightCamRight.SetActive(true);
			}


		}

		if(Input.GetKeyUp("p")){
			if(rightCamGreen.activeSelf){
				rightCamGreen.SetActive(false);
			}else{
				rightCamGreen.SetActive(true);
			}

		}

		if(Input.GetKeyUp("w")){
			state = 0;
			tmpTime = Time.time;
		}

		if(Input.GetKeyUp("a") && state == 1){
			state = 2;
			to = from;
			from = childCamera.transform;
			tmpTime = Time.time;
		}
    }
}
