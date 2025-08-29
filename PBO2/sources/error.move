// module exampleAddress::error {
//     use std::debug;
//     use std::string::{String, utf8};
    
//     public fun entry_fee(_amount: u64): String {
//         assert!(_amount > 100, 1000);
//         utf8(b"You did not give the initial Minimum")
//     }
    
//     #[test]
//     #[expected_failure]
//     public fun test_entry_fee() {
//         let result = entry_fee(10);
//     }   
    
//     #[test]
//     public fun test_entry_fee_two() {
//         let result = entry_fee(2000);
//         debug::print(&result);
//     }
// }

