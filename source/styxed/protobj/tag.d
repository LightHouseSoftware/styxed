module styxed.protobj.tag;

private {
	import styxed.bytemanip;
	import styxed.constants;
}

// tag identificator
class Tag
{
	private {
		ushort _tag;
		
		ubyte[] _representation;
	}
	
	// create from value
	this(ushort tag = 0xFFFF)
	{
		_tag = tag;
		_representation = buildFromValue!ushort(BYTE_ORDER.LITTLE_ENDIAN, tag);
	}
	
	// getter
	ushort getTag()
	{
		return _tag;
	}
	
	// setter
	void setTag(ushort tag)
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
