module styxed.constants;

private {
	import styxed.bytemanip;
}

// protocol version
enum STYX_VERSION = cast(ubyte[]) "9P2000";
// no tag value
enum STYX_NOTAG = buildFromValue!ushort(BYTE_ORDER.LITTLE_ENDIAN, 0xFFFF);
// no fid value
enum STYX_NOFID = buildFromValue!uint(BYTE_ORDER.LITTLE_ENDIAN, 0xFFFFFFFF);

// suitable amount of buffer to reserve for storing the 9P header
enum STYX_IOHDRSIZE = 24;

// typical error messages 
enum STYX_ERRORS
{
	ENOMEM    =  cast(ubyte[]) `Out of memory`,
	EPERM     =  cast(ubyte[]) `Permission denied`,
	ENODEV    =  cast(ubyte[]) `No free devices`,
	EHUNGUP   =  cast(ubyte[]) `I/O on hungup channel`,
	EEXIST    =  cast(ubyte[]) `File exists`,
	ENONEXIST =  cast(ubyte[]) `File does not exist`,
	EBADCMD   =  cast(ubyte[]) `Bad command`,
	EBADARG   =  cast(ubyte[]) `Bad arguments`
}

