class DbError(Exception):
	pass

class DbKeyExistError(DbError, KeyError):
	pass

class DbNotFoundError(DbError, KeyError):
	pass

class DbPageNotFoundError(DbError):
	pass

class DbCorruptedError(DbError):
	pass

class DbPanicError(DbError):
	pass

class DbVersionMismatchError(DbError):
	pass

class DbInvalidError(DbError):
	pass

class DbMapFullError(DbError):
	pass

class DbDbsFullError(DbError):
	pass

class DbReadersFullError(DbError):
	pass

class DbTlsFullError(DbError):
	pass

class DbTxnFullError(DbError):
	pass

class DbCursorFullError(DbError):
	pass

class DbPageFullError(DbError):
	pass

class DbMapResizedError(DbError):
	pass

class DbIncopatibleError(DbError):
	pass

class DbBadRSlotError(DbError):
	pass

class DbBadTxnError(DbError):
	pass

class DbBadValsizeError(DbError):
	pass

class DbBadDbiError(DbError):
	pass

class DbInvalidArgError(DbError):
	pass

class DbNoSpaceError(DbError, OSError):
	pass


cdef Exception exception_for(int error):
	cdef type t

	if   error == MDB_KEYEXIST:         t = DbKeyExistError
	elif error == MDB_NOTFOUND:         t = DbNotFoundError
	elif error == MDB_PAGE_NOTFOUND:    t = DbPageNotFoundError
	elif error == MDB_CORRUPTED:        t = DbCorruptedError
	elif error == MDB_PANIC:            t = DbPanicError
	elif error == MDB_VERSION_MISMATCH: t = DbVersionMismatchError
	elif error == MDB_INVALID:          t = DbInvalidError
	elif error == MDB_MAP_FULL:         t = DbMapFullError
	elif error == MDB_DBS_FULL:         t = DbDbsFullError
	elif error == MDB_READERS_FULL:     t = DbReadersFullError
	elif error == MDB_TLS_FULL:         t = DbTlsFullError
	elif error == MDB_TXN_FULL:         t = DbTxnFullError
	elif error == MDB_CURSOR_FULL:      t = DbCursorFullError
	elif error == MDB_PAGE_FULL:        t = DbPageFullError
	elif error == MDB_MAP_RESIZED:      t = DbMapResizedError
	elif error == MDB_INCOMPATIBLE:     t = DbIncopatibleError
	elif error == MDB_BAD_RSLOT:        t = DbBadRSlotError
	elif error == MDB_BAD_TXN:          t = DbBadTxnError
	elif error == MDB_BAD_VALSIZE:      t = DbBadValsizeError
	elif error == MDB_BAD_DBI:          t = DbBadDbiError
	elif error == EINVAL:               t = DbInvalidArgError
	elif error == ENOSPC:               t = DbNoSpaceError
	elif error == ENOMEM:               t = MemoryError
	else:                               t = OSError
	
	return t(error, mdb_strerror(error).decode())	
