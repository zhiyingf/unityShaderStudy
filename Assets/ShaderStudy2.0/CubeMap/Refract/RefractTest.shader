Shader "Custom/RefractTest"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}

        _Rate("Rate" ,float) = 1.1

       _CubeMap("Cube Map", CUBE) = ""{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert vertex:MyVertex

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        samplerCUBE   _CubeMap;

        struct Input
        {
            float2 uv_MainTex;
            float3 refr;
        };

        float  _Rate;
        fixed4 _Color;


        void MyVertex(inout appdata_full v, out Input data)
        {
            UNITY_INITIALIZE_OUTPUT(Input, data);

            //获得物体局部坐标系下的法线方向（全局---局部）
            float3 localNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
            //获得入射角方向
            float3  viewDir = -WorldSpaceViewDir(v.vertex);
            //计算折射角
            data.refr = refract(viewDir, localNormal, _Rate);
        }

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        //UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        //UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;

            
            //o.Emission = texCUBE(_CubeMap, IN.refr).rgb;
            o.Albedo = texCUBE(_CubeMap, IN.refr).rgb;
            //o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
