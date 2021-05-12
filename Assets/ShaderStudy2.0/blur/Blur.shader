Shader "Custom/Blur"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        //_BlurDis("BlurDis",float)=0.001
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
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float _BlurDis;

            fixed4 frag (v2f i) : SV_Target
            {
                float2 tmp = i.uv;
                fixed4 col = tex2D(_MainTex, tmp);

                tmp += float2(0, _BlurDis);
                fixed4 colUp = tex2D(_MainTex, tmp);

                tmp += float2(0, -_BlurDis);
                fixed4 colDown = tex2D(_MainTex, tmp);

                tmp += float2(-_BlurDis, 0);
                fixed4 colLeft = tex2D(_MainTex, tmp);

                tmp += float2(_BlurDis, 0);
                fixed4 colRight = tex2D(_MainTex, tmp);

                col = (col + colUp + colDown + colLeft + colRight) / 5;

                // just invert the colors
                /*fixed4 col = tex2D(_MainTex, i.uv);
                col.rgb = 1 - col.rgb;*/

                return col;
            }
            ENDCG
        }
    }
}
