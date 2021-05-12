using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMove : MonoBehaviour {



	// Use this for initialization
	void Start () {


       // graphicMat = new Material(myShader);
		
	}


      

   // public Shader myShader;


    public Material graphicMat;

	// Update is called once per frame
	void Update () {
		
	}

    void OnRenderImage(RenderTexture sourceTexture, RenderTexture desTexture)
    {



        Graphics.Blit(sourceTexture, desTexture, graphicMat);
 

    }


}
