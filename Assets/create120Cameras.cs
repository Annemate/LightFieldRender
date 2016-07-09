using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class create120Cameras : MonoBehaviour {
	public static int cameraCount;
	private int myIndex;

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
	void Start(){
		StartCoroutine(MyStart());
	}
	IEnumerator MyStart () {
		 yield return new WaitForSeconds(0);
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
				if(counter % 2 == 0){
					tmp.GetComponent<Camera>().backgroundColor = Color.red;
				}else{
					tmp.GetComponent<Camera>().backgroundColor = Color.green;
				}

				counter ++;
			}
		}

		print(cameraList.Count);
		//myIndex = cameraCount;
		//cameraCount ++;

	}

	// Update is called once per frame
	void Update () {
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
