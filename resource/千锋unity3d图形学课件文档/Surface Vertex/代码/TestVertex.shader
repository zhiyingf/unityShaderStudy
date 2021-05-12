Shader "Custom/TestVertex" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0


		_ChangeRange("Position",float) = 2
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert  vertex:myvert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;


		half  _ChangeRange ;


		// 顶点着色器   改变位置。
		void   myvert (inout appdata_base   v )
		{

		 //  v.vertex.xyz  *=  _ChangeRange ;

		   v.vertex.xyz  += v.normal* _ChangeRange ;
		  
		}

		void surf (Input IN, inout SurfaceOutput  o )
		 {
		   
		     o.Albedo =  tex2D(_MainTex,IN.uv_MainTex).rgb ;

   
		}
		ENDCG
	}
	FallBack "Diffuse"
}
