module exampleAddress::storage_operations {

    use std::debug;

    public fun supra_oracles() :u128 {
        return 1 }
}

module exampleAddress::price_type_change {

    use exampleAddress::storage_operations;
    use std::debug; 

    public fun change_price_type() {
        let return_number = storage_operations::supra_oracles();
        let change_type: u64 = (return_number as u64);
         debug::print(&change_type);
    }

    #[test]
    public fun test_number() {
        change_price_type();
    }


}
