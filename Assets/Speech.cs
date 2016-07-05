using UnityEngine;
using System.Collections;

public class Speech : MonoBehaviour {

	public AudioClip alreadyLookingAtTheSameImageDanish;
	public AudioClip alreadyLookingAtTheSameImageEnglish;
	public AudioClip pressBothBumpersToChooseDanish;
	public AudioClip pressBothBumpersToChooseEnglish;
	public AudioClip cantChooseTheReferenceImageDanish;
	public AudioClip cantChooseTheReferenceImageEnglish;
	public AudioClip pressLeftOrRightDanish;
	public AudioClip pressLeftOrRightEnglish;
	public AudioClip youHaveNotSeenBothImagesDanish;
	public AudioClip youHaveNotSeenBothImagesEnglish;

	AudioSource audio;

	private bool canPlay = true;
	public enum Languages{English, Danish};
	public Languages myLanguage;
	// Use this for initialization
	void Start () {
		audio = gameObject.GetComponent<AudioSource>();
		myLanguage = Languages.Danish;
	}

	public void YouHaveNotSeenBothImages(){
		if(myLanguage == Languages.Danish && !audio.isPlaying ){
			audio.clip = youHaveNotSeenBothImagesDanish;
			audio.Play();
		}else if(myLanguage == Languages.English && !audio.isPlaying){
			audio.clip = youHaveNotSeenBothImagesEnglish;
			audio.Play();
		}
	}

	public void AlreadyLookingAtTheSameImage(){
		if(myLanguage == Languages.Danish && !audio.isPlaying ){
			audio.clip = alreadyLookingAtTheSameImageDanish;
			audio.Play();
		}else if(myLanguage == Languages.English && !audio.isPlaying){
			audio.clip = alreadyLookingAtTheSameImageEnglish;
			audio.Play();
		}
	}

	public void PressBothBumpersToChoose(){
		if(myLanguage == Languages.Danish && !audio.isPlaying){
			audio.clip = pressBothBumpersToChooseDanish;
			audio.Play();
		}else if(myLanguage == Languages.English && !audio.isPlaying){
			audio.clip = pressBothBumpersToChooseEnglish;
			audio.Play();
		}
	}

	public void cantChooseTheReferenceImage(){
		StartCoroutine(PlayRefImgSound());
	}

    IEnumerator PlayRefImgSound()
    {
        if(myLanguage == Languages.Danish && !audio.isPlaying){
			audio.clip = cantChooseTheReferenceImageDanish;
			audio.Play();
		}else if(myLanguage == Languages.English && !audio.isPlaying){
			audio.clip = cantChooseTheReferenceImageEnglish;
			audio.Play();
		}

        yield return new WaitForSeconds(audio.clip.length);

        if(myLanguage == Languages.Danish && !audio.isPlaying){
			audio.clip = pressLeftOrRightDanish;
			audio.Play();
		}else if(myLanguage == Languages.English && !audio.isPlaying){
			audio.clip = pressLeftOrRightEnglish;
			audio.Play();
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
