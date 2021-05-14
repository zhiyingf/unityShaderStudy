﻿Shader "Custom/NormalMapOutline"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NormalTex("Normal (RGB)", 2D) = "white" {}

        _EimssionPower("Emission Power",float)=2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalTex;

        ///https://docs.unity3d.com/Manual/SL-SurfaceShaders.html
        /// Surface Shader input structure
        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalTex;
            float3 viewDir;
        };

        
        fixed4 _Color;
        float _EimssionPower;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;

            //读取法线
            float3 tmpNormal = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex));
            o.Normal = tmpNormal;

            //算出法线和视角的点乘
            //float3 tmpFloat = clamp(dot(IN.viewDir, tmpNormal), 0, 1);
            float3 tmpFloat = 1 - clamp(dot(IN.viewDir, tmpNormal), 0, 1);

            //o.Emission = _Color * tmpFloat;
            //o.Emission = _Color * tmpFloat * _EimssionPower;
            o.Emission = _Color * pow(tmpFloat, _EimssionPower);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
