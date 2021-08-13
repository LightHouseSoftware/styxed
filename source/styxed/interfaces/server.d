module styxed.interfaces.server;

private {
	import styxed.message;
}

/*
	message types (receive T-messages, returns R-messages):
	
	* auth
	* attach
	* clunk
	* create
	* flush
	* open
	* read
	* remove
	* stat
	* version
	* walk
	* write
	* wstat
		
*/
interface StyxServer
{
	// auth
	abstract StyxMessage receiveAuth(StyxMessage message);
	// attach
	abstract StyxMessage receiveAttach(StyxMessage message);
	// clunk
	abstract StyxMessage receiveClunk(StyxMessage message);
	// create
	abstract StyxMessage receiveCreate(StyxMessage message);
	// flush
	abstract StyxMessage receiveFlush(StyxMessage message);
	// open
	abstract StyxMessage receiveOpen(StyxMessage message);
	// read
	abstract StyxMessage receiveRead(StyxMessage message);
	// remove
	abstract StyxMessage receiveRemove(StyxMessage message);
	// stat
	abstract StyxMessage receiveStat(StyxMessage message);
	// version
	abstract StyxMessage receiveVersion(StyxMessage message);
	// walk
	abstract StyxMessage receiveWalk(StyxMessage message);
	// write
	abstract StyxMessage receiveWrite(StyxMessage message);
	// wstat
	abstract StyxMessage receiveWstat(StyxMessage message);
	
	// all messages
	final StyxMessage receiveMessage(StyxMessage message)
	{
		StyxMessage styxMessage = new StyxMessage;
		
		switch (message.type) with (STYX_MESSAGE_TYPE)
		{
			case T_ATTACH:
				styxMessage = receiveAttach(message);
				break;
			case T_AUTH:
				styxMessage = receiveAuth(message);
				break;
			case T_CLUNK:
				styxMessage = receiveClunk(message);
				break;
			case T_CREATE:
				styxMessage = receiveCreate(message);
				break;
			case T_FLUSH:
				styxMessage = receiveFlush(message);
				break;
			case T_OPEN:
				styxMessage = receiveOpen(message);
				break;
			case T_READ:
				styxMessage = receiveRead(message);
				break;
			case T_REMOVE:
				styxMessage = receiveRemove(message);
				break;
			case T_STAT:
				styxMessage = receiveStat(message);
				break;
			case T_VERSION:
				styxMessage = receiveVersion(message);
				break;
			case T_WALK:
				styxMessage = receiveWalk(message);
				break;
			case T_WRITE:
				styxMessage = receiveWrite(message);
				break;
			case T_WSTAT:
				styxMessage = receiveWstat(message);
				break;
			default:
				assert(0);
		}
		
		return styxMessage;
	}
}
