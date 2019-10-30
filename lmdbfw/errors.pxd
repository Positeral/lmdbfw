from libc.errno cimport EINVAL
from libc.errno cimport ENOMEM
from libc.errno cimport ENOSPC

from dbdecl cimport mdb_strerror
from dbdecl cimport MDB_SUCCESS      
from dbdecl cimport MDB_KEYEXIST       
from dbdecl cimport MDB_NOTFOUND       
from dbdecl cimport MDB_PAGE_NOTFOUND  
from dbdecl cimport MDB_CORRUPTED      
from dbdecl cimport MDB_PANIC          
from dbdecl cimport MDB_VERSION_MISMATCH
from dbdecl cimport MDB_INVALID        
from dbdecl cimport MDB_MAP_FULL       
from dbdecl cimport MDB_DBS_FULL       
from dbdecl cimport MDB_READERS_FULL   
from dbdecl cimport MDB_TLS_FULL       
from dbdecl cimport MDB_TXN_FULL       
from dbdecl cimport MDB_CURSOR_FULL    
from dbdecl cimport MDB_PAGE_FULL      
from dbdecl cimport MDB_MAP_RESIZED    
from dbdecl cimport MDB_INCOMPATIBLE   
from dbdecl cimport MDB_BAD_RSLOT      
from dbdecl cimport MDB_BAD_TXN        
from dbdecl cimport MDB_BAD_VALSIZE    
from dbdecl cimport MDB_BAD_DBI        


cdef Exception exception_for(int error)

cdef inline int raise_if(int error) except 1:
	if error == MDB_SUCCESS:
		return 0

	raise exception_for(error)

