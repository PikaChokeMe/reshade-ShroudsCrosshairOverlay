namespace ShroudsCrosshair
{

/**********************************************************
 *  Constants
 **********************************************************/
#define CROSSHAIR_PATH   "ShroudCrosshair.png"
#define CROSSHAIR_WIDTH  32.0
#define CROSSHAIR_HEIGHT 32.0

/**********************************************************
 *  Textures
 **********************************************************/
texture crosshairTexure <source=CROSSHAIR_PATH;>
{
    Width = CROSSHAIR_WIDTH;
    Height = CROSSHAIR_HEIGHT;
    Format = RGBA8;
};

sampler    crosshairSampler     { Texture = crosshairTexure; };

/**********************************************************
 *  Vertex Shader
 **********************************************************/
float4 vs_quad(uint vid : SV_VertexID, out float2 uv : TEXCOORD) : SV_POSITION {
  uv.y = vid % 2, uv.x = vid / 2;
  
  return float4(
    (uv.x*2-1.) * CROSSHAIR_WIDTH * BUFFER_RCP_WIDTH,
	(1.-uv.y*2) * CROSSHAIR_HEIGHT * BUFFER_RCP_HEIGHT, 
	0, 
	1
  );
}

/**********************************************************
 *  PixelShader
 **********************************************************/
float4 ps_crosshair(float4 pos : SV_POSITION, float2 uv : TEXCOORD) : SV_Target {
    return tex2D(crosshairSampler, uv);
}

/**********************************************************
 *  Technique
 **********************************************************/
    technique shrouds_crosshair<enabled=true;>
    {
        pass crosshairPass {
			VertexCount = 4;
			PrimitiveTopology = TRIANGLESTRIP;
			
            VertexShader = vs_quad;
            PixelShader = ps_crosshair;

            BlendEnable = true;
            SrcBlend = SRCALPHA;
            DestBlend = INVSRCALPHA;
        }
    }

} // Namespace.