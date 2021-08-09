module styxed.protobj.fid;

private {
	import styxed.bytemanip;
	import styxed.constants;
}

// file identificator
class Fid
{
	private {
		uint _fid;
		ubyte[] _representation;
	}
	
	// create from value
	this(uint fid = 0xFFFFFFFF)
	{
		_fid = fid;
		_representation = STYX_NOFID;
	}
	
	// getter
	uint getFid()
	{
		return _fid;
	}
	
	// setter
	void setFid(uint fid)
	{
		_fid = fid;
		_representation = buildFromValue!uint(BYTE_ORDER.LITTLE_ENDIAN, 0xFFFFFFFF);
	}
	
	// pack to bytes array
	ubyte[] pack()
	{
		return _representation;
	}
	
	// unpack from bytes array
	void unpack(ubyte[] bytes)
	{
		_representation = bytes;
		_fid = buildFromBytes!uint(BYTE_ORDER.LITTLE_ENDIAN, bytes);
	}
	
	alias pack this;
}
