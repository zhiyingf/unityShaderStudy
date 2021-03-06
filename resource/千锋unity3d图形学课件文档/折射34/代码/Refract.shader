Shader "Custom/Refract" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	

	   _Rate("Rate" ,float) = 1.1

	   _CubeMap("Cube Map", CUBE) = ""{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert 	vertex:MyVertex

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		samplerCUBE   _CubeMap;

		struct Input {
			float2 uv_MainTex;

			float3  refr ;
		};


		fixed4 _Color;

		float  _Rate;

		void  MyVertex(inout appdata_full v, out Input data)
		{
				 UNITY_INITIALIZE_OUTPUT(Input,data);

				 //  由世界 变成 物体的
				//float3  localNormal=   normalize(mul(v.normal ,（float3x3）unity_WorldToObject));

				float3   localNormal = normalize(mul (v.normal, (float3x3)unity_WorldToObject));
	
		
				float3  viewDir= -WorldSpaceViewDir(v.vertex)  ;

				data.refr=    refract(viewDir,localNormal,_Rate)  ;

		}


		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

			  o.Albedo=   texCUBE(_CubeMap,IN.refr).rgb ;
		//	o.Albedo = c.rgb;
	
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
