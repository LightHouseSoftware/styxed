module styxed.protobj.tag;

private {
	import styxed.bytemanip;
	import styxed.constants;
}

// tag identificator
class Tag
{
	private {
		uint _tag;
		ubyte[] _representation;
	}
	
	// create from value
	this(uint tag = 0xFFFF)
	{
		_tag = tag;
		_representation = buildFromValue!uint(BYTE_ORDER.LITTLE_ENDIAN, tag);
	}
	
	// getter
	uint getTag()
	{
		return _tag;
	}
	
	// setter
	void setTag(uint tag)
	{
		_tag = tag;
		_representation = buildFromValue!ushort(BYTE_ORDER.LITTLE_ENDIAN, tag);
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
		_tag = buildFromBytes!ushort(BYTE_ORDER.LITTLE_ENDIAN, bytes);
	}
	
	alias pack this;
}
