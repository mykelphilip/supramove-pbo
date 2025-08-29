module Addy::equality {
    use std::debug;
    
    public fun equal(): bool {
        5 == 5
    }
    public fun not_equal(): bool {
        4 != 5
    }
    public fun greater(): bool {
        7 > 3
    }
    public fun less(): bool {
        2 < 5
    }
    public fun greater_equal(): bool {
        10 >= 10
    }
    public fun less_equal(): bool {
        6 <= 9
    }
    
    #[test]
    public fun check_equal() {
        let result_equal: bool = equal();
        debug::print(&result_equal);
    }
    #[test]
    public fun check_not_equal() {
        let result_not_equal: bool = not_equal();
        debug::print(&result_not_equal);
    }
    #[test]
    public fun check_greater() {
        let result_greater: bool = greater();
        debug::print(&result_greater);
    }
    #[test]
    public fun check_less() {
        let result_less: bool = less();
        debug::print(&result_less);
    }
    #[test]
    public fun check_greater_equal() {
        let result_greater_equal: bool = greater_equal();
        debug::print(&result_greater_equal);
    }
    #[test]
    public fun check_less_equal() {
        let result_less_equal: bool = less_equal();
        debug::print(&result_less_equal);
    }
}
