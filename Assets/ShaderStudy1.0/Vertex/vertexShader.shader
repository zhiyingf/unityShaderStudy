Shader "Custom/vertexShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _TestColor("TestColor",Color) = (1,0,0,1)
        _TestInt("TestInt",Int) = 1
        _TestFloat("TestFloat", Float) = 1.0
        _TestRange("TestRange", Range(1, 5)) = 2
        _TestVector("TestVector", Vector) = (1,1,1,1)
        _TestCube("TestCube", Cube) = "" {}
        _Test3D("Test3D", 3D) = ""{}
    }
    SubShader
    {
        Pass
        {
            //Color(1,0,0,1)
            Color[_TestColor]

            //Lighting On //灯光总开关
            //SeparateSpecular On  //（单）镜面反射开关
            //Material
            //{
            //    //Diffuse(0,1,0,1) 
            //    //Diffuse[_TestColor]
            //    //Ambient[_TestColor]
            //    Specular[_TestColor]
            //    Emission[_TestColor] //自发光开关
            //}
            /// 灯光计算公式：
            /// Emission+Ambient*Light Window's Ambient Intensity setting+
            /// (Light Color*Diffuse+Light Color*Specular)

            
        }
    }
    //Fallback "Diffuse"
}
