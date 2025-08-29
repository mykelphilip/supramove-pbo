module exampleAddress::operations {
    use std::debug;


    public fun add(): u64 {
        let result_add: u64 = 5 + 3;
        result_add
    }

    public fun sub(): u64 {
        let result_sub: u64 = 10 - 4;
        result_sub
    }

     public fun mul(): u64 {
        let result_mul: u64 = 7 * 2;
        result_mul
    }

     public fun div(): u64 {
        let result_div: u64 = 20 / 5;
        result_div
    }

  public fun rem(): u64 {
        let result_rem: u64 = 10 % 3;
        result_rem
    }

    #[test]
    public fun check_add() {
        let check_add: u64 = add();
        debug::print(&check_add);
    }

       #[test]
    public fun check_sub() {
        let check_sub: u64 = sub();
        debug::print(&check_sub);
    }
    
       #[test]
    public fun check_mul() {
        let check_mul: u64 = mul();
        debug::print(&check_mul);
    }

       #[test]
    public fun check_div() {
        let check_div: u64 = div();
        debug::print(&check_div);
    }

       #[test]
    public fun check_rem() {
        let check_rem: u64 = rem();
        debug::print(&check_rem);
    }
    }
