Shader "Custom/DebugUV 1"
{
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
            {//appdata从meshrender里面传入的
                float4 vertex : POSITION;
                float4 uv : TEXCOORD0;
            };
            
            //v2f: vertex shader to fragment shader
            struct v2f
            {//语义 SV_POSITION：表示经过mvp矩阵转化到屏幕坐标
                float4 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = float4(v.uv.xy, 0, 0);
                return o;
            }

            //SV_Target: 输出到哪个（相机）render target（默认0）
            half4 frag(v2f i) : SV_Target
            {//Here, UV coordinates are visualized as red and green colors, while an additional blue tint has been applied to coordinates outside of the 0 to 1 range:
                //frac函数返回标量或每个矢量中各分量的小数部分。
                half4 c = frac(i.uv);//c.rgba
                //saturate如果x取值小于0，则返回值为0。如果x取值大于1，则返回值为1。若x在0到1之间，则直接返回x的值
                //输入参数只要有其中一个不为 0，则返回 true。||运算
                if (any(saturate(i.uv) - i.uv)) {
                    c.b = 0.5;
                }
                return c;
            }
            ENDCG
        }
    }
}
