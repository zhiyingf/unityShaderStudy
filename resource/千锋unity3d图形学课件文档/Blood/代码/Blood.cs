using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Blood : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}



    float tmpCount;

	// Update is called once per frame
	void Update () {


        tmpCount += Time.deltaTime*5;


        rangValue =  Mathf.Sin(tmpCount) ;  //  -1   1


        rangValue = 1+(rangValue + 1) * 0.25f  ;   //  0 --0.5     //  1---1.5

		
	}



    public float rangValue;





    public Material graphicMat;



    void OnRenderImage(RenderTexture sourceTexture, RenderTexture desTexture)
    {



        graphicMat.SetFloat("_BloodLength", rangValue);

   
        Graphics.Blit(sourceTexture, desTexture, graphicMat);


    }



}
