﻿using UnityEngine;
using System.Collections;
using System;
using System.IO;
using System.Collections.Generic;
using XInputDotNetPure;

public class controlThree : MonoBehaviour {

	String fileName = "logging.txt";
	String testCounter = "testCounter.txt";
	bool shutButtonsOff = false;
	bool virtualOnTheLeft;
	int imagePairCounter;
	float delayToImages = 0.25f;
	bool isBlack;
	int currentImageNumber;
	int testNo;
	int RandomNumber;
	float firstImageDuration;
	float secondImageDuration;
	String	currentDevice;
	bool leftTriggerDown = false;
	bool rightTriggerDown = false;
	bool canAccepttrigger = true;
	shake myShakeScript;
	char previousButton;

	private bool canAcceptButton = true;
	private float lastButtonTime;
	bool lastBumpWasLeft;
	bool canCheckforChoiseSound = true;

	public List<int> test = new List<int>();

	public enum Sides{start, left, right};
	public Sides mySoundLastSide;

	public enum States{black, begin, RefImageLf, LookLf, ChooseLf, SwitchScreen, RefImageSc, LookSc, ChooseSc, Done};
	public States myStates;

	public struct BumperActions{
		public bool left;
		public bool right;
	}

	Speech mySpeech;
	BumperActions myBumperActions;

	void Start(){
		mySoundLastSide = Sides.start;
		myShakeScript   = gameObject.GetComponent<shake>();
		mySpeech        = gameObject.GetComponent<Speech>();

 		if(UnityEngine.Random.Range(0,2) == 0){
			virtualOnTheLeft = true;
		}else{
			virtualOnTheLeft = false;
		}

		myStates = States.begin;

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

			RandomNumber = (int)UnityEngine.Random.Range(0.0f, (float)(test.Count));

			print("the random index is " + RandomNumber + " The number chosen is " + test[RandomNumber] + " ,The remaning numbers are as follows:");

			currentImageNumber = test[RandomNumber];

			test.RemoveAt(RandomNumber);

	}


	void Reset (bool lol){

	}

	void UpdateImage(){
		if(myStates == States.Done){
			testScaleShaderScript.count = 2;
		}

		//black screen
		if(myStates == States.begin || myStates == States.black)
			testScaleShaderScript.count = 0;

		if(myStates	== States.SwitchScreen)
			testScaleShaderScript.count = 1;

		if(myStates == States.LookLf){
			if(lastBumpWasLeft){

				if(!virtualOnTheLeft){
					switch(currentImageNumber){
						case 0:
							testScaleShaderScript.count = 3;
						break;
						case 1:
							testScaleShaderScript.count = 5;
						break;
						case 2:
							testScaleShaderScript.count = 7;
						break;
						case 3:
							testScaleShaderScript.count = 9;
						break;
						case 4:
							testScaleShaderScript.count = 11;
						break;
					}
				}else{
					switch(currentImageNumber){
						case 0:
							testScaleShaderScript.count = 4;
						break;
						case 1:
							testScaleShaderScript.count = 6;
						break;
						case 2:
							testScaleShaderScript.count = 8;
						break;
						case 3:
							testScaleShaderScript.count = 10;
						break;
						case 4:
							testScaleShaderScript.count = 12;
						break;
					}
				}

				//testScaleShaderScript.count = 1;
			}else{
				if(!virtualOnTheLeft){
						switch(currentImageNumber){
							case 0:
								testScaleShaderScript.count = 4;
							break;
							case 1:
								testScaleShaderScript.count = 6;
							break;
							case 2:
								testScaleShaderScript.count = 8;
							break;
							case 3:
								testScaleShaderScript.count = 10;
							break;
							case 4:
								testScaleShaderScript.count = 12;
							break;
						}
					}else{
						switch(currentImageNumber){
							case 0:
								testScaleShaderScript.count = 3;
							break;
							case 1:
								testScaleShaderScript.count = 5;
							break;
							case 2:
								testScaleShaderScript.count = 7;
							break;
							case 3:
								testScaleShaderScript.count = 9;
							break;
							case 4:
								testScaleShaderScript.count = 11;
							break;
						}
					}

				//testScaleShaderScript.count = 2;
			}
		}else if(myStates == States.LookSc){
			if(lastBumpWasLeft){

				if(!virtualOnTheLeft){
					switch(currentImageNumber){
						case 0:
							testScaleShaderScript.count = 13;
						break;
						case 1:
							testScaleShaderScript.count = 15;
						break;
						case 2:
							testScaleShaderScript.count = 17;
						break;
						case 3:
							testScaleShaderScript.count = 19;
						break;
						case 4:
							testScaleShaderScript.count = 21;
						break;
					}
				}else{
					switch(currentImageNumber){
						case 0:
							testScaleShaderScript.count = 14;
						break;
						case 1:
							testScaleShaderScript.count = 16;
						break;
						case 2:
							testScaleShaderScript.count = 18;
						break;
						case 3:
							testScaleShaderScript.count = 20;
						break;
						case 4:
							testScaleShaderScript.count = 22;
						break;
					}
				}

				//testScaleShaderScript.count = 1;
			}else{
				if(!virtualOnTheLeft){
						switch(currentImageNumber){
							case 0:
								testScaleShaderScript.count = 14;
							break;
							case 1:
								testScaleShaderScript.count = 16;
							break;
							case 2:
								testScaleShaderScript.count = 18;
							break;
							case 3:
								testScaleShaderScript.count = 20;
							break;
							case 4:
								testScaleShaderScript.count = 22;
							break;
						}
					}else{
						switch(currentImageNumber){
							case 0:
								testScaleShaderScript.count = 13;
							break;
							case 1:
								testScaleShaderScript.count = 15;
							break;
							case 2:
								testScaleShaderScript.count = 17;
							break;
							case 3:
								testScaleShaderScript.count = 19;
							break;
							case 4:
								testScaleShaderScript.count = 21;
							break;
						}
					}

				//testScaleShaderScript.count = 2;
			}
		}

		if(myStates == States.RefImageLf){

			switch(currentImageNumber){
					case 0:
						testScaleShaderScript.count = 4;
					break;
					case 1:
						testScaleShaderScript.count = 6;
					break;
					case 2:
						testScaleShaderScript.count = 8;
					break;
					case 3:
						testScaleShaderScript.count = 10;
					break;
					case 4:
						testScaleShaderScript.count = 12;
					break;
				}
		}

		if(myStates == States.RefImageSc){

			switch(currentImageNumber){
					case 0:
						testScaleShaderScript.count = 14;
					break;
					case 1:
						testScaleShaderScript.count = 16;
					break;
					case 2:
						testScaleShaderScript.count = 18;
					break;
					case 3:
						testScaleShaderScript.count = 20;
					break;
					case 4:
						testScaleShaderScript.count = 22;
					break;
				}
		}

	}

	void updateList(){
		if(test.Count > 0){
				RandomNumber = (int)UnityEngine.Random.Range(0.0f, (float)(test.Count));
				currentImageNumber = test[RandomNumber];
				test.RemoveAt(RandomNumber);

				if(UnityEngine.Random.Range(0,2) == 0){
					virtualOnTheLeft = true;
				}else{
					virtualOnTheLeft = false;
				}
		}else{
			test.Add(0);
			test.Add(1);
			test.Add(2);
			test.Add(3);
			test.Add(4);
			RandomNumber = (int)UnityEngine.Random.Range(0.0f, (float)(test.Count));
			currentImageNumber = test[RandomNumber];
			test.RemoveAt(RandomNumber);
			if(myStates	== States.LookLf){
				myStates = States.SwitchScreen;
			}else if(myStates == States.LookSc){
				myStates = States.begin;
			}

		}
	}

	void ChooseBetweenLeftOrRight(){
		leftTriggerDown = false;
		rightTriggerDown = false;
		canAccepttrigger = true;
		if(myBumperActions.left == true && myBumperActions.right == true && (myStates == States.LookLf || myStates == States.LookSc)){
			canAccepttrigger = false;
			StartCoroutine(ResumeRumblerAfterNewImage(2f));
			print("changing states to choose");
			myBumperActions.left = false;
			myBumperActions.right = false;
			imagePairCounter ++;

				if(myStates == States.LookLf){
					myStates = States.ChooseLf;
					Choose(true, imagePairCounter);
				}else if(myStates == States.LookSc){
					myStates = States.ChooseSc;
					Choose(false, imagePairCounter);
				}
			updateList();
			mySoundLastSide = Sides.start;
			previousButton = 'x';
		}else if(myStates == States.RefImageLf || myStates == States.RefImageSc){
			myShakeScript.ActivateRumbler(0.8f, 0f, 0.5f);
			mySpeech.cantChooseTheReferenceImage();

		}else if((myBumperActions.left == false || myBumperActions.right == false) && (myStates == States.LookLf || myStates == States.LookSc)){
			myShakeScript.ActivateRumbler(0f, 0.8f, 0.5f);
			mySpeech.YouHaveNotSeenBothImages();

		}else{
			print("somethis disnt work");
		}


	}

	void XBoxButtonInput(){

		mySoundLastSide = Sides.start;
		previousButton = 'x';

		if(myStates == States.begin){
			//testNo++;
			myStates = States.RefImageLf;
		}else if(myStates == States.LookLf){
			StartCoroutine(BlackDelay(delayToImages));
			myStates = States.RefImageLf;
		}else if(myStates == States.LookSc){
			StartCoroutine(BlackDelay(delayToImages));
			myStates = States.RefImageSc;
		}else if(myStates == States.RefImageLf || myStates == States.RefImageSc){
			mySpeech.AlreadyLookingAtTheSameImage();

		}

	}





	void Choose(bool lightField, int iteration){
		print("log stuff");


		if(lightField	){
			currentDevice = "LightFieldHmd,";
		}else{
			currentDevice = "ComputerScreen,";
		}

		if(lastBumpWasLeft){
				if(!virtualOnTheLeft){
					File.AppendAllText (fileName, currentDevice	+ (testNo + 1.0) + "," + (iteration) + "," + (currentImageNumber + 1) + ",virtualCamera" + ",interpolatedImage" + ",interpolatedImage\n");
					}
				else{
					File.AppendAllText (fileName, currentDevice	+ (testNo + 1.0) + "," + (iteration) + "," + (currentImageNumber + 1) + ",interpolatedImage" + ",virtualCamera" + ",virtualCamera\n");
					}
				}
		else{
				if(!virtualOnTheLeft){
					File.AppendAllText (fileName, currentDevice	+ (testNo + 1.0) + "," + (iteration) + "," + (currentImageNumber + 1) + ",interpolatedImage" + ",virtualCamera" + ",virtualCamera\n");
					}
				else{
					File.AppendAllText (fileName, currentDevice	+ (testNo + 1.0) + "," + (iteration) + "," + (currentImageNumber + 1) + ",virtualCamera" + ",interpolatedImage" + ",interpolatedImage\n");
					}
				}

		if(iteration >= 5 && lightField){
			imagePairCounter = 0;
			myStates = States.SwitchScreen;
		}else if(iteration >= 5 && !lightField){
			imagePairCounter = 0;
			testNo	++;

			//update the participant number after every answer (just in case unity crashes)
				var sr = File.CreateText (testCounter);
				sr.WriteLine (testNo);
				sr.Close ();

			//done
			myStates = States.Done;
			StartCoroutine(StartDelay(5));
		}else if(lightField){

			myStates = States.RefImageLf;
			print("yay");
		}else{

			myStates = States.RefImageSc;
		}
	}

	IEnumerator StartDelay(float delay){
		yield return new WaitForSeconds(delay);
			myStates = States.begin;

	}

	IEnumerator ResumeRumblerAfterNewImage(float delay){
		yield return new WaitForSeconds(delay);
			canAccepttrigger = true;

	}



	void XBoxBumperInput(char button){

		if(button != previousButton)
			StartCoroutine(BlackDelay(delayToImages));

		previousButton = button;

		if(myStates == States.RefImageLf){
			myStates = States.LookLf;
		}

		if(myStates == States.RefImageSc){
			myStates = States.LookSc;
		}

		if(button == 'l' && mySoundLastSide == Sides.left && (myStates == States.LookLf || myStates == States.LookSc)){
			mySpeech.AlreadyLookingAtTheSameImage();
			print("not left");
		}

		if(button == 'r' && mySoundLastSide == Sides.right && (myStates == States.LookLf || myStates == States.LookSc)){
			mySpeech.AlreadyLookingAtTheSameImage();
			print("not right");
		}

		if(button == 'l' && (myStates == States.LookLf || myStates == States.LookSc)){
				myBumperActions.left = true;
				lastBumpWasLeft = true;
				print("left");
			}

		if(button == 'r' && (myStates == States.LookLf || myStates == States.LookSc)){
				myBumperActions.right = true;
				lastBumpWasLeft = false;
				print("right");
			}

		//Last thing in this function
		if(button == 'l'){
			mySoundLastSide = Sides.left;
		}else if(button == 'r'){
			mySoundLastSide = Sides.right;
		}
	}



	IEnumerator BlackDelay(float delay){
		isBlack = true;
		testScaleShaderScript.count = 0;
		yield return new WaitForSeconds(delay);

		isBlack = false;

	}

	void Update() {


		if ((Time.time - 0.5f) > lastButtonTime && !canAcceptButton && !shutButtonsOff) {
			canAcceptButton = true;
		}

		if (Input.GetButton ("A") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("A");
			XBoxButtonInput();
		}

		if (Input.GetButton ("B") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("B");
			XBoxButtonInput();
		}

		if (Input.GetButton ("X") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("X");
			XBoxButtonInput();
		}

		if (Input.GetButton ("Y") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("Y");
			XBoxButtonInput();
		}


		if (Input.GetAxis ("LeftTrigger") > 0.5f && canAccepttrigger) {
			leftTriggerDown = true;
			print ("LeftTrigger");
			//XBoxBumperInput('l');
		}else if(Input.GetAxis ("LeftTrigger") < 0.5f){
			leftTriggerDown = false;
		}

		if (Input.GetAxis ("RightTrigger") > 0.5f && canAccepttrigger) {
			rightTriggerDown = true;
			print ("RightTrigger");
			//XBoxBumperInput('r');
		}else if(Input.GetAxis ("RightTrigger") < 0.5f){
			rightTriggerDown = false;
		}

		if (Input.GetButton ("LeftBumper") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("LeftButton");
			XBoxBumperInput('l');
		}

		if (Input.GetButton ("RightBumper") && canAcceptButton) {
			lastButtonTime = Time.time;
			canAcceptButton = false;
			print ("RightButton");
			XBoxBumperInput('r');
		}

		if (Input.GetKeyDown("space")){
			if(myStates	== States.SwitchScreen){
				myStates = States.RefImageSc;
			}
		}

		if(leftTriggerDown && rightTriggerDown){
			canAccepttrigger = false;
			ChooseBetweenLeftOrRight();
		}

		if((leftTriggerDown != rightTriggerDown) && canCheckforChoiseSound){
			canCheckforChoiseSound = false;
			StartCoroutine(ChoiseCheckdelay(1f));
		}


		if(!isBlack)
			UpdateImage();
	}

	IEnumerator ChoiseCheckdelay(float delay){
		yield return new WaitForSeconds(delay);
		canCheckforChoiseSound = true;
		if((leftTriggerDown != rightTriggerDown)){
				mySpeech.PressBothBumpersToChoose();
		}

	}

	void OnApplicationQuit(){
		File.AppendAllText (fileName, "\nUnity closed\n");
	}
}
