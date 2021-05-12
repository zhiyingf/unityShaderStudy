Shader "Hidden/Front"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        
        Tags{"Queue" = "Transparent"}

        Pass
        {
            Color(0,1,0,1)
        }
    }
}
