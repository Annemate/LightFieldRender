using UnityEngine;
using System.Collections;
using System;
using System.IO;
using System.Collections.Generic;

public class control : MonoBehaviour {

	private bool canAcceptButton = true;
	private float lastButtonTime;
	float firstImageDuration;
	float secondImageDuration;


	public int firstChoice;
	private int counter = 1;
	private int counter5 = 0;

	public int testNo;
	int currentImageNumber;

	String fileName = "logging.txt";
	String testCounter = "testCounter.txt";

	public List<int> test = new List<int>();

	int RandomNumber;












	void OnApplicationQuit(){
		File.AppendAllText (fileName, "\nUnity closed\n");
	}

	void Start()
	{
		testNo += (int.Parse(File.ReadAllText(testCounter)));


		if (!File.Exists(fileName))
		{
			Debug.Log(fileName + " does not exists.");
		}

			test.Add(0);
			test.Add(1);
			test.Add(2);
			test.Add(3);
			test.Add(4);

	}


	void UpdateImage() {
 
		if (counter == 1) {
				firstChoice = (int)Math.Round (UnityEngine.Random.Range (1.0f, 2.0f));
				testScaleShaderScript.count = firstChoice + (2 * (currentImageNumber +1));;
				print ("first choice is " + firstChoice);
				counter = 2; 
				firstImageDuration = Time.time;
			} else if (counter == 2) {
				testScaleShaderScript.count = 0;
				counter = 3;
				firstImageDuration = Time.time - firstImageDuration;
			} else if (counter == 3) {
				if (firstChoice == 1) {
				testScaleShaderScript.count = 2 + (2 * (currentImageNumber +1));
				} else {
				testScaleShaderScript.count = 1 + (2 * (currentImageNumber +1));
				}
				counter = 4;
				secondImageDuration = Time.time;
			} else if (counter == 4) {
				secondImageDuration = Time.time - secondImageDuration;
				testScaleShaderScript.count = 1;
				counter = 0;
			}
	}

	void Reset(bool first){
			
	
			for(int i = 0; i < test.Count; i++){
				print(test[i]);
			}

			


			testScaleShaderScript.count = 0;
			if (firstChoice == 1) {
				
			File.AppendAllText (fileName, (testNo + 1.0) + "," + (counter5 + 1.0) + "," + currentImageNumber + ",interpolatedImage," + firstImageDuration + ",virtualCamera," + secondImageDuration + ",");
				} else {
			File.AppendAllText (fileName, (testNo + 1.0) + "," + (counter5 + 1.0) + "," + currentImageNumber + ",virtualCamera," + firstImageDuration + ",interpolatedImage," + secondImageDuration + ",");
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

				var sr = File.CreateText (testCounter);
				sr.WriteLine (testNo);
				sr.Close ();

				if (counter5 == 4) {
					
					testScaleShaderScript.count = 2;

					print("list is empty. Refilling the list");

						if (test.Count == 0){
						test.Add(0);
						test.Add(1);
						test.Add(2);
						test.Add(3);
						test.Add(4);	
						}


					testNo += 1;
					counter5 = 0;

						

					
				} else {
					counter5 ++ ;

						RandomNumber = (int)UnityEngine.Random.Range(0.0f, (float)(test.Count - 1));

						print("the random index is " + RandomNumber + " The number chosen is " + test[RandomNumber] + " ,The remaning numbers are as follows:");

						currentImageNumber = test[RandomNumber];

						test.RemoveAt(RandomNumber);
				}

				counter = 1;
	}

	void Update() {
		//print (Input.GetButton ("A"));
		//print ((int)Math.Round (UnityEngine.Random.Range (1.0f, 2.0f)));

		if ((Time.time - 0.5f) > lastButtonTime && !canAcceptButton) {
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

		if (counter == 0) {

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
}

