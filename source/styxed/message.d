module styxed.message;

private {
	import styxed.bytemanip;
	import styxed.constants;
}

// Styx message types
enum STYX_MESSAGE_TYPE : ubyte
{
	// version
	T_VERSION = 100,
    R_VERSION,
    // auth
    T_AUTH,
    R_AUTH,
    // attach
    T_ATTACH,
    R_ATTACH,
    // error
    T_ERROR, 	/* ILLEGAL ! */
    R_ERROR,
    // flush
    T_FLUSH,
    R_FLUSH,
    // walk
    T_WALK,
    R_WALK,
    // open
    T_OPEN,
    R_OPEN,
    // create
    T_CREATE,
    R_CREATE,
    // read
    T_READ,
    R_READ,
    // write
    T_WRITE,
    R_WRITE,
    // clunk
    T_CLUNK,
    R_CLUNK,
    // remove
    T_REMOVE,
    R_REMOVE,
    // stat
    T_STAT,
    R_STAT,
    // wstat
    T_WSTAT,
    R_WSTAT,
    // ?
    //T_MAX
}


// Styx message (in byte view)
final class StyxMessage
{
	private 
	{
		alias RawBytes = ubyte[];
		RawBytes[string] _fields;
	}
	
	this() 
	{
		
	}
	
	void unpack(ref ubyte[] bytes) 
	{
		/* GENERAL FIELDS OF MESSAGES */
		_fields["size"] = bytes[0..4]; 					// 4 bytes - is size of message
		_fields["type"] = [bytes[4]];					// 1 byte - is type of message
		_fields["tag"] = bytes[5..7];					// 2 bytes - is a tag of each message

		switch (cast(STYX_MESSAGE_TYPE) _fields["type"][0])
		{
			/* SERVER MESSAGES */
			case STYX_MESSAGE_TYPE.R_ATTACH:
				// size[4] Rattach tag[2] qid[13]
				_fields["qid"] = bytes[7..20];
				break;
			case STYX_MESSAGE_TYPE.R_AUTH:
				// size[4] Rauth tag[2] aqid[13]
				_fields["aqid"] = bytes[7..20];
				break;
			case STYX_MESSAGE_TYPE.R_CLUNK:
				// size[4] Rclunk tag[2]
				break;
			case STYX_MESSAGE_TYPE.R_CREATE:
				// size[4] Rcreate tag[2] qid[13] iounit[4]
				_fields["qid"] = bytes[7..20];
				_fields["iounit"] = bytes[20..24];
				break;
			case STYX_MESSAGE_TYPE.R_ERROR:
				// size[4] Rerror tag[2] ename[s]
				_fields["ename"] = unpackVLF(bytes[7..$]);
				break;
			case STYX_MESSAGE_TYPE.R_FLUSH:
				// size[4] Rflush tag[2]
				break;
			case STYX_MESSAGE_TYPE.R_OPEN:
				// size[4] Ropen tag[2] qid[13] iounit[4]
				_fields["qid"] = bytes[7..20];
				_fields["iounit"] = bytes[20..24];
				break;
			case STYX_MESSAGE_TYPE.R_READ:
				// size[4] Rread tag[2] count[4] data[count]
				_fields["count"] = bytes[7..11];
				_fields["data"] = bytes[11..$];
				break;
			case STYX_MESSAGE_TYPE.R_REMOVE:
				// size[4] Rremove tag[2]
				break;
			case STYX_MESSAGE_TYPE.R_STAT:
				// size[4] Rstat tag[2] stat[n]
				_fields["stat"] = unpackVLF(bytes[7..$]);
				break;
			case STYX_MESSAGE_TYPE.R_VERSION:
				// size[4] Rversion tag[2] msize[4] version[s]
				_fields["msize"] = bytes[7..11];
				_fields["version"] = unpackVLF(bytes[11..$]);
				break;
			case STYX_MESSAGE_TYPE.R_WALK:
				// size[4] Rwalk tag[2] nwqid[2] nwqid*(wqid[13])
				_fields["nwqid"] = bytes[7..9];
				if (bytes.length > 9)
				{
					// wqid[13]
					_fields["wqid"] = bytes[9..22];
				}
				break;
			case STYX_MESSAGE_TYPE.R_WRITE:
				// size[4] Rwrite tag[2] count[4]
				_fields["count"] = bytes[7..11];
				break;
			case STYX_MESSAGE_TYPE.R_WSTAT:
				// size[4] Rwstat tag[2] 
				break;
				
			/* CLIENT MESSAGES */
			case STYX_MESSAGE_TYPE.T_ATTACH:
				// size[4] Tattach tag[2] fid[4] afid[4] uname[s] aname[s]
				_fields["fid"] = bytes[7..11];
				_fields["afid"] = bytes[11..15];
				auto vlf = unpackVLF(bytes[15..$]);
				_fields["uname"] = vlf;
				vlf =  unpackVLF(bytes[vlf.length + 2..$]);
				_fields["aname"] = vlf;
				break;
			case STYX_MESSAGE_TYPE.T_AUTH:
				// size[4] Tauth tag[2] afid[4] uname[s] aname[s]
				_fields["afid"] = bytes[7..11];
				auto vlf = unpackVLF(bytes[11..$]);
				_fields["uname"] = vlf;
				vlf =  unpackVLF(bytes[vlf.length + 2..$]);
				_fields["aname"] = vlf;
				break;
			case STYX_MESSAGE_TYPE.T_CLUNK:
				//size[4] Tclunk tag[2] fid[4]
				_fields["fid"] = bytes[7..11];
				break;
			case STYX_MESSAGE_TYPE.T_CREATE:
				// size[4] Tcreate tag[2] fid[4] name[s] perm[4] mode[1]
				_fields["fid"] = bytes[7..11];
				auto vlf = unpackVLF(bytes[11..$]);
				_fields["name"] = vlf;
				auto vlf2 = vlf.length + 2;
				_fields["perm"] = bytes[vlf2..vlf2 + 4];
				_fields["mode"] = [vlf[$ - 1]];
				break;
			case STYX_MESSAGE_TYPE.T_ERROR:
				// ILLEGAL ! IMPOSSIBLE TYPE OF MESSAGE !
				break;
			case STYX_MESSAGE_TYPE.T_FLUSH:
				// size[4] Tflush tag[2] oldtag[2]
				_fields["oldtag"] = bytes[7..9];
				break;
			case STYX_MESSAGE_TYPE.T_OPEN:
				// size[4] Topen tag[2] fid[4] mode[1]
				_fields["fid"] = bytes[7..11];
				_fields["mode"] = [bytes[11]];
				break;
			case STYX_MESSAGE_TYPE.T_READ:
				// size[4] Tread tag[2] fid[4] offset[8] count[4]
				_fields["fid"] = bytes[7..11];
				_fields["offset"] = bytes[11..19];
				_fields["count"] = bytes[19..23];
				break;
			case STYX_MESSAGE_TYPE.T_REMOVE:
				// size[4] Tremove tag[2] fid[4]
				_fields["fid"] = bytes[7..11];
				break;
			case STYX_MESSAGE_TYPE.T_STAT:
				// size[4] Tstat tag[2] fid[4]
				_fields["fid"] = bytes[7..11];
				break;
			case STYX_MESSAGE_TYPE.T_VERSION:
				// size[4] Tversion tag[2] msize[4] version[s]
				_fields["msize"] = bytes[7..11];
				_fields["version"] = unpackVLF(bytes[11..$]);
				break;
			case STYX_MESSAGE_TYPE.T_WALK:
				// size[4] Twalk tag[2] fid[4] newfid[4] nwname[2] nwname*(wname[s])
				_fields["fid"] = bytes[7..11];
				_fields["newfid"] = bytes[11..15];
				_fields["nwname"] = bytes[15..17];
				if (bytes.length > 17)
				{
					_fields["wname"] = unpackVLF(bytes[17..$]);
				}
				break;
			case STYX_MESSAGE_TYPE.T_WRITE:
				// size[4] Twrite tag[2] fid[4] offset[8] count[4] data[count]
				_fields["fid"] = bytes[7..11];
				_fields["offset"] = bytes[11..19];
				_fields["count"] = bytes[19..23];
				_fields["data"] = bytes[23..$];
				break;
			case STYX_MESSAGE_TYPE.T_WSTAT:
				// size[4] Twstat tag[2] fid[4] stat[n]
				_fields["fid"] = bytes[7..11];
				_fields["stat"] = unpackVLF(bytes[11..$]);
				break;
			default:
				break;
		}
	}
	
	ubyte[] pack()
	{
		ubyte[] bytes;
		// size calculates in the end
		bytes ~= _fields["type"];		// 1 byte - is type of message
		bytes ~= _fields["tag"];		// 2 bytes - is a tag of each message
		
		switch (cast(STYX_MESSAGE_TYPE) _fields["type"][0])
		{
			/* SERVER MESSAGES */
			case STYX_MESSAGE_TYPE.R_ATTACH:
				// size[4] Rattach tag[2] qid[13]
				bytes ~= _fields["qid"];
				break;
			case STYX_MESSAGE_TYPE.R_AUTH:
				// size[4] Rauth tag[2] aqid[13]
				bytes ~= _fields["aqid"];
				break;
			case STYX_MESSAGE_TYPE.R_CLUNK:
				// size[4] Rclunk tag[2]
				break;
			case STYX_MESSAGE_TYPE.R_CREATE:
				// size[4] Rcreate tag[2] qid[13] iounit[4]
				bytes ~= _fields["qid"];
				bytes ~= _fields["iounit"];
				break;
			case STYX_MESSAGE_TYPE.R_ERROR:
				// size[4] Rerror tag[2] ename[s]
				bytes ~= packVLF(_fields["ename"]);
				break;
			case STYX_MESSAGE_TYPE.R_FLUSH:
				// size[4] Rflush tag[2]
				break;
			case STYX_MESSAGE_TYPE.R_OPEN:
				// size[4] Ropen tag[2] qid[13] iounit[4]
				bytes ~= _fields["qid"];
				bytes ~= _fields["iounit"];
				break;
			case STYX_MESSAGE_TYPE.R_READ:
				// size[4] Rread tag[2] count[4] data[count]
				bytes ~= _fields["count"];
				bytes ~= _fields["data"];
				break;
			case STYX_MESSAGE_TYPE.R_REMOVE:
				// size[4] Rremove tag[2]
				break;
			case STYX_MESSAGE_TYPE.R_STAT:
				// size[4] Rstat tag[2] stat[n]
				bytes ~= packVLF(_fields["stat"]);
				break;
			case STYX_MESSAGE_TYPE.R_VERSION:
				// size[4] Rversion tag[2] msize[4] version[s]
				bytes ~= _fields["msize"];
				bytes ~= packVLF(_fields["version"]);
				break;
			case STYX_MESSAGE_TYPE.R_WALK:
				// size[4] Rwalk tag[2] nwqid[2] nwqid*(wqid[13])
				bytes ~= _fields["nwqid"];
				if ("nwqid" in _fields)
				{
					// wqid[13]
					bytes ~= _fields["wqid"];
				}
				break;
			case STYX_MESSAGE_TYPE.R_WRITE:
				// size[4] Rwrite tag[2] count[4]
				bytes ~= _fields["count"];
				break;
			case STYX_MESSAGE_TYPE.R_WSTAT:
				// size[4] Rwstat tag[2] 
				break;
				
			/* CLIENT MESSAGES */
			case STYX_MESSAGE_TYPE.T_ATTACH:
				// size[4] Tattach tag[2] fid[4] afid[4] uname[s] aname[s]
				bytes ~= _fields["fid"];
				bytes ~= _fields["afid"];
				bytes ~= packVLF(_fields["uname"]);
				bytes ~= packVLF(_fields["aname"]);
				break;
			case STYX_MESSAGE_TYPE.T_AUTH:
				// size[4] Tauth tag[2] afid[4] uname[s] aname[s]
				bytes ~= _fields["afid"];
				bytes ~= packVLF(_fields["uname"]);
				bytes ~= packVLF(_fields["aname"]);
				break;
			case STYX_MESSAGE_TYPE.T_CLUNK:
				//size[4] Tclunk tag[2] fid[4]
				bytes ~= _fields["fid"];
				break;
			case STYX_MESSAGE_TYPE.T_CREATE:
				// size[4] Tcreate tag[2] fid[4] name[s] perm[4] mode[1]
				bytes ~= _fields["fid"];
				bytes ~= packVLF(_fields["name"]);
				bytes ~= _fields["perm"];
				bytes ~= _fields["mode"];
				break;
			case STYX_MESSAGE_TYPE.T_ERROR:
				// ILLEGAL ! IMPOSSIBLE TYPE OF MESSAGE !
				break;
			case STYX_MESSAGE_TYPE.T_FLUSH:
				// size[4] Tflush tag[2] oldtag[2]
				bytes ~= _fields["oldtag"];
				break;
			case STYX_MESSAGE_TYPE.T_OPEN:
				// size[4] Topen tag[2] fid[4] mode[1]
				bytes ~= _fields["fid"];
				bytes ~= _fields["mode"];
				break;
			case STYX_MESSAGE_TYPE.T_READ:
				// size[4] Tread tag[2] fid[4] offset[8] count[4]
				bytes ~= _fields["fid"];
				bytes ~= _fields["offset"];
				bytes ~= _fields["count"];
				break;
			case STYX_MESSAGE_TYPE.T_REMOVE:
				// size[4] Tremove tag[2] fid[4]
				bytes ~= _fields["fid"];
				break;
			case STYX_MESSAGE_TYPE.T_STAT:
				// size[4] Tstat tag[2] fid[4]
				bytes ~= _fields["fid"];
				break;
			case STYX_MESSAGE_TYPE.T_VERSION:
				// size[4] Tversion tag[2] msize[4] version[s]
				bytes ~= _fields["msize"];
				bytes ~= packVLF(_fields["version"]);
				break;
			case STYX_MESSAGE_TYPE.T_WALK:
				// size[4] Twalk tag[2] fid[4] newfid[4] nwname[2] nwname*(wname[s])
				bytes ~= _fields["fid"];
				bytes ~= _fields["newfid"];
				bytes ~= _fields["nwname"];
				if ("wname" in _fields)
				{
					bytes ~= packVLF(_fields["wname"]);
				}
				break;
			case STYX_MESSAGE_TYPE.T_WRITE:
				// size[4] Twrite tag[2] fid[4] offset[8] count[4] data[count]
				bytes ~= _fields["fid"];
				bytes ~= _fields["offset"];
				bytes ~= _fields["count"];
				bytes ~= _fields["data"];
				break;
			case STYX_MESSAGE_TYPE.T_WSTAT:
				// size[4] Twstat tag[2] fid[4] stat[n]
				bytes ~= _fields["fid"];
				bytes ~= packVLF(_fields["stat"]);
				break;
			default:
				break;
		}
		
		return (buildFromValue!uint(BYTE_ORDER.LITTLE_ENDIAN, cast(uint) (bytes.length + 4))) ~ bytes;
	}
	
	// all fields of message as AA
	RawBytes[string] fields()
	{
		return _fields;
	}
	
	// get selected field
	ubyte[] get(string field)
	{
		return _fields[field];
	}
	
	// set slected field
	void set(string field, ref ubyte[] bytes)
	{
		_fields[field] = bytes;
	}
	
	// type of message
	STYX_MESSAGE_TYPE type()
	{
		return cast(STYX_MESSAGE_TYPE) _fields["type"][0];
	}

	// raw access to all message field
	alias fields this;
}

// from bytes to message
StyxMessage toStyxMessage(ref ubyte[] bytes)
{
	auto message = new StyxMessage;
	message.unpack(bytes);
	
	return message;
}

// from message to bytes
ubyte[] fromStyxMessage(StyxMessage message)
{
	return message.pack;
}
