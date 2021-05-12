using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Blur : MonoBehaviour
{
    public Material mat;
    public float _BlurDis = 0.001f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        mat.SetFloat("_BlurDis", _BlurDis);
        Graphics.Blit(source,destination, mat);
    }
}
