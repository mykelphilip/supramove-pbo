module exampleAddress::reference {

    use std::debug::print; 
    use std::string::{String, utf8};

    public fun mut_reference() {
        let x: u64 = 0; 
        print(&x);

        let x_ref: &mut u64 = &mut x;
        *x_ref = 10; 
        print(&x);
    }

    public fun immutable_ref() {
        let y: u64 = 100; 
        print(&y);

        let y_ref: &u64 = &y; 
        print(&y);
    }

    #[test]
    public fun test_mut_reference() {
        mut_reference();
        immutable_ref();
    }
        
}
