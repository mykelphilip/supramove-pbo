module SmarTech::bank {

    use std::string::{String, utf8};
    use std::debug;
    use std::vector;
    use std::simple_map;
    use std::signer;

    const GLOBAL_REGISTRY: address = @0x1;

    struct User has copy, drop, store {
        name: String,
        address: address,
        balance: u64,
    }

    struct Bank has copy, drop, store {
        creator: address,
        name: String,
        users: simple_map::SimpleMap<address, User>,
    }

    struct BankRegistry has key {
        banks: simple_map::SimpleMap<u64, Bank>,
        next_serial: u64,
    }

    public entry fun init_bank(account: &signer, bank_name: String) acquires BankRegistry {
        let creator = signer::address_of(account);

        if (!exists<BankRegistry>(creator)) {
            assert!(creator == GLOBAL_REGISTRY, 99);
            move_to(account, BankRegistry {
                banks: simple_map::create<u64, Bank>(),
                next_serial: 0,
            });
        };

        let registry = borrow_global_mut<BankRegistry>(creator);
        let serial = registry.next_serial;

        assert!(!simple_map::contains_key(&registry.banks, &serial), 1);

        let bank = Bank {
            creator,
            name: bank_name,
            users: simple_map::create<address, User>(),
        };

        simple_map::add(&mut registry.banks, serial, bank);
        registry.next_serial = serial + 1;
    }

    public fun get_bank_name_by_serial(serial: u64): String acquires BankRegistry {
        let registry = borrow_global<BankRegistry>(GLOBAL_REGISTRY);
        let bank = simple_map::borrow(&registry.banks, &serial);
        bank.name
    }

    public entry fun register_user(account: &signer, bank_serial: u64, name: String) acquires BankRegistry {
        let registry = borrow_global_mut<BankRegistry>(GLOBAL_REGISTRY);
        let bank = simple_map::borrow_mut(&mut registry.banks, &bank_serial);

        let user_address = signer::address_of(account);
        assert!(!simple_map::contains_key(&bank.users, &user_address), 2);

        let user = User {
            name,
            address: user_address,
            balance: 0,
        };

        simple_map::add(&mut bank.users, user_address, user);
    }

    public entry fun deposit(account: &signer, bank_serial: u64, amount: u64) acquires BankRegistry {
        let sender = signer::address_of(account);
        let registry = borrow_global_mut<BankRegistry>(GLOBAL_REGISTRY);
        let bank = simple_map::borrow_mut(&mut registry.banks, &bank_serial);

        assert!(simple_map::contains_key(&bank.users, &sender), 4);

        let user = simple_map::borrow_mut(&mut bank.users, &sender);
        user.balance = user.balance + amount;
    }

    public fun get_my_balance(account: &signer, bank_serial: u64): u64 acquires BankRegistry {
        let user_address = signer::address_of(account);
        let registry = borrow_global<BankRegistry>(GLOBAL_REGISTRY);
        let bank = simple_map::borrow(&registry.banks, &bank_serial);

        assert!(simple_map::contains_key(&bank.users, &user_address), 5);
        let user = simple_map::borrow(&bank.users, &user_address);

        user.balance
    }

    public entry fun transfer(
        account: &signer,
        bank_serial: u64,
        recipient: address,
        amount: u64
    ) acquires BankRegistry {
        let sender = signer::address_of(account);
        let registry = borrow_global_mut<BankRegistry>(GLOBAL_REGISTRY);
        let bank = simple_map::borrow_mut(&mut registry.banks, &bank_serial);

        assert!(simple_map::contains_key(&bank.users, &sender), 6);
        assert!(simple_map::contains_key(&bank.users, &recipient), 7);

        let (_, sender_user) = simple_map::remove(&mut bank.users, &sender);
        assert!(sender_user.balance >= amount, 8);

        let (_, recipient_user) = simple_map::remove(&mut bank.users, &recipient);

        let updated_sender = User {
            name: sender_user.name,
            address: sender_user.address,
            balance: sender_user.balance - amount,
        };

        let updated_recipient = User {
            name: recipient_user.name,
            address: recipient_user.address,
            balance: recipient_user.balance + amount,
        };

        simple_map::add(&mut bank.users, sender, updated_sender);
        simple_map::add(&mut bank.users, recipient, updated_recipient);
    }

    public entry fun withdraw(account: &signer, bank_serial: u64, amount: u64) acquires BankRegistry {
        let user_address = signer::address_of(account);
        let registry = borrow_global_mut<BankRegistry>(GLOBAL_REGISTRY);
        let bank = simple_map::borrow_mut(&mut registry.banks, &bank_serial);

        assert!(simple_map::contains_key(&bank.users, &user_address), 9);

        let user = simple_map::borrow_mut(&mut bank.users, &user_address);
        assert!(user.balance >= amount, 10);

        user.balance = user.balance - amount;
    }

    #[test(account = @0x1)]
    public fun check_get_bank_name_by_serial(account: signer) acquires BankRegistry {
        let name = utf8(b"Test Bank");
        init_bank(&account, name);
        let result = get_bank_name_by_serial(0);
        debug::print(&result);
    }

    #[test(account = @0x1, user = @0x2)]
    public fun check_register_user(account: signer, user: signer) acquires BankRegistry {
        let name = utf8(b"Test Bank");
        init_bank(&account, name);
        register_user(&user, 0, utf8(b"Michael"));
    }
    #[test(account = @0x1, user = @0x3)]
    public fun check_register_user_fail(account: signer, user: signer) acquires BankRegistry {
        let name = utf8(b"Happy Bank");
        init_bank(&account, name);
        register_user(&user, 0, utf8(b"John"));
    }

    #[test(account = @0x1, user = @0x2)]
    public fun check_register_and_deposit(account: signer, user: signer) acquires BankRegistry {
        init_bank(&account, utf8(b"Test Bank"));
        register_user(&user, 0, utf8(b"Michael"));
        deposit(&user, 0, 100);

        let balance = get_my_balance(&user, 0);
        debug::print(&balance);
    }

    #[test(account = @0x1, user1 = @0x2, user2 = @0x3)]
    public fun check_transfer(account: signer, user1: signer, user2: signer) acquires BankRegistry {
        init_bank(&account, utf8(b"Test Bank"));

        register_user(&user1, 0, utf8(b"Michael"));
        register_user(&user2, 0, utf8(b"Henry"));

        deposit(&user1, 0, 750);
        transfer(&user1, 0, @0x3, 150);

        let michael_balance = get_my_balance(&user1, 0);
        let henry_balance = get_my_balance(&user2, 0);

        debug::print(&michael_balance);
        debug::print(&henry_balance);
    }

    #[test(account = @0x1, user = @0x2)]
    public fun check_withdraw(account: signer, user: signer) acquires BankRegistry {
        init_bank(&account, utf8(b"Test Bank"));

        register_user(&user, 0, utf8(b"Henry"));

        deposit(&user, 0, 700);
        
        withdraw(&user, 0, 400);

        let balance = get_my_balance(&user, 0);
        debug::print(&balance);
    }

    #[test(account = @0x1, user = @0x2)]
    #[expected_failure]
    public fun check_withdraw_fails(account: signer, user: signer) acquires BankRegistry {
        init_bank(&account, utf8(b"Test Bank"));
        register_user(&user, 0, utf8(b"Jeff"));
        deposit(&user, 0, 10);
        
        withdraw(&user, 0, 100);
        let balance = get_my_balance(&user, 0);
        debug::print(&balance);
    }
}