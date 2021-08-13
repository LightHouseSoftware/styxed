module styxed.interfaces.client;

private {
	import styxed.message;
}

/*
	message types (receive R-messages, perform actions):
	
	* auth
	* attach
	* clunk
	* create
	* error
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
// client handles messages from server
interface StyxClientReceiver
{
	// auth
	abstract void receiveAuth(StyxMessage message);
	// attach
	abstract void receiveAttach(StyxMessage message);
	// clunk
	abstract void receiveClunk(StyxMessage message);
	// create
	abstract void receiveCreate(StyxMessage message);
	// error
	abstract void receiveError(StyxMessage message);
	// flush
	abstract void receiveFlush(StyxMessage message);
	// open
	abstract void receiveOpen(StyxMessage message);
	// read
	abstract void receiveRead(StyxMessage message);
	// remove
	abstract void receiveRemove(StyxMessage message);
	// stat
	abstract void receiveStat(StyxMessage message);
	// version
	abstract void receiveVersion(StyxMessage message);
	// walk
	abstract void receiveWalk(StyxMessage message);
	// write
	abstract void receiveWrite(StyxMessage message);
	// wstat
	abstract void receiveWstat(StyxMessage message);
	
	// all messages
	final void receiveMessage(StyxMessage message)
	{
		switch (message.type) with (STYX_MESSAGE_TYPE)
		{
			case R_ATTACH:
				receiveAttach(message);
				break;
			case R_AUTH:
				receiveAuth(message);
				break;
			case R_CLUNK:
				receiveClunk(message);
				break;
			case R_CREATE:
				receiveCreate(message);
				break;
			case R_ERROR:
				receiveError(message);
				break;
			case R_FLUSH:
				receiveFlush(message);
				break;
			case R_OPEN:
				receiveOpen(message);
				break;
			case R_READ:
				receiveRead(message);
				break;
			case R_REMOVE:
				receiveRemove(message);
				break;
			case R_STAT:
				receiveStat(message);
				break;
			case R_VERSION:
				receiveVersion(message);
				break;
			case R_WALK:
				receiveWalk(message);
				break;
			case R_WRITE:
				receiveWrite(message);
				break;
			case R_WSTAT:
				receiveWstat(message);
				break;
			default:
				assert(0);
		}
	}
}

// client perform requests to server
interface StyxClientTransmitter
{
	// auth
	abstract StyxMessage transmitAuth();
	// attach
	abstract StyxMessage transmitAttach();
	// clunk
	abstract StyxMessage transmitClunk();
	// create
	abstract StyxMessage transmitCreate();
	// flush
	abstract StyxMessage transmitFlush();
	// open
	abstract StyxMessage transmitOpen();
	// read
	abstract StyxMessage transmitRead();
	// remove
	abstract StyxMessage transmitRemove();
	// stat
	abstract StyxMessage transmitStat();
	// version
	abstract StyxMessage transmitVersion();
	// walk
	abstract StyxMessage transmitWalk();
	// write
	abstract StyxMessage transmitWrite();
	// wstat
	abstract StyxMessage transmitWstat();
	
	// all messages
	final StyxMessage transmitMessage(StyxMessage message)
	{
		StyxMessage styxMessage = new StyxMessage;
		
		switch (message.type) with (STYX_MESSAGE_TYPE)
		{
			case T_ATTACH:
				styxMessage = transmitAttach();
				break;
			case T_AUTH:
				styxMessage = transmitAuth();
				break;
			case T_CLUNK:
				styxMessage = transmitClunk();
				break;
			case T_CREATE:
				styxMessage = transmitCreate();
				break;
			case T_FLUSH:
				styxMessage = transmitFlush();
				break;
			case T_OPEN:
				styxMessage = transmitOpen();
				break;
			case T_READ:
				styxMessage = transmitRead();
				break;
			case T_REMOVE:
				styxMessage = transmitRemove();
				break;
			case T_STAT:
				styxMessage = transmitStat();
				break;
			case T_VERSION:
				styxMessage = transmitVersion();
				break;
			case T_WALK:
				styxMessage = transmitWalk();
				break;
			case T_WRITE:
				styxMessage = transmitWrite();
				break;
			case T_WSTAT:
				styxMessage = transmitWstat();
				break;
			default:
				assert(0);
		}
		
		return styxMessage;
	}
}

// general client interface
interface StyxClient : StyxClientReceiver, StyxClientTransmitter {}
