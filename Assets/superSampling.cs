using UnityEngine;
using System.Collections;

public class superSampling : MonoBehaviour {

	private Material material;
	public RenderTexture bigRenderTexture;
	// Use this for initialization
	void Start () {
		material = new Material( Shader.Find("Custom/SuperSampling") );
	}

	// Update is called once per frame
	void Update () {

	}

	void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
		material.SetTexture ("_SuperResImage", bigRenderTexture);
		Graphics.Blit (source, destination, material);
	}
}
