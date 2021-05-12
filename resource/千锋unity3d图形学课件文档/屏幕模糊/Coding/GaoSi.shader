Shader "Custom/GaoSi"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}


		_Ambient ("Ambient", float) = 0.001
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;


			float   _Ambient;

			fixed4 frag (v2f i) : SV_Target
			{

			   float2  tmpUV =  i.uv ;


			 //  float    ambient = 0.001 ;

				fixed4 col = tex2D(_MainTex, tmpUV);
				// just invert the colors
				//col = 1 - col;


				fixed4 col2 = tex2D(_MainTex, tmpUV+float2(-_Ambient,0));


				fixed4 col3 = tex2D(_MainTex, tmpUV+float2(0,-_Ambient));

			  	fixed4 col4 = tex2D(_MainTex, tmpUV+float2(_Ambient,0));

			   fixed4 col5 = tex2D(_MainTex, tmpUV+float2(0,_Ambient));



			   col   =  (col + col2 +col3+col4+col5) /5.0 ;


				return col;
			}
			ENDCG
		}
	}
}
