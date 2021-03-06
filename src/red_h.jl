
#Sys.WORD_SIZE == 64 ? suffixed_name = "libRed" : suffixed_name = "libRed"   # Will have different names when 64 bits
#const red = Libdl.find_library(["libRed", suffixed_name])
const red = "C:/programs/red/libRed/libRed"
if isempty(red)
    error("could not find Red library")
end


# Setup and terminate
function redOpen()
    ccall((:redOpen,red),Void,())
end

function redClose()
    ccall((:redClose,red),Void,())
end


# Run Red code
function redDo(source)
    ccall((:redDo,red),Ptr{Void},(Ptr{UInt8},),source)
end

function redDoFile(fname)
    ccall((:redDoFile,red),Ptr{Void},(Ptr{UInt8},),fname)
end

function redDoBlock(code::Ptr{Void})
    ccall((:redDoBlock,red),Ptr{Void},(Ptr{Void},), code)
end

#red_value   redCall(red_word name, ...);
# AGAIN, TRICK IT TO IMITATE A VARARGS CALL WITH UP TO 4 ARGINS
function redCall(name::Ptr{Void})
    ccall((:redCall,red),Ptr{Void},(Ptr{Void},Ptr{Void}), name, C_NULL)
end
function redCall(name1::Ptr{Void}, name2::Ptr{Void})
    ccall((:redCall,red),Ptr{Void},(Ptr{Void},Ptr{Void},Ptr{Void}), name1, name2, C_NULL)
end
function redCall(name1::Ptr{Void}, name2::Ptr{Void}, name3::Ptr{Void})
    ccall((:redCall,red),Ptr{Void},(Ptr{Void},Ptr{Void},Ptr{Void},Ptr{Void}), name1, name2, name3, C_NULL)
end
function redCall(name1::Ptr{Void}, name2::Ptr{Void}, name3::Ptr{Void}, name4::Ptr{Void})
    ccall((:redCall,red),Ptr{Void},(Ptr{Void},Ptr{Void},Ptr{Void},Ptr{Void},Ptr{Void}), name1, name2, name3, name4, C_NULL)
end

# Expose a C callback in Red
function redRoutine(name, spec, func_ptr::Ptr{Void})
    ccall((:redRoutine,red),Ptr{Void},(Ptr{Void}, Ptr{UInt8}, Ptr{Void}), name, spec, func_ptr)
end

# C -> Red
function redSymbol(word)
    ccall((:redSymbol,red),Clong,(Ptr{UInt8},),word)
end

function redUnset()
    ccall((:redUnset,red),Ptr{Void},())
end

function redNone()
    ccall((:redNone,red),Ptr{Void},())
end

function redLogic(logic::Integer)
    ccall((:redLogic,red),Ptr{Void},(Clong,), logic)
end

function redDatatype(type_::Integer)
    ccall((:redDatatype,red),Ptr{Void},(Clong,), type_)
end

function redInteger(number::Integer)
    ccall((:redInteger,red),Ptr{Void},(Clong,), number)
end

function redFloat(number)
    ccall((:redFloat,red),Ptr{Void},(Cdouble,), number)
end

function redPair(x, y)
    ccall((:redPair,red),Ptr{Void},(Clong, Clong), x,y)
end

function redTuple(r::Integer, g::Integer, b::Integer)
    ccall((:redTuple,red),Ptr{Void},(Clong, Clong, Clong), r,g,b)
end

function redTuple4(r::Integer, g::Integer, b::Integer, a::Integer)
    ccall((:redTuple4,red),Ptr{Void},(Clong, Clong, Clong, Clong), r,g,b,a)
end

function redBinary(buffer, bytes::Integer)
    ccall((:redBinary,red),Ptr{Void},(Ptr{UInt8},Cint),buffer, bytes)
end

function redImage(width::Integer, height::Integer, buffer, format::Integer)
    ccall((:redImage,red),Ptr{Void},(Clong,Clong,Ptr{UInt8},Cint),width,height,buffer,format)
end

function redString(str)
    ccall((:redString,red),Ptr{Void},(Ptr{UInt8},),str)
end

function redWord(str)
    ccall((:redWord,red),Ptr{Void},(Ptr{UInt8},),str)
end

#redBlock(red_value v, ...);
# AGAIN, TRICK IT TO IMITATE A VARARGS CALL WITH UP TO 4 ARGINS
function redBlock(name::Ptr{Void})
    ccall((:redBlock,red),Ptr{Void},(Ptr{Void},Ptr{Void}), name, C_NULL)
end
function redBlock(name1::Ptr{Void}, name2::Ptr{Void})
    ccall((:redBlock,red),Ptr{Void},(Ptr{Void},Ptr{Void},Ptr{Void}), name1, name2, C_NULL)
end
function redBlock(name1::Ptr{Void}, name2::Ptr{Void}, name3::Ptr{Void})
    ccall((:redBlock,red),Ptr{Void},(Ptr{Void},Ptr{Void},Ptr{Void},Ptr{Void}), name1, name2, name3, C_NULL)
end
function redBlock(name1::Ptr{Void}, name2::Ptr{Void}, name3::Ptr{Void}, name4::Ptr{Void})
    ccall((:redBlock,red),Ptr{Void},(Ptr{Void},Ptr{Void},Ptr{Void},Ptr{Void},Ptr{Void}), name1, name2, name3, name4, C_NULL)
end

#redPath(red_value v, ...);
function redPath(name::Ptr{Void})
    ccall((:redPath,red),Ptr{Void},(Ptr{Void},Ptr{Void}), name, C_NULL)
end
function redPath(name1::Ptr{Void}, name2::Ptr{Void})
    ccall((:redPath,red),Ptr{Void},(Ptr{Void},Ptr{Void},Ptr{Void}), name1, name2, C_NULL)
end
function redPath(name1::Ptr{Void}, name2::Ptr{Void}, name3::Ptr{Void})
    ccall((:redPath,red),Ptr{Void},(Ptr{Void},Ptr{Void},Ptr{Void},Ptr{Void}), name1, name2, name3, C_NULL)
end
function redPath(name1::Ptr{Void}, name2::Ptr{Void}, name3::Ptr{Void}, name4::Ptr{Void})
    ccall((:redPath,red),Ptr{Void},(Ptr{Void},Ptr{Void},Ptr{Void},Ptr{Void},Ptr{Void}), name1, name2, name3, name4, C_NULL)
end

function redLoadPath(pato)
    ccall((:redLoadPath,red),Ptr{Void},(Ptr{UInt8},),pato)
end

function redMakeSeries(type_::Integer, slots::Integer)
    ccall((:redMakeSeries,red),Ptr{Void},(Culong, Culong),type_, slots)
end

# Red -> C
function redCInt32(number::Ptr{Void})
    ccall((:redCInt32,red),Clong,(Ptr{Void},), number)
end

function redCDouble(number::Ptr{Void})
    ccall((:redCDouble,red),Cdouble,(Ptr{Void},), number)
end

function redCString(str::Ptr{Void})
    ccall((:redCString,red),Ptr{UInt8},(Ptr{Void},), str)
end

function redTypeOf(value::Ptr{Void})
    ccall((:redTypeOf,red),Clong,(Ptr{Void},), value)
end

# Red actions
#=
    red_value   redAppend(red_series series, red_value value);
    red_value   redChange(red_series series, red_value value);
    red_value   redClear(red_series series);
    red_value   redCopy(red_value value);
    red_value   redFind(red_series series, red_value value);
    red_value   redIndex(red_series series);
    red_value   redLength(red_series series);
    red_value   redMake(red_value proto, red_value spec);
    red_value   redMold(red_value value);
    red_value   redPick(red_series series, red_value value);
    red_value   redPoke(red_series series, red_value index, red_value value);
    red_value   redPut(red_series series, red_value index, red_value value);
    red_value   redRemove(red_series series);
    red_value   redSelect(red_series series, red_value value);
    red_value   redSkip(red_series series, red_integer offset);
    red_value   redTo(red_value proto, red_value spec);
=#

# Access to a Red global word
function redSet(id::Integer, value::Ptr{Void})
    ccall((:redSet,red),Ptr{Void},(Clong,Ptr{Void}),id, value)
end

function redGet(id::Integer)
    ccall((:redGet,red),Ptr{Void},(Clong,),id)
end

# Access to a Red path
function redSetPath(pato, val::Ptr{Void})
    ccall((:redSetPath,red),Ptr{Void},(Ptr{Void}, Ptr{Void}), pato, val)
end

function redGetPath(pato)
    ccall((:redGetPath,red),Ptr{Void},(Ptr{Void},),pato)
end

# Access to a Red object/map/struct field
function redSetField(obj::Ptr{Void}, field::Integer, value::Ptr{Void})
    ccall((:redSetField,red),Ptr{Void},(Ptr{Void}, Clong, Ptr{Void}), obj, field, value)
end
function redGetField(obj::Ptr{Void}, field::Integer)
    ccall((:redGetField,red),Ptr{Void},(Ptr{Void}, Clong), obj, field)
end

#Debugging

function redPrint(value::Ptr{Void})
    ccall((:redPrint,red),Ptr{Void},(Ptr{Void},), value)
end

function redProbe(value::Ptr{Void})
    ccall((:redProbe,red),Ptr{Void},(Ptr{Void},), value)
end

function redHasError()
    ccall((:redHasError,red),Ptr{Void},())
end

function redFormError()
    ccall((:redFormError,red),Ptr{UInt8},())
end

function redOpenLogWindow()
    ccall((:redOpenLogWindow,red),Cint,())
end

function redCloseLogWindow()
    ccall((:redCloseLogWindow,red),Cint,())
end

function redOpenLogFile(fname)
    ccall((:redOpenLogFile,red),Void,(Ptr{UInt8},), fname)
end

function redCloseLogFile()
    ccall((:redCloseLogFile,red),Void,())
end

const red_value = Ptr{Void}

const RED_IMAGE_FORMAT_RGB = 0
const RED_IMAGE_FORMAT_ARGB = 1

const RED_TYPE_VALUE = 0
const RED_TYPE_DATATYPE = 1
const RED_TYPE_UNSET = 2
const RED_TYPE_NONE = 3
const RED_TYPE_LOGIC = 4
const RED_TYPE_BLOCK = 5
const RED_TYPE_PAREN = 6
const RED_TYPE_STRING = 7
const RED_TYPE_FILE = 8
const RED_TYPE_URL = 9
const RED_TYPE_CHAR = 10
const RED_TYPE_INTEGER = 11
const RED_TYPE_FLOAT = 12
const RED_TYPE_SYMBOL = 13
const RED_TYPE_CONTEXT = 14
const RED_TYPE_WORD = 15
const RED_TYPE_SET_WORD = 16
const RED_TYPE_LIT_WORD = 17
const RED_TYPE_GET_WORD = 18
const RED_TYPE_REFINEMENT = 19
const RED_TYPE_ISSUE = 20
const RED_TYPE_NATIVE = 21
const RED_TYPE_ACTION = 22
const RED_TYPE_OP = 23
const RED_TYPE_FUNCTION = 24
const RED_TYPE_PATH = 25
const RED_TYPE_LIT_PATH = 26
const RED_TYPE_SET_PATH = 27
const RED_TYPE_GET_PATH = 28
const RED_TYPE_ROUTINE = 29
const RED_TYPE_BITSET = 30
const RED_TYPE_POINT = 31
const RED_TYPE_OBJECT = 32
const RED_TYPE_TYPESET = 33
const RED_TYPE_ERROR = 34
const RED_TYPE_VECTOR = 35
const RED_TYPE_HASH = 36
const RED_TYPE_PAIR = 37
const RED_TYPE_PERCENT = 38
const RED_TYPE_TUPLE = 39
const RED_TYPE_MAP = 40
const RED_TYPE_BINARY = 41
const RED_TYPE_SERIES = 42
const RED_TYPE_TIME = 43
const RED_TYPE_TAG = 44
const RED_TYPE_EMAIL = 45
const RED_TYPE_IMAGE = 46
const RED_TYPE_EVENT = 47