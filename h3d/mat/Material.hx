package h3d.mat;
import h3d.mat.Data;

class Material {
	
	public var bits(default,null) : Int;
	public var culling(default,setCulling) : Face;
	public var depthWrite(default,setDepthWrite) : Bool;
	public var depthTest(default,setDepthTest) : Compare;
	public var blendSrc(default,setBlendSrc) : Blend;
	public var blendDst(default,setBlendDst) : Blend;
	public var colorMask(default,setCM) : Int;
	public var shader : Shader;
	
	public function new(shader) {
		bits = 0;
		this.shader = shader;
		this.culling = Face.Back;
		this.depthWrite = true;
		this.depthTest = Compare.Less;
		this.blendSrc = Blend.One;
		this.blendDst = Blend.Zero;
		this.colorMask = 15;
	}
	
	public function blend(src, dst) {
		blendSrc = src;
		blendDst = dst;
	}
	
	public function depth( write, test ) {
		this.depthWrite = write;
		this.depthTest = test;
	}
	
	public function setColorMask(r, g, b, a) {
		this.colorMask = (r?1:0) | (g?2:0) | (b?4:0) | (a?8:0);
	}

	function setCulling(f) {
		culling = f;
		bits = (bits & ~(3 << 0)) | (Type.enumIndex(f) << 0);
		return f;
	}
	
	function setDepthWrite(b) {
		depthWrite = b;
		bits = (bits & ~(1 << 2)) | ((b ? 1 : 0) << 2);
		return b;
	}
	
	function setDepthTest(c) {
		depthTest = c;
		bits = (bits & ~(7 << 3)) | (Type.enumIndex(c) << 3);
		return c;
	}
	
	function setBlendSrc(b) {
		blendSrc = b;
		bits = (bits & ~(15 << 6)) | (Type.enumIndex(b) << 6);
		return b;
	}

	function setBlendDst(b) {
		blendDst = b;
		bits = (bits & ~(15 << 10)) | (Type.enumIndex(b) << 10);
		return b;
	}
	
	function setCM(m) {
		m &= 15;
		colorMask = m;
		bits = (bits & ~(15 << 14)) | (m << 14);
		return m;
	}

}