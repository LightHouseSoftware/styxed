module styxed.protobj.qid;

private {
	import styxed.bytemanip;
	import styxed.constants;
	import styxed.filestat;
}

// tag identificator
class Qid
{
	private {
		STYX_QID_TYPE _type;
		uint _vers;
		ulong _path;
		ubyte[] _representation;
	}
	
	// create from value
	this(STYX_QID_TYPE type = STYX_QID_TYPE.QTFILE, uint vers = 0, ulong path = 0)
	{
		_type = type;
		_vers = vers;
		_path = path;
		_representation ~= buildFromValue!ubyte(BYTE_ORDER.LITTLE_ENDIAN, cast(ubyte) type);
		_representation ~= buildFromValue!uint(BYTE_ORDER.LITTLE_ENDIAN, cast(ubyte) vers);
		_representation ~= buildFromValue!ulong(BYTE_ORDER.LITTLE_ENDIAN, cast(ubyte) path);
	}
	
	// getter
	STYX_QID_TYPE getType()
	{
		return _type;
	}
	
	uint getVers()
	{
		return _vers;
	}
	
	ulong getPath()
	{
		return _path;
	}
	
	// setter
	void setType(STYX_QID_TYPE type)
	{
		_type = type;
		_representation = buildFromValue!ubyte(BYTE_ORDER.LITTLE_ENDIAN, type);
	}
	
	void setVers(uint vers)
	{
		_vers = vers;
		_representation = buildFromValue!uint(BYTE_ORDER.LITTLE_ENDIAN, vers);
	}
	
	void setPath(ulong path)
	{
		_path = path;
		_representation = buildFromValue!ulong(BYTE_ORDER.LITTLE_ENDIAN, path);
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
		_type = cast(STYX_QID_TYPE) buildFromBytes!ubyte(BYTE_ORDER.LITTLE_ENDIAN, bytes[0]);
		_vers = buildFromBytes!uint(BYTE_ORDER.LITTLE_ENDIAN, bytes[1..5]);
		_path = buildFromBytes!ulong(BYTE_ORDER.LITTLE_ENDIAN, bytes[5..13]);
	}
	
	alias pack this;
}
