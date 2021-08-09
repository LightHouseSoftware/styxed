module styxed.protobj.tag;

private {

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
		_representation = STYX_NOTAG;
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
		_representation = buildFromValue!ushort(BYTE_ORDER.LITTLE_ENDIAN, 0xFFFF);
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
}
