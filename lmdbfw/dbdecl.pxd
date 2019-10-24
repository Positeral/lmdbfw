cdef extern from 'lmdb.h':
	# Flags
	cdef int MDB_FIXEDMAP
	cdef int MDB_NOSUBDIR
	cdef int MDB_NOSYNC
	cdef int MDB_RDONLY
	cdef int MDB_NOMETASYNC
	cdef int MDB_WRITEMAP
	cdef int MDB_MAPASYNC
	cdef int MDB_NOTLS
	cdef int MDB_NOLOCK
	cdef int MDB_NORDAHEAD
	cdef int MDB_NOMEMINIT
	cdef int MDB_REVERSEKEY
	cdef int MDB_DUPSORT
	cdef int MDB_INTEGERKEY
	cdef int MDB_DUPFIXED
	cdef int MDB_INTEGERDUP
	cdef int MDB_REVERSEDUP
	cdef int MDB_CREATE
	cdef int MDB_NOOVERWRITE
	cdef int MDB_NODUPDATA
	cdef int MDB_CURRENT
	cdef int MDB_RESERVE
	cdef int MDB_APPEND
	cdef int MDB_APPENDDUP
	cdef int MDB_MULTIPLE
	cdef int MDB_CP_COMPACT
	# Return codes
	cdef int MDB_SUCCESS
	cdef int MDB_KEYEXIST
	cdef int MDB_NOTFOUND
	cdef int MDB_PAGE_NOTFOUND
	cdef int MDB_CORRUPTED
	cdef int MDB_PANIC
	cdef int MDB_VERSION_MISMATCH
	cdef int MDB_INVALID
	cdef int MDB_MAP_FULL
	cdef int MDB_DBS_FULL
	cdef int MDB_READERS_FULL
	cdef int MDB_TLS_FULL
	cdef int MDB_TXN_FULL
	cdef int MDB_CURSOR_FULL
	cdef int MDB_PAGE_FULL
	cdef int MDB_MAP_RESIZED
	cdef int MDB_INCOMPATIBLE
	cdef int MDB_BAD_RSLOT
	cdef int MDB_BAD_TXN
	cdef int MDB_BAD_VALSIZE
	cdef int MDB_BAD_DBI

	ctypedef struct mdb_mode_t
	ctypedef struct mdb_filehandle_t

	ctypedef enum MDB_cursor_op:
		MDB_FIRST
		MDB_FIRST_DUP
		MDB_GET_BOTH
		MDB_GET_BOTH_RANGE
		MDB_GET_CURRENT
		MDB_GET_MULTIPLE
		MDB_LAST
		MDB_LAST_DUP
		MDB_NEXT
		MDB_NEXT_DUP
		MDB_NEXT_MULTIPLE
		MDB_NEXT_NODUP
		MDB_PREV
		MDB_PREV_DUP
		MDB_PREV_NODUP
		MDB_SET
		MDB_SET_KEY
		MDB_SET_RANGE
		MDB_PREV_MULTIPLE

	ctypedef struct MDB_env
	ctypedef struct MDB_txn
	ctypedef struct MDB_dbi
	ctypedef struct MDB_cursor

	ctypedef struct MDB_val:
		size_t  mv_size;
		void   *mv_data;

	ctypedef struct MDB_stat:
		unsigned int ms_psize
		unsigned int ms_depth       
		size_t       ms_branch_pages    
		size_t       ms_leaf_pages      
		size_t       ms_overflow_pages
		size_t       ms_entries

	ctypedef struct MDB_envinfo:
		void    *me_mapaddr        
		size_t   me_mapsize        
		size_t   me_last_pgno       
		size_t   me_last_txnid      
		unsigned int me_maxreaders 
		unsigned int me_numreaders

	ctypedef int  MDB_cmp_func(const MDB_val *a, const MDB_val *b)
	ctypedef void MDB_rel_func(MDB_val *item, void *oldptr, void *newptr, void *relctx)
	ctypedef int  MDB_msg_func(const char *msg, void *ctx)
	ctypedef void MDB_assert_func(MDB_env *env, const char *msg)

	char *mdb_version(int *major, int *minor, int *patch)
	char *mdb_strerror(int err)

	int mdb_env_create(MDB_env **env)
	int mdb_env_open(MDB_env *env, const char *path, unsigned int flags, mdb_mode_t mode)
	int mdb_env_copy(MDB_env *env, const char *path)
	int mdb_env_copyfd(MDB_env *env, mdb_filehandle_t fd)
	int mdb_env_copy2(MDB_env *env, const char *path, unsigned int flags)
	int mdb_env_copyfd2(MDB_env *env, mdb_filehandle_t fd, unsigned int flags)
	int mdb_env_stat(MDB_env *env, MDB_stat *stat)
	int mdb_env_info(MDB_env *env, MDB_envinfo *stat)
	int mdb_env_sync(MDB_env *env, int force)
	int mdb_env_set_flags(MDB_env *env, unsigned int flags, int onoff)
	int mdb_env_get_flags(MDB_env *env, unsigned int *flags)
	int mdb_env_get_path(MDB_env *env, const char **path)
	int mdb_env_get_fd(MDB_env *env, mdb_filehandle_t *fd)
	int mdb_env_set_mapsize(MDB_env *env, size_t size)
	int mdb_env_set_maxreaders(MDB_env *env, unsigned int readers)
	int mdb_env_get_maxreaders(MDB_env *env, unsigned int *readers)
	int mdb_env_set_maxdbs(MDB_env *env, MDB_dbi dbs)
	int mdb_env_get_maxkeysize(MDB_env *env)
	int mdb_env_set_userctx(MDB_env *env, void *ctx)
	int mdb_env_set_assert(MDB_env *env, MDB_assert_func *func)
	int mdb_txn_begin(MDB_env *env, MDB_txn *parent, unsigned int flags, MDB_txn **txn)
	int mdb_txn_commit(MDB_txn *txn)
	int mdb_txn_renew(MDB_txn *txn)
	int mdb_dbi_open(MDB_txn *txn, const char *name, unsigned int flags, MDB_dbi *dbi)
	int mdb_stat(MDB_txn *txn, MDB_dbi dbi, MDB_stat *stat)
	int mdb_dbi_flags(MDB_txn *txn, MDB_dbi dbi, unsigned int *flags)
	int mdb_drop(MDB_txn *txn, MDB_dbi dbi, int delete)
	int mdb_set_compare(MDB_txn *txn, MDB_dbi dbi, MDB_cmp_func *cmp)
	int mdb_set_dupsort(MDB_txn *txn, MDB_dbi dbi, MDB_cmp_func *cmp)
	int mdb_set_relfunc(MDB_txn *txn, MDB_dbi dbi, MDB_rel_func *rel)
	int mdb_set_relctx(MDB_txn *txn, MDB_dbi dbi, void *ctx)
	int mdb_get(MDB_txn *txn, MDB_dbi dbi, MDB_val *key, MDB_val *data)
	int mdb_put(MDB_txn *txn, MDB_dbi dbi, MDB_val *key, MDB_val *data, unsigned int flags)
	int mdb_del(MDB_txn *txn, MDB_dbi dbi, MDB_val *key, MDB_val *data)
	int mdb_cursor_open(MDB_txn *txn, MDB_dbi dbi, MDB_cursor **cursor)
	int mdb_cursor_renew(MDB_txn *txn, MDB_cursor *cursor)
	int mdb_cursor_get(MDB_cursor *cursor, MDB_val *key, MDB_val *data, MDB_cursor_op op)
	int mdb_cursor_put(MDB_cursor *cursor, MDB_val *key, MDB_val *data, unsigned int flags)
	int mdb_cursor_del(MDB_cursor *cursor, unsigned int flags)
	int mdb_cursor_count(MDB_cursor *cursor, size_t *countp)
	int mdb_cmp(MDB_txn *txn, MDB_dbi dbi, const MDB_val *a, const MDB_val *b)
	int mdb_dcmp(MDB_txn *txn, MDB_dbi dbi, const MDB_val *a, const MDB_val *b)
	int mdb_reader_list(MDB_env *env, MDB_msg_func *func, void *ctx)
	int mdb_reader_check(MDB_env *env, int *dead)

