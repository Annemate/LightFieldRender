using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class turnStuffOn : MonoBehaviour {

	public List<GameObject> Lenses;
	public List<GameObject> Lines;
	public List<GameObject> Cameras;
	public List<GameObject> Images;
	bool lens;
	bool line;
	bool camera;
	bool image;
	// Use this for initialization
	void Start () {

	}

	// Update is called once per frame
	void Update () {

		if(Input.GetKeyUp("a")){
			lens = !lens;
			for(int i = 0; i < Lenses.Count; i ++){
				Lenses[i].SetActive(lens);
			}
		}

		if(Input.GetKeyUp("b")){
			line = !line;
			for(int i = 0; i < Lines.Count; i ++){
				Lines[i].SetActive(line);
			}
		}

		if(Input.GetKeyUp("c")){
			camera = !camera;
			for(int i = 0; i < Cameras.Count; i ++){
				Cameras[i].SetActive(camera);
			}
		}

		if(Input.GetKeyUp("d")){
			image = !image;
			for(int i = 0; i < Images.Count; i ++){
				Images[i].SetActive(image);
			}
		}
	}
}
