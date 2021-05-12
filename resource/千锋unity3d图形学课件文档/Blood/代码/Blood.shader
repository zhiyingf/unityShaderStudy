Shader "Hidden/Blood"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}




		_BloodLength (" length",float) = 0.5

	}
	SubShader
	{
		// No culling or depth
		//Cull Off ZWrite Off ZTest Always

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

			float _BloodLength;


			fixed4 frag (v2f i) : SV_Target
			{

			    float2  tmpUV =  i.uv ;

				float  tmpLength = 0 ;



				if(tmpUV.x < 0.5)
				{

				  	   tmpLength  =  length ( tmpUV - float2(-0.5 ,0.5)) ;

				}
				else
				{


				       tmpLength  =  length (float2(1.5 ,0.5)- tmpUV  ) ;
				}


				tmpLength  *= _BloodLength ;

				fixed4 col = tex2D(_MainTex, i.uv);



				col  = lerp(col,fixed4(1,0,0,1) , 1-clamp(tmpLength,0,1) ) ;

				return col;
			}
			ENDCG
		}
	}
}
