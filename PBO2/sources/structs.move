module exampleAddress::structs {

// IMPORTING  LIBARIES
    use std::string::{utf8, String};

//STORING STRUCTS
    struct User has key, drop {
        name: String,
    }

//CREATING  USER, USING THE FUNCTION
    public fun create_user(name: String): User {
        let user = User { name };
        user
    }

    public fun get_name(user: &User): &String {
        &user.name
    }


//TESTING FUNCTION
    #[only_test]
    use std::debug::print;

    #[test]
    public fun test_create_user() {
        let user = create_user(utf8(b"Michael"));
        let name = get_name(&user);
        print(name)
    }
}