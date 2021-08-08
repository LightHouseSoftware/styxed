module styxed.constants;

private {
	import styxed.bytemanip;
}

// protocol version
enum STYX_VERSION = cast(ubyte[]) "9P2000";
// no tag value
enum STYX_NOTAG = buildFromValue!ushort(BYTE_ORDER.LITTLE_ENDIAN, cast(ushort) ~0);
// no fid value
enum STYX_NOFID = buildFromValue!uint(BYTE_ORDER.LITTLE_ENDIAN, ~cast(uint) ~0);
// suitable amount of buffer to reserve for storing the 9P header
enum STYX_IOHDRSIZE = 24;
