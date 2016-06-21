using UnityEngine;
using System.Collections;
using System;
using System.IO;
using System.Collections.Generic;

public class logging : MonoBehaviour {

	String fileName = "MyFile.txt";

	void Start()
	{
		if (!File.Exists(fileName))
		{
			Debug.Log(fileName + " does not exists.");
		}


		File.AppendAllText(fileName, "om filen eksisterer\n");
	}

	// Update is called once per frame
	void Update () {

	}
}
