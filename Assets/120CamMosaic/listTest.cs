using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class listTest : MonoBehaviour {
	public List<int> test = new List<int>();

	int RandomNumber;
	// Use this for initialization
	void Start () {
		test.Add(1);
		test.Add(2);
		test.Add(3);
		test.Add(4);
		test.Add(5);


	}

	// Update is called once per frame
	void Update () {

		RandomNumber = (int)Random.Range(0.0f, (float)(test.Count - 1));

		print("the random index is " + RandomNumber + " The number chosen is " + test[RandomNumber] + " ,The remaning numbers are as follows:");

		test.RemoveAt(RandomNumber);
		for(int i = 0; i < test.Count; i++){
			print(test[i]);
		}

		if(test.Count == 0){
			print("list is empty. Refilling the list");

			test.Add(1);
			test.Add(2);
			test.Add(3);
			test.Add(4);
			test.Add(5);
		}

		print("End of frame");

	}
}
