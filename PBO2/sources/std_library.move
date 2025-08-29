module exampleAddress::std_library{
    use std::debug;
    use std::string::{String, utf8};
    
    const MAX_SUPPLY: u64 = 1000;
    
    public fun show_value(): u64 {
        let show_number: u64 = 1;
        debug::print(&show_number);
        MAX_SUPPLY
    }
    
    public fun show_string() {
        let name: String = utf8(b"Hello World Again");
        debug::print(&name);
    }
    
    #[test]
    fun test_function() {
        let number_show: u64 = show_value();
        debug::print(&number_show);
    }   
}
