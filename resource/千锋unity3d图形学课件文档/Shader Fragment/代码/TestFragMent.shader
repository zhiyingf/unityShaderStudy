Shader "Custom/TestFragMent" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}



		_ScollerX ("Scoller  x",float) = 1

		_ScollerY ("Scoller  y",float) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert  

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		float   _ScollerX;

		float   _ScollerY ;

		struct Input {
			float2 uv_MainTex;
		};


		void surf (Input IN, inout SurfaceOutput  o )
		 {
		   
		       float2  tmpUV = 	  IN.uv_MainTex;

			   tmpUV.x  +=  _Time.x*_ScollerX ;

			   tmpUV.y  += _Time.y*_ScollerY ;

		     o.Albedo =  tex2D(_MainTex,tmpUV).rgb ;  

   
		}
		ENDCG
	}
	FallBack "Diffuse"
}
