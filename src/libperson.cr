
lib LibPerson
  type PersonP = Void*

  fun person_new(name_ptr : UInt8*, name_len : UInt64, age : UInt32) : PersonP
  fun person_debug_callback(p : PersonP, callback : (UInt8*, UInt64, Void* ->), closure : Void*)
  fun person_delete(p : PersonP)
end

class Person
  def initialize(name : String, age : Int)
    name_ptr = name.to_unsafe
    name_len = name.bytesize.to_u64
    @value = LibPerson.person_new(name_ptr, name_len, age.to_u32)
  end

  def inspect(io : IO)
    LibPerson.person_debug_callback(@value, ->(str_ptr, str_len, closure) {
      io_ = closure.as(typeof(io))
      io_.write Slice.new(str_ptr, str_len)
    }, io.as(Void*))
  end

  def finalize
    LibPerson.person_delete(@value)
  end
end
