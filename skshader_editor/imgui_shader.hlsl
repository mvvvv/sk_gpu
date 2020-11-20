cbuffer vertexBuffer : register(b0) {
    float4x4 ProjectionMatrix;
};
struct VS_INPUT {
    float3 pos  : SV_POSITION;
	float3 norm : NORMAL0;
    float2 uv   : TEXCOORD0;
	float4 col  : COLOR0;
};

struct PS_INPUT {
    float4 pos : SV_POSITION;
    float4 col : COLOR0;
    float2 uv  : TEXCOORD0;
};

sampler   sampler0 : register(s0);
Texture2D texture0 : register(t0);

PS_INPUT vs(VS_INPUT input) {
    PS_INPUT output;
    output.pos = mul( ProjectionMatrix, float4(input.pos.xy, 0.f, 1.f));
    output.col = input.col;
    output.uv  = input.uv;
    return output;
}

float4 ps(PS_INPUT input) : SV_Target {
    return input.col * texture0.Sample(sampler0, input.uv);
}