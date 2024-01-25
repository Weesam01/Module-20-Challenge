/*
Joint Savings Account
---------------------

To automate the creation of joint savings accounts, you will create a solidity smart contract that accepts two user addresses that are then able to control a joint savings account. Your smart contract will use ether management functions to implement various requirements from the financial institution to provide the features of the joint savings account.

The Starting file provided for this challenge contains a `pragma` for solidity version `5.0.0`.
You will do the following:

1. Create and work within a local blockchain development environment using the JavaScript VM provided by the Remix IDE.

2. Script and deploy a **JointSavings** smart contract.

3. Interact with your deployed smart contract to transfer and withdraw funds.

*/



pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    // Define variables
    address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    // Define a function named `withdraw`
    function withdraw(uint amount, address payable recipient) public {

        // Require that the recipient is either accountOne or accountTwo
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // Require sufficient funds for withdrawal
        require(contractBalance >= amount, "Insufficient funds!");

        // Update lastToWithdraw if the recipient is different
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfer the amount to the recipient
        recipient.transfer(amount);

        // Update lastWithdrawAmount
        lastWithdrawAmount = amount;

        // Update contractBalance to reflect the new balance
        contractBalance = address(this).balance;
    }

    // Define a public payable function named `deposit`
    function deposit() public payable {
        // Update contractBalance to reflect the new balance
        contractBalance = address(this).balance;
    }

    // Define a public function named `setAccounts`
    function setAccounts(address payable account1, address payable account2) public {
        // Set the values of accountOne and accountTwo
        accountOne = account1;
        accountTwo = account2;
    }

    // Default fallback function to store Ether sent outside the deposit function
    function() external payable {
        // Update contractBalance to reflect the new balance
        contractBalance = address(this).balance;
    }
}
