Shader "Custom/Loading"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Speed("Speed",float) = 2
    }
    SubShader
    {
        // No culling or depth
        //Cull Off ZWrite Off ZTest Always
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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float _Speed;

            fixed4 frag(v2f i) : SV_Target
            {
                float angle = _Time.x * _Speed;

                float2 tmpUV = i.uv;
                float2 finalUV = 0;
                tmpUV -= float2(0.5, 0.5);

                finalUV.x = tmpUV.x * cos(angle) - tmpUV.y * sin(angle);
                finalUV.y = tmpUV.x * sin(angle) + tmpUV.y * cos(angle);

                finalUV += float2(0.5, 0.5);


                fixed4 col = tex2D(_MainTex, finalUV);
                // just invert the colors
                //col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
