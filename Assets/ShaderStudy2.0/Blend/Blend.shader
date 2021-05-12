Shader "Custom/Blend"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        //Cull Off ZWrite Off ZTest Always

        ///Blend指令：Blend   要渲染的像素 * factorA      屏幕已经渲染的gbuffer里面的像素 * factorB    


        ///SrcColor要渲染的颜色
        ///DstColor是Gbuffer里的颜色，默认是黑色(0,0,0)
        ///透明alpha=0，取Gbuffer的值； 不透明alpha=1，取SrcColor（纹理）的值
         // Enable regular alpha blending for this Pass
        //Blend SrcAlpha OneMinusSrcAlpha

        //Blend SrcColor zero

        ///为什么在Game中点击cube颜色会发生变化？？？？
        Blend SrcColor one

        //Blend DstColor zero


        /// BlendOp  :  指定  将要渲染像素   和   gbuffer 里面的像素 逻辑运算 。
        ///当这个指令 存在  ，Blend  这个指令 就会被忽略 。
        /// 
        
        //BlendOp Sub
        //取Gbuffer的color 全黑
        BlendOp min


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

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                //col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
