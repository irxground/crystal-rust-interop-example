use std::slice;
use person::Person;

#[no_mangle]
pub unsafe fn person_new(name_ptr: *const u8, name_len: usize, age: u32) -> *mut Person {
    let name = slice::from_raw_parts(name_ptr, name_len);
    let name = String::from_utf8_lossy(name);
    let p = Box::new(Person::new(name.to_string(), age));
    return Box::into_raw(p);
}

#[no_mangle]
pub unsafe fn person_greet(person: *mut Person) {
    if let Some(p) = person.as_ref() {
        p.greet();
    }
}

#[no_mangle]
pub unsafe fn person_debug_callback(
    person: *mut Person,
    callback: fn(*const u8, usize, *mut u8),
    closure: *mut u8)
{
    if let Some(p) = person.as_ref() {
        let str = format!("{:?}", p);
        callback(str.as_ptr(), str.len(), closure)
    }
}

#[no_mangle]
pub unsafe fn person_delete(person: *mut Person) {
    drop(Box::from_raw(person))
}
