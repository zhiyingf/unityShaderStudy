Shader "Cum/OffsetRed"
{
    
    SubShader
    {
        // No culling or depth
        //Cull Off ZWrite Off ZTest Always

        ///Offset Factor,Units
        /// 用于定义深度偏移
        /// 
        /// Factor表示Z缩放的最大斜率的值，值越小越靠前
        /// Units表示可分辨的最小深度缓冲区的值。微调buffer值，值越小越靠前
        /// 
        /// 使用条件：两个物体在同一位置，做微调，实现更好的渲染
        /// 
        /// 
        ///当两个大小相同的物体重合或部分重合时 problem:
        /// 重合部分 颜色抖动、参差不齐
        /// 原因是：unity3D渲染时无法分辨哪个物体在前，哪个物体在后

        Pass
        {
            ///1
            offset -1,0

            ///2
            offset 0,0

            Color(1,0,0,1)
        }
    }
}
