module exampleAddress::HelloWorld {

    use std::debug;
    use std::string::{String, utf8};
    
   public entry fun message() {
    debug::print(&utf8(b"Hello, World!"));
   }
   #[test]    
   public fun test_message() {
    message();
   }
}