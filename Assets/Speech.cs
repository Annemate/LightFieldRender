using UnityEngine;
using System.Collections;

public class Speech : MonoBehaviour {

	public AudioSource alreadyLookingAtTheSameImageDanish;
	public AudioSource alreadyLookingAtTheSameImageEnglish;
	public AudioSource pressBothBumpersToChooseDanish;
	public AudioSource pressBothBumpersToChooseEnglish;
	public AudioSource cantChooseTheReferenceImageDanish;
	public AudioSource cantChooseTheReferenceImageEnglish;

	public enum Languages{English, Danish};
	public Languages myLanguage;
	// Use this for initialization
	void Start () {
		myLanguage = Languages.Danish;
	}

	public void AlreadyLookingAtTheSameImage(){
		if(myLanguage == Languages.Danish && !alreadyLookingAtTheSameImageDanish.isPlaying){
			alreadyLookingAtTheSameImageDanish.Play();
		}else if(myLanguage == Languages.English && !alreadyLookingAtTheSameImageEnglish.isPlaying){
			alreadyLookingAtTheSameImageEnglish.Play();
		}
	}

	public void PressBothBumpersToChoose(){
		if(myLanguage == Languages.Danish && !pressBothBumpersToChooseDanish.isPlaying){
			pressBothBumpersToChooseDanish.Play();
		}else if(myLanguage == Languages.English && !pressBothBumpersToChooseEnglish.isPlaying){
			pressBothBumpersToChooseEnglish.Play();
		}
	}

	public void cantChooseTheReferenceImage(){
		if(myLanguage == Languages.Danish && !cantChooseTheReferenceImageDanish.isPlaying){
			cantChooseTheReferenceImageDanish.Play();
		}else if(myLanguage == Languages.English && !cantChooseTheReferenceImageEnglish.isPlaying){
			cantChooseTheReferenceImageEnglish.Play();
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

		//Testing the audio
		/*if (Input.GetKeyDown("j")){
			AlreadyLookingAtTheSameImage();
		}

		if (Input.GetKeyDown("k")){
			PressBothBumpersToChoose();
		}

		if (Input.GetKeyDown("l")){
			cantChooseTheReferenceImage();
		}*/

	}
}
