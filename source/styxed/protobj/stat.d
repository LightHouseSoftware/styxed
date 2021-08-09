module styxed.protobj.stat;

private {
	import styxed.bytemanip;
	import styxed.constants;
	import styxed.filestat;
	
	import styxed.protobj.qid;
}

// file info
class Stat
{
	private {
		// for kernel use
		ushort _type;
		// for kernel use
		uint _dev;
		// qid
		Qid _qid;
		// permissions and flags
		uint _mode;
		// last access time
		uint _atime;
		// last modification time 
		uint _mtime;
		// length of file in bytes
		ulong _length;
		// file name; must be / if the file is the root directory of the server  
		string _name;
		// owner name 
		string _uid;
		// group name 
		string _gid;
		// name of the user who last modified the file 
		string _muid;
		
		ubyte[] _representation;
	}
}
