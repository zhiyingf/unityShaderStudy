﻿Shader "Hidden/Wave"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}

		_Arange("Amplitute",float) = 1

		_Frenquncy("Frenquncy",float) = 0.5


		_Speed("Speed",float) = 0.5
	}
	SubShader
	{


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


		   float   _Frenquncy ;

			float    _Arange ;

			float   _Speed ;


			v2f vert (appdata v)
			{
				v2f o;


				float  timer =  _Time.y *  _Speed ;



				  float  waver  = _Arange* sin(timer +  v.vertex.x *_Frenquncy );


				  v.vertex.y =  v.vertex.y + waver ;

				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;

	


			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				// just invert the colors
				//col = 1 - col;
				return col;
			}
			ENDCG
		}
	}
}
