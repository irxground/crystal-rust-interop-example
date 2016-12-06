#[derive(Debug)]
pub struct Person {
    name: String,
    age: u32
}

impl Person {
    pub fn new(name: String, age: u32) -> Person {
        Person { name: name, age: age }
    }
}
