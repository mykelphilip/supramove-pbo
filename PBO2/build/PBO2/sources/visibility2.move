module exampleAddress::visibility1 {

   friend exampleAddress::visibility2;
   
     public(friend) fun get_number(): u64 {
        let number: u64 = 20;
        return number
     }
}


module exampleAddress::visibility2 {

   use exampleAddress::visibility1::get_number;

   #[test_only]
   use std::debug;

   #[test]
   fun show_result(): u64 {
      let result: u64 = get_number();
      return(result)
   }

}