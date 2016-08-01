using UnityEngine;
using System.Collections;

public class moveLeftRight : MonoBehaviour {

	Transform initialTransform;
	public float speed;
	public float distance;
	float startTime;
	Vector3 target;
	// Use this for initialization
	void Start () {

		initialTransform = transform;
		target = initialTransform.position + new Vector3(distance,0,0);
		startTime = Time.time;
	}

	// Update is called once per frame
	void Update () {
		//if(Mathf.Abs(transform.position.x) - Mathf.Abs(distance) < 0.2f)
		//	distance = -distance;
		float distCovered = (Time.time - startTime) * (speed / 100f);
        float fracJourney = distCovered / distance;

        print(fracJourney);
        if(fracJourney > 0.9){
        	target = initialTransform.position + new Vector3(-distance,0,0);
        	print("resetting");
        }
		transform.position = (Vector3.Slerp(initialTransform.position, target, fracJourney));
		//print(Mathf.Abs(transform.position.x) - Mathf.Abs(distance));
		//transform.position = Vector3.Lerp(initialTransform.position, new Vector3(distance,0,0) + initialTransform.position, Time.deltaTime * speed);
	}
}
