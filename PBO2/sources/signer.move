// module exampleAddress::signer_auth {

  
//     use std::debug::print;
//     use std::signer;
//     use std::string::{String, utf8};

//     public fun create_account(s: &signer) {
//         assert!(signer::address_of(s) == @exampleAddress, 0);
//     }

//     #[test(s = @exampleAddress)]
//     public fun test_create_account(s: &signer) {

//         let addr = signer::address_of(s);
//         print(&addr);
//         create_account(s);
//         print(&utf8(b"Account Created Successfully!"));
//     }

// }
