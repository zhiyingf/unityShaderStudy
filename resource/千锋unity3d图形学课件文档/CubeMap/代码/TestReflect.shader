Shader "Custom/TestReflect" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}


		_CubeMap("Cube Map",CUBE)= ""{}


		_CubePower("CUBE power",float) = 0.5 
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf   Lambert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		samplerCUBE  _CubeMap ;

		struct Input {
			float2 uv_MainTex;

			float3  worldRefl ;
		};



		float  _CubePower ;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

			  o.Emission=   texCUBE(_CubeMap,IN.worldRefl).rgb*_CubePower  ;
			o.Albedo = c.rgb;
	
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
