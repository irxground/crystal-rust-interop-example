use std::slice;
use person::Person;

#[no_mangle]
pub unsafe fn person_new(name_len: usize, name_ptr: *const u8, age: u32) -> *mut Person {
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
pub unsafe fn person_delete(person: *mut Person) {
    drop(Box::from_raw(person))
}
