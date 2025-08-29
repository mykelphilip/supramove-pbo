module exampleAddress::maps {
    use std::simple_map::{Self, SimpleMap};
    use std::string::{utf8, String};

    #[test_only]
    use std::debug::print;

    public fun create_map(): SimpleMap<u64, String> {
        let my_map: SimpleMap<u64, String> = simple_map::create();
        simple_map::add(&mut my_map, 1, utf8(b"Hello"));
        simple_map::add(&mut my_map, 2, utf8(b"My Name is"));
        return my_map
    }

    #[test]
    fun test_create_map() {
        let mapping = create_map();

        let check_map = simple_map::borrow(&mut mapping, &1);
        print(check_map);

        let check_map_2 = simple_map::borrow(&mut mapping, &2);
        print(check_map_2);
    }

}
