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
	public Vector2 ICD;
	public Vector2 screenPositionOffset;
	private int cameraIndexName = 1;
	private float subImageWidthX;
	private float subImageWidthY;
	private List<GameObject> cameraList;
	public bool updateCameras;
	// Use this for initialization
	void Start () {
		cameraList = new List<GameObject>();
		subImageWidthX = (imageSize.x/screenSize.x)/numOfCamXaxis;
		subImageWidthY = (imageSize.y/screenSize.y)/numOfCamYaxis;
		print(subImageWidthY);
		for(int i = 0; i < numOfCamYaxis; i ++){
			for(int j = 0; j < numOfCamXaxis; j ++){
				GameObject tmp = (GameObject)Instantiate(cameraObject, new Vector3(j * ICD.x,i * ICD.y,0), Quaternion.identity);
				tmp.name = "camera" + (cameraIndexName).ToString();
				cameraIndexName ++;
				cameraList.Add(tmp);

				tmp.GetComponent<Camera>().rect = new Rect(subImageWidthX * j + screenPositionOffset.x ,subImageWidthY * i + screenPositionOffset.y, subImageWidthX,subImageWidthY);
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
			for(int i = 0; i < numOfCamYaxis; i ++){
				for(int j = 0; j < numOfCamXaxis; j ++){

					cameraList[cameraIndexName].GetComponent<Camera>().rect = new Rect(subImageWidthX * j + screenPositionOffset.x ,subImageWidthY * i + screenPositionOffset.y, subImageWidthX,subImageWidthY);
					cameraIndexName ++;
				}
			}
		}
	}
}
