//  Leo App: Token Transfer

// A basic token contract
contract Token {
    // The balance mapping stores the token balance for each user
    mapping (public key, u64) balances;

    // Function to initialize the token balance for a user
    public fn init_balance(user: public key, amount: u64) {
        // Require that the sender is the contract owner
        require(is_owner(), "Only the contract owner can initialize balances");

        // Set the initial balance for the user
        balances[user] = amount;
    }

    // Function to transfer tokens from the sender to a specified user
    public fn transfer(to: public key, amount: u64) {
        // Require that the sender has enough balance
        require(balances[sender()] >= amount, "Insufficient balance");

        // Subtract the transferred amount from the sender's balance
        balances[sender()] -= amount;

        // Add the transferred amount to the recipient's balance
        balances[to] += amount;
    }

    // Function to get the balance of a user
    public query fn get_balance(user: public key) -> u64 {
        // Return the balance for the specified user
        return balances[user];
    }
}

// Example usage of the Token contract
fn main() {
    // Deploy the Token contract
    let token = deploy<Token>();

    // Initialize balances for two users
    token.init_balance(0xAlice, 100);
    token.init_balance(0:Bob, 50);

    // Transfer tokens from Alice to Bob
    token.transfer(0:Bob, 20);

    // Check the updated balances
    let alice_balance = token.get_balance(0xAlice);
    let bob_balance = token.get_balance(0:Bob);

    // Print the balances
    print("Alice's balance: ", alice_balance);
    print("Bob's balance: ", bob_balance);
}

