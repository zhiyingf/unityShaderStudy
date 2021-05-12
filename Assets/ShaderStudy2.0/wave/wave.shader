Shader "Custom/wave"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Arange("Amplitute",float) = 1
        _Frenquncy("Frequncy",float) = 0.5
        _Speed("Speed",float) = 0.5
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
            
            //shader2.0 对property变量需要引用
            float _Arange;
            float _Frenquncy;
            float _Speed;

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;

                //Time since level load (t/20, t, t*2, t*3), use to animate things inside the shaders.
                float timer = _Time.y * _Speed;
                float waver = _Arange * sin(timer + v.vertex.x * _Frenquncy);
                v.vertex.y = v.vertex.y + waver;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            

            fixed4 frag(v2f i) : SV_Target
            {
                //fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 col = fixed4(0,1,0,1);
                // just invert the colors
                col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
