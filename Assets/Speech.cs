using UnityEngine;
using System.Collections;

public class Speech : MonoBehaviour {

	public AudioSource alreadyLookingAtTheSameImageDanish;
	public AudioSource alreadyLookingAtTheSameImageEnglish;
	public enum Languages{English, Danish};
	public Languages myLanguage;
	// Use this for initialization
	void Start () {

	}

	public void alreadyLookingAtTheSameImage(){
		if(myLanguage == Languages.Danish && !alreadyLookingAtTheSameImageDanish.isPlaying){
			alreadyLookingAtTheSameImageDanish.Play();
		}else if(myLanguage == Languages.English && !alreadyLookingAtTheSameImageEnglish.isPlaying){
			alreadyLookingAtTheSameImageEnglish.Play();
		}
	}

	// Update is called once per frame
	void Update () {
		if (Input.GetKeyDown("d")){
			print("language changed to Danish");
			myLanguage = Languages.Danish;
		}

		if (Input.GetKeyDown("e")){
			print("language changed to English");
			myLanguage = Languages.English;
		}

	}
}
