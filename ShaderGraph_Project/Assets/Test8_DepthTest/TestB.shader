// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/TestB"
{
	Properties
	{
        _MainTex ("贴图", 2D) = "white" {}
		_BackgroundColor ("背景颜色", Color) = (1, 1, 1, 1)
	}
	SubShader
	{
		Pass
		{
			///这段代码是B中独有的
			Tags {"Queue" = "Transparent"}
            Blend SrcAlpha OneMinusSrcAlpha
            //Test1
			ZTest Greater
            
            // //Test2
            // ZTest Less

            // //Test3
            // ZWrite On
            // ZTest GEqual

            // //Test4
            // ZWrite On
            // ZTest LEqual

            // //Test5
            // ZWrite On
            // ZTest Equal 

            // //Test6
            // ZWrite On
            // ZTest NotEqual

            // //Test7
            // ZWrite On
            // ZTest Always

			///
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
            //从程序传染顶点渲染器的数据
			struct a2v
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};
            //从顶点渲染器传入片元渲染器的数据
			struct v2f
			{			
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
 
			//格子背景
            sampler2D _MainTex;
			fixed4 _BackgroundColor;
            
            //顶点着色器
			v2f vert (a2v v)
			{
				v2f o;
                //将像素空间从模型转为裁剪空间
				o.position = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;

			}
			//片段着色器
			fixed4 frag (v2f o) : COLOR
			{
				fixed4 renderTex = tex2D(_MainTex, o.uv);
                //合成贴图、遮罩、线的像素
                return renderTex * _BackgroundColor;
			}
			ENDCG
		}
	}
}

