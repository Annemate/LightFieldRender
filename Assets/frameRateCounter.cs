﻿using UnityEngine;
using System.Collections;
using System;
using System.IO;
using System.Collections.Generic;

public class frameRateCounter : MonoBehaviour {

	private float[] frameArray;
	private int frameCounter;
	//private int delayFrameCounter;
	private bool printOnce = true;
	private float arraySum;
	public int delayInFrames;
	String fileName;
	// Use this for initialization
	void Start () {
		print(DateTime.UtcNow.Ticks);
		fileName = DateTime.UtcNow.Ticks.ToString() + ".txt";
		frameArray = new float[100];

	}

	// Update is called once per frame
	void Update () {
		if((frameCounter) < frameArray.Length && Time.frameCount > delayInFrames){
			//print(frameCounter);
			frameArray[frameCounter] = Time.deltaTime;
			frameCounter ++;
			//print(frameCounter);

		}else if(printOnce && frameCounter > delayInFrames){
			printOnce = false;
			print("has started");
			for(int i = 0; i < frameArray.Length; i ++){
			//	print(frameArray[i]);
				File.AppendAllText (fileName, frameArray[i] + "\n");
				arraySum += frameArray[i];

			}
			File.AppendAllText (fileName, "mean is: " + arraySum / frameArray.Length);
			File.AppendAllText (fileName, "fps is: " +  1.0 / (arraySum / frameArray.Length));

			print("mean is: " + arraySum / frameArray.Length + "\n");
			print("fps is: " +  1.0 / (arraySum / frameArray.Length));
		}
		//delayFrameCounter ++;

	}
}
