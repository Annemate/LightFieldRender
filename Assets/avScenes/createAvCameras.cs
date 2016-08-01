using UnityEngine;
using System.Collections;
using System.Collections.Generic;
public class createAvCameras : MonoBehaviour {

	public static int cameraCount;
	private int myIndex;

	public float initialDelay;
	public float interCameraDelay;
	private int cameraActivationCounter;
	int state = 0;
	bool runStart = true;
	int yCounter = 0;

	public GameObject cameraObject;
	public int numOfCamXaxis;
	public int numOfCamYaxis;
	public Vector2 screenSize;
	public Vector2 imageSize;
	public float errorX;
	public float errorY;
	public Vector2 ICD;
	public Vector2 screenPositionOffset;
	private int cameraIndexName = 1;
	private float subImageWidthX;
	private float subImageWidthY;
	private List<GameObject> cameraList;
	public bool updateCameras;
	int counter;
	// Use this for initialization

	void Start () {
		cameraList = new List<GameObject>();
		subImageWidthX = ((imageSize.x/screenSize.x)/numOfCamXaxis) * (errorX/100f);
		subImageWidthY = ((imageSize.y/screenSize.y)/numOfCamYaxis) * (errorY/100f);
		print(subImageWidthY);
		for(int i = 0; i < numOfCamYaxis; i ++){
			for(int j = 0; j < numOfCamXaxis; j ++){
				GameObject tmp = (GameObject)Instantiate(cameraObject, new Vector3(j * ICD.x,i * ICD.y,0), Quaternion.identity);
				tmp.name = "camera" + (cameraIndexName).ToString();
				cameraIndexName ++;
				cameraList.Add(tmp);

				tmp.GetComponent<Camera>().rect = new Rect(subImageWidthX * j + screenPositionOffset.x ,subImageWidthY * i + screenPositionOffset.y, subImageWidthX,subImageWidthY);
				tmp.SetActive(false);
				tmp.GetComponent<Camera>().backgroundColor = new Color(31f/255f,1f/255f,50f/255f);
				//tmp.GetComponent<Camera>().backgroundColor = Color.green;
				/*if(counter % 2 == 0){
					tmp.GetComponent<Camera>().backgroundColor = Color.red;
				}else{
					tmp.GetComponent<Camera>().backgroundColor = Color.green;
				}*/

				counter ++;
			}
		}
		cameraObject.SetActive(false);
		print(cameraList.Count);
		//myIndex = cameraCount;
		//cameraCount ++;
		//cameraList[0].SetActive(true);
	}

	// Update is called once per frame
	void Update () {

		if (Input.GetKeyDown("space") && state == 0){
			print("state 0");
			runStart = false;
			state = 1;
			for(int number = 0; number < cameraList.Count; number ++){
				cameraList[number].SetActive(false);
			}
			cameraList[0].SetActive(true);
			cameraList[numOfCamXaxis - 1].SetActive(true);
			cameraList[(numOfCamXaxis * numOfCamYaxis) - numOfCamXaxis].SetActive(true);
			cameraList[(numOfCamXaxis * numOfCamYaxis) - 1].SetActive(true);
		}else if(Input.GetKeyDown("space") && state == 1){
			print("state 1");
			state = 2;
			for(int number = 0; number < cameraList.Count; number ++){
				cameraList[number].SetActive(true);
			}
		}

		if(Input.GetKeyDown("space") && state == 2){
			for(int number = 0; number < cameraList.Count; number ++){
				cameraList[number].SetActive(false);
			}
			cameraList[0].SetActive(true);
			cameraList[numOfCamXaxis - 1].SetActive(true);
			cameraList[(numOfCamXaxis * numOfCamYaxis) - numOfCamXaxis].SetActive(true);
			cameraList[(numOfCamXaxis * numOfCamYaxis) - 1].SetActive(true);
			print("state 2");
			cameraActivationCounter = 0;
			initialDelay = Time.time;
		}

		if(Input.GetKeyDown("space") && state == 3){
			cameraActivationCounter = 0;
			initialDelay = Time.time;
		}

		if(Input.GetKeyDown("space") && state == 4){
			state = 5;
			cameraActivationCounter = 0;
			initialDelay = Time.time;
		}

		if(state == 2){
			if(Time.time > (interCameraDelay * cameraActivationCounter) + initialDelay){
				if(cameraActivationCounter < cameraList.Count){
					cameraList[cameraActivationCounter].SetActive(true);
				}
				cameraActivationCounter ++;
				if(cameraActivationCounter == numOfCamXaxis){
					cameraActivationCounter = numOfCamXaxis * numOfCamYaxis - numOfCamXaxis;
					//cameraActivationCounter = 0;
				}

				if(cameraActivationCounter == cameraList.Count - 1){
					state = 4;
					print("state 3");
					initialDelay = Time.time;
				}
			}
		}

		if(state == 5){
			if(Time.time > (interCameraDelay * cameraActivationCounter) + initialDelay){
				for(int i = 0; i < numOfCamXaxis; i ++){
					cameraList[yCounter * numOfCamXaxis + i].SetActive(true);
				}


				yCounter ++;
				cameraActivationCounter ++;


				if(yCounter == numOfCamYaxis ){
					state = 4;
					print("state 4");
				}
			}
		}

		if(Time.time > initialDelay && runStart){
			if(Time.time > (interCameraDelay * cameraActivationCounter) + initialDelay){
				if(cameraActivationCounter < cameraList.Count)
					cameraList[cameraActivationCounter].SetActive(true);
				cameraActivationCounter ++;

			}
		}
		if(updateCameras){
			updateCameras = false;
			cameraIndexName = 0;
			subImageWidthX = ((imageSize.x/screenSize.x)/numOfCamXaxis) * (errorX/100f);
			subImageWidthY = ((imageSize.y/screenSize.y)/numOfCamYaxis) * (errorY/100f);
			for(int i = 0; i < numOfCamYaxis; i ++){
				for(int j = 0; j < numOfCamXaxis; j ++){

					cameraList[cameraIndexName].GetComponent<Camera>().rect = new Rect(subImageWidthX * j + screenPositionOffset.x ,subImageWidthY * i + screenPositionOffset.y, subImageWidthX,subImageWidthY);
					cameraIndexName ++;
				}
			}
		}
	}
}
