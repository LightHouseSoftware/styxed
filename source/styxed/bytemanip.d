module styxed.bytemanip;


// endianess
enum BYTE_ORDER
{
	LITTLE_ENDIAN,
	BIG_ENDIAN
}

// reconstruct value from bytes
T buildFromBytes(T)(BYTE_ORDER byteOrder, ubyte[] bytes...)
{
	T mask;
	size_t shift;

	foreach (i, e; bytes)
	{
		final switch (byteOrder) with (BYTE_ORDER)
		{
		case LITTLE_ENDIAN:
			shift = (i << 3);
			break;
		case BIG_ENDIAN:
			shift = ((bytes.length - i - 1) << 3);
			break;
		}
		mask |= (e << shift);
	}

	return mask;
}

// deconstruct byte from value
auto buildFromValue(T)(BYTE_ORDER byteOrder, T value)
{
	ubyte[] data;
	T mask = cast(T) 0xff;
	size_t shift;

	foreach (i; 0 .. T.sizeof)
	{
		final switch (byteOrder) with (BYTE_ORDER)
		{
		case LITTLE_ENDIAN:
			shift = (i << 3);
			break;
		case BIG_ENDIAN:
			shift = ((T.sizeof - i - 1) << 3);
			break;
		}

		data ~= cast(ubyte)((value & (mask << shift)) >> shift);
	}

	return data;
}

// VLF - variable length field: starts with 2 bytes that indicates size of fields
auto unpackVLF(ubyte[] bytes)
{
	auto size = buildFromBytes!ushort(BYTE_ORDER.LITTLE_ENDIAN, bytes[0..2]);
	return bytes[2..2+size];
}

auto packVLF(ubyte[] bytes)
{
	ubyte[] raw;
	raw ~= buildFromValue!ushort(BYTE_ORDER.LITTLE_ENDIAN, cast(ushort) (bytes.length));
	raw ~= bytes;
	return raw;
}
