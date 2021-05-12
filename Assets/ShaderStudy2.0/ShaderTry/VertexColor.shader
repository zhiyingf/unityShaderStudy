Shader "Custom/Vertex color"
{
    
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

            //// vertex input: position, color
            //struct appdata {
            //    float4 vertex : POSITION;
            //    fixed4 color : COLOR;
            //};

            //struct v2f {
            //    float4 pos : SV_POSITION;
            //    fixed4 color : COLOR;
            //};

            //v2f vert(appdata v) {
            //    v2f o;
            //    o.pos = UnityObjectToClipPos(v.vertex);
            //    o.color = v.color;
            //    return o;
            //}

            //fixed4 frag(v2f i) : SV_Target { return i.color; }



            ///Visualizing tangents 
            //// vertex input: position, normal
            //struct appdata {
            //    float4 vertex : POSITION;
            //    float3 normal : NORMAL;
            //};

            //struct v2f {
            //    float4 pos : SV_POSITION;
            //    fixed4 color : COLOR;
            //};

            //v2f vert(appdata v) {
            //    v2f o;
            //    o.pos = UnityObjectToClipPos(v.vertex);
            //    o.color.xyz = v.normal * 0.5 + 0.5;
            //    o.color.w = 1.0;
            //    return o;
            //}

            //fixed4 frag(v2f i) : SV_Target { return i.color; }


            //// vertex input: position, tangent
            //struct appdata {
            //    float4 vertex : POSITION;
            //    float4 tangent : TANGENT;
            //};

            //struct v2f {
            //    float4 pos : SV_POSITION;
            //    fixed4 color : COLOR;
            //};

            //v2f vert(appdata v) {
            //    v2f o;
            //    o.pos = UnityObjectToClipPos(v.vertex);
            //    o.color = v.tangent * 0.5 + 0.5;
            //    return o;
            //}

            //fixed4 frag(v2f i) : SV_Target { return i.color; }

            ///visualizes bitangents
            // vertex input: position, normal, tangent
            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float4 color : COLOR;
            };

            v2f vert(appdata v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                // calculate bitangent
                float3 bitangent = cross(v.normal, v.tangent.xyz) * v.tangent.w;
                o.color.xyz = bitangent * 0.5 + 0.5;
                o.color.w = 1.0;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target { return i.color; }


            ENDCG
        }
    }
}
