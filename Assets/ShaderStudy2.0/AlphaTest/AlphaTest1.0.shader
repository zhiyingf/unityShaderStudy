Shader "Custom/AlphaTest1.0"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _AlphaCut("AlphaCut",float) = 0.5
    }
        SubShader
    {
        //AlphaTest Greater 0.5
        //AlphaTest Greater [_AlphaCut]
        Pass
        {
            SetTexture[_MainTex]
            {
                combine texture
            }
        }

        
    }
}
