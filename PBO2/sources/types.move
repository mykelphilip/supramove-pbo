module exampleAddress::types {
     const OWNER: address = @exampleAddress;
     const ANOTHER_ADDRESS: address = @anotherAddress;
     
     #[test_only]
     use std::debug::print;
     use std::string::{String, utf8};
     
     #[test]
     public fun check_addresses() {
        let is_same: bool = OWNER == ANOTHER_ADDRESS;
        if (is_same) {
            print(&utf8(b"Addresses are the same!"));
        } else {
            print(&utf8(b"Addresses are different!"));
        }
    }

    public fun check_address(): address {
        return OWNER
    }
}
