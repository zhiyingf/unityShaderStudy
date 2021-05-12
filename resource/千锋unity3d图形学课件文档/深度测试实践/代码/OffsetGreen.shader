Shader "Hidden/OffsetRed"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
	

		Pass
		{

		   offset  0,1
		  Color(0,1,0,1)
			
		}
	}
}
