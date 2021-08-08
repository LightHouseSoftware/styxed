module styxed.filestat;

// qid field in 9P messages
enum STYX_QID_TYPE : ubyte
{
	// directory
	QTDIR 	 = 	 0x80,
	// append only
	QTAPPEND =   0x40,
	// exclusive use (file may be used only by one client)
	QTEXCL   =   0x20,
	// authentication file
	QTAUTH   =   0x08,
	// temporary file (not included in nigthly archive)
	QTTMP    =   0x04,
	// any other file
	QTFILE   =   0x00
}

// file mode for open/create messages
enum STYX_FILE_MODE : ubyte
{
	// read only
	OREAD   = 0x00,
	// write only
	OWRITE  = 0x01,
	// read-write
	ORDWR   = 0x02,
	// execute
	OEXEC   = 0x03,
	// truncate file
	OTRUNC  = 0x10,
	// remove file after closing
	ORCLOSE = 0x40
}

// file permissions for 9P messages
enum STYX_FILE_PERMISSION : uint
{
	// directory
	DMDIR 	 	= 0x80000000,
	// append only
	DMAPPEND 	= 0x40000000,
	// exclusive use
	DMEXCL   	= 0x20000000,
	// authentication file
	DMAUTH	 	= 0x08000000,
	
	// owner permission
	OWNER_READ 	= 0x00000400,
	OWNER_WRITE = 0x00000200,
	OWNER_EXEC 	= 0x00000100,
	// owner group
	GROUP_READ 	= 0x00000040,
	GROUP_WRITE = 0x00000020,
	GROUP_EXEC 	= 0x00000010,
	// others
	OTHER_READ 	= 0x00000004,
	OTHER_WRITE = 0x00000002,
	OTHER_EXEC 	= 0x00000001,
}
