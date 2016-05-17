using UnityEngine;
using System.Collections;
using System;
using System.IO;

public class control : MonoBehaviour {

	private bool canAcceptButton = true;
	private float lastButtonTime;
	float firstImageDuration;
	float secondImageDuration;


	public int firstChoice;
	private int counter = 1;

	public int testNo;

	String fileName = "logging.txt";
	String testCounter = "testCounter.txt";

	void Start()
	{
		testNo += (int.Parse(File.ReadAllText(testCounter)));


		if (!File.Exists(fileName))
		{
			Debug.Log(fileName + " does not exists.");
		}
	}


	void UpdateImage() {

		testScaleShaderScript.count = 1;

		if (counter == 0) {
			testScaleShaderScript.count = 0;
			counter = 1;
		}
		else if (counter == 1) {
			
			firstChoice = (int) Math.Round(UnityEngine.Random.Range (1.0f, 2.0f));
			testScaleShaderScript.count = firstChoice;
			print (firstChoice);
			counter = 2; 
			firstImageDuration = Time.time;
		}else if(counter == 2){
			testScaleShaderScript.count = 0;
			counter = 3;
			firstImageDuration = Time.time - firstImageDuration;
		} else if(counter == 3) {
			if (firstChoice == 1) {
				testScaleShaderScript.count = 2;
			} else {
				testScaleShaderScript.count = 1;
			}
			counter = 4;
			secondImageDuration = Time.time;
		}else if(counter == 4) {
			secondImageDuration = Time.time - secondImageDuration;
			testScaleShaderScript.count = 3;
		}
	}

	void Reset(bool first){
		if (counter == 4) {
			
			
			testScaleShaderScript.count = 0;
			if (firstChoice == 1) {
				
				File.AppendAllText (fileName, ++testNo + ",interpolatedImage," + firstImageDuration + ",virtualCamera," + secondImageDuration + ",");
			} else {
				File.AppendAllText(fileName, ++testNo + ",virtualCamera," + firstImageDuration + ",interpolatedImage," + secondImageDuration + ","  );
			}

			if (first) {
				if (firstChoice == 1) {
					File.AppendAllText (fileName, "interpolatedImage\n");
				} else {
					File.AppendAllText (fileName, "virtualCamera\n");
				}
			} else {
				if (firstChoice == 2) {
					File.AppendAllText (fileName, "interpolatedImage\n");
				} else {
					File.AppendAllText (fileName, "virtualCamera\n");
				}
			}

			var sr = File.CreateText(testCounter);
			sr.WriteLine (testNo);
			sr.Close();

			counter = 0;
		}
	}

	void Update() {
		print ((int)Math.Round (UnityEngine.Random.Range (1.0f, 2.0f)));

		if ((Time.time - 1.0f) > lastButtonTime && !canAcceptButton) {
			canAcceptButton = true;
		}

		if (Input.GetButton ("A") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("A");
			UpdateImage ();
		}

		if (Input.GetButton ("B") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("B");
			UpdateImage ();
		}

		if (Input.GetButton ("X") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("X");
			UpdateImage ();
		}

		if (Input.GetButton ("Y") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("Y");
			UpdateImage ();
		}

		if (Input.GetAxis ("LeftTrigger") > 0.5f && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("LeftTrigger");
			Reset (true); 
		}

		if (Input.GetAxis ("RightTrigger") > 0.5f && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("RightTrigger");
			Reset (false); 
		}

		if (Input.GetButton ("LeftBumper") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("LeftButton");
			Reset (true); 
		}

		if (Input.GetButton ("RightBumper") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("RightButton");
			Reset (false); 
		}



	}
}

