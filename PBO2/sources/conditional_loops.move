module exampleAddress::conditional_loops {

    #[test_only]
    use std::debug;
    use std::string::{String, utf8};

    //     public fun check_number(_number: u64): String {
    //         let number: u64 = 10; 
    //         if (_number > number) {
    //             utf8(b"the number is greater than 10!")
    //         } else if (_number == number) {
    //             utf8(b"The number is equal to 10!")
    //         } else  {
    //             utf8(b"The number is less than 10!")
    //         }
    //     }

    //         #[test]
    //     public fun test_function() {
    //             let one_check_result: String = check_number(11);
    //             debug::print(&one_check_result);
    //         }
    //           #[test]
    //     public fun test_function_two() {
    //         let one_check_result_two: String = check_number(9);
    //         debug::print(&one_check_result_two);
    //     }
    //           #[test]
    //     public fun test_function_three() {
    //         let one_check_result_three: String = check_number(10);
    //         debug::print(&one_check_result_three);
    //     }


//WHILE STATEMENT
    // public fun while_loop(count_to: u64): u64 {
    //     let start = 0;
    //     let i: u64 = 1;
    //     while (i <= count_to) {
    //         start = start + 2;
    //         i =  i + 1; 
    //         };
    //         start
    // }

    // #[test]
    // fun test_while() {
    //     let while_result = while_loop(30);
    //     debug::print(&while_result);
    // }

//FOR STATEMENT
        public fun for_loop(count_to: u64): u64 {
            let value = 0;
            for (i in 3..count_to) {
                value = value + 1;
            }; 
            value
        }

        #[test]
        public fun check_for_loop() {
            let result = for_loop(6);
            debug::print(&result);
        }
}