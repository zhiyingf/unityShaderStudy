Shader "Hidden/OffsetGreen"
{
    
    SubShader
    {
        // No culling or depth
        //Cull Off ZWrite Off ZTest Always

        Pass
        {
            ///1
            //重合的上面的面显示正常，但是正前方的面仍然有抖动缺陷
            /*offset 0,0*/
            //重合的上、前面颜色不一
           /* offset 0,-1*/

            ///2
            offset 0,-1

            //完美解决
            offset 0,1
            Color(0,1,0,1)
        }
    }
}
