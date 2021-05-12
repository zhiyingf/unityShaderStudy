using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Test : MonoBehaviour
{
    public GameObject target;
    // Start is called before the first frame update
    void Start()
    {
        //从局部（物体）坐标到世界坐标 --------------------------M
        Vector3 posWorld = transform.parent.localToWorldMatrix.MultiplyPoint(transform.localPosition);
        Debug.Log(posWorld);//脚本所挂的obj脱离父类（即在世界下坐标）坐标

        //从世界坐标转换到对应的父类下的局部（物体）坐标-----------V
        Vector3 targetPos = target.transform.worldToLocalMatrix.MultiplyPoint(posWorld);
        Debug.Log(targetPos);//脚本所挂的obj挂到相机下的坐标
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
