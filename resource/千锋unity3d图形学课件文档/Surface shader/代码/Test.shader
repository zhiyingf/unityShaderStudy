﻿Shader "Custom/Test" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)


		_SpecularColor ("SpecularColor", Color) = (1,1,1,1)


		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0


		_Occlusion ("Occlusion", Range(0,1)) = 0.0



	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf StandardSpecular fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;


		fixed4  _SpecularColor;

		half   _Occlusion;


		void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Specular = _SpecularColor ;
			// Metallic and smoothness come from slider variables
			//o.Metallic = _Metallic;
			o.Occlusion  = _Occlusion;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
