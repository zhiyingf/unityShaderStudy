Shader "Custom/Fresnel" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}

		_SubTex ("Albedo (RGB)", CUBE) = "white" {}

		_EatRatio ("Ratio  ",float ) = 1.2

		 _FresnelBias ("fresnelBias",float) =1

		 _FresnelScale("fresnelScale",float) = 1

		 _FresnelPower ("fresnelPower",float) = 0.5



	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf   Lambert   vertex:MyVertex 

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		samplerCUBE  _SubTex;

		struct Input {
			float2 uv_MainTex;
			float3   worldRefl ;

			float3   refract ;

			float    reflectFact ;

		};


		float   _EatRatio;

		fixed4 _Color;

		float  	_FresnelBias;

		 float  _FresnelScale;

		 float   _FresnelPower;

	     void  MyVertex(inout appdata_full v, out Input data)
		 {

		       UNITY_INITIALIZE_OUTPUT(Input,data);

			  float3  localNormal =  normalize( mul(v.normal ,(float3x3)unity_WorldToObject));


			  float3    viewDir  =   -WorldSpaceViewDir(v.vertex);


			  data.refract =  refract(viewDir,localNormal,_EatRatio);

			  data.reflectFact  = _FresnelBias  +  _FresnelScale *pow(1+dot (viewDir,localNormal),_FresnelPower) ;
		    
		 }

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			//fixed4 cflect = tex2D (_MainTex, IN.worldRefl) ;



			//fixed4 cfract = tex2D (_MainTex, IN.refract) ;



			fixed4 cflect = texCUBE (_SubTex, IN.worldRefl) ;
			fixed4 cfract = texCUBE (_SubTex, IN.refract) ;


			o.Albedo =   IN.reflectFact * cflect.rgb  + (1-  IN.reflectFact)* cfract.rgb ;
		
			o.Alpha = cflect.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
