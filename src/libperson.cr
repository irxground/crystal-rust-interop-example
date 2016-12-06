
lib LibPerson
  type PersonP = Pointer(Void)

  fun person_new(name_len : UInt64, name_ptr : Pointer(UInt8), age : UInt32) : PersonP
  fun person_greet(p : PersonP)
  fun person_delete(p : PersonP)
end

class Person
  def initialize(name : String, age : Int)
    name_len = name.bytesize.to_u64
    name_ptr = name.to_unsafe
    @value = LibPerson.person_new name_len, name_ptr, age.to_u32
  end

  def greet
    LibPerson.person_greet @value
  end

  def finalize
    LibPerson.person_delete @value
  end
end
