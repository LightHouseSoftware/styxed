module styxed.protobj.type;

private {
	import styxed.bytemanip;
	import styxed.constants;
}

class Type
{
	private {
		STYX_MESSAGE_TYPE _type;
		ubyte[] _representation;
	}
	
	// create from value
	this(STYX_MESSAGE_TYPE type = STYX_MESSAGE_TYPE.R_ERROR)
	{
		_type = type;
		_representation = [cast(ubyte) type];
	}
	
	// getter
	STYX_MESSAGE_TYPE getType()
	{
		return _type;
	}
	
	// setter
	void setType(STYX_MESSAGE_TYPE type)
	{
		_type = type;
		_representation = [cast(ubyte) type];
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
		_type = cast(STYX_MESSAGE_TYPE) bytes[0];
	}
	
	alias pack this;
}
