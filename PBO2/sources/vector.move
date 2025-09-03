module exampleAddress::vectors {

    //IMPORTING MY LIBRIES
    use std::vector;

    //ARRANGING THE VECTORS
    public fun create_vector(): vector<u64> {
        let my_vector: vector<u64> = vector::empty();
        vector::push_back(&mut my_vector, 1);
        vector::push_back(&mut my_vector, 2);
        vector::push_back(&mut my_vector, 3);
        my_vector
    }

    //TESTING 
    #[only_test]
    use std::debug::print;

    #[test]
    public fun test_create_vector() {
        let vectors = create_vector();
        vector::push_back( &mut vectors, 4); // now: [1,2,3,4]

        let fourth = vector::borrow(&vectors, 3); //4
        print(fourth);

        let third = vector::borrow(&vectors, 2); //3
        print(third);

        vector::pop_back(&mut vectors); // removes 4 

        let new_last_index = vector::length(&vectors) - 1;
        let new_last = vector::borrow(&vectors, new_last_index); //3 again
       print(new_last);

       vector::pop_back(&mut vectors); // removes 3 
    }

 }

