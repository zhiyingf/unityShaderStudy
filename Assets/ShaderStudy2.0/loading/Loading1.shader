// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Loading1"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}


		_Speed ("Speed ",float) = 2
	}
	SubShader
	{
		// No culling or depth
	//Cull Off ZWrite Off 
	
	ZTest Always


	  Blend SrcAlpha OneMinusSrcAlpha

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


			float  _Speed ;


			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;	            

			fixed4 frag (v2f i) : SV_Target
			{

			    float2 tmpUV = i.uv ;

				///旋转操作：
				/// 1.平移回原点
				/// 2.旋转
				/// 3.平移回去
				
				//1.
				tmpUV  -= float2(0.5,0.5) ;



				if(length(tmpUV)>0.5)
				{

				    return fixed4(0,0,0,0)  ;
				}


				float2  finalUV = 0 ;

				//2.
				float  angle = _Time.x*_Speed ;

				finalUV.x = tmpUV.x* cos(angle) -tmpUV.y*sin (angle)  ;


				finalUV.y =  tmpUV.x *sin(angle) + tmpUV.y *cos(angle);



			    /*finalUV.x = tmpUV.x* cos(angle) +tmpUV.y*sin (angle)  ;


				finalUV.y =  -tmpUV.x *sin(angle) + tmpUV.y *cos(angle);*/

				//3.
				finalUV += float2(0.5 ,0.5) ;


				fixed4 col = tex2D(_MainTex, finalUV);
				// just invert the colors
				//col = 1 - col;


				return col;
			}
			ENDCG
		}
	}
}
