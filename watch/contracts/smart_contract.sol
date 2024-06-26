// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FitnessApp {
    
    struct User {
        uint balance;
        uint steps;
        uint distance; 
    }

    mapping(address => User) public users;
    mapping(string => uint) public itemPrices;
    address public owner;

    event CoinsEarned(address indexed user, uint amount, uint balance);
    event ItemBought(address indexed user, string itemName, uint price, uint balance);

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    constructor(){ 
        owner = msg.sender;
    }

    function updateUserData(uint _steps, uint _distance) public {
        users[msg.sender].steps = _steps;
        users[msg.sender].distance = _distance;
    }

    function earnCoins() public {
        uint steps = users[msg.sender].steps;
        uint distance = users[msg.sender].distance;
        uint stepCoins = steps / 1000; 
        uint distanceCoins = distance / 100; 
        uint totalCoins = stepCoins + distanceCoins;

        users[msg.sender].balance += totalCoins;
        users[msg.sender].steps = 0; 
        users[msg.sender].distance = 0; 

        emit CoinsEarned(msg.sender, totalCoins, getBalance());
    }

    function setItemPrice(string memory itemName, uint price) public onlyOwner {
        itemPrices[itemName] = price;
    }

    function buyItem(string memory itemName) public {
        uint price = itemPrices[itemName];
        require(users[msg.sender].balance >= price, "Insufficient balance");

        users[msg.sender].balance -= price;

        emit ItemBought(msg.sender, itemName, price, getBalance());
    }

    function getBalance() public view returns (uint) {
        return users[msg.sender].balance;
    }

    function getItemPrice(string memory itemName) public view returns (uint) {
        return itemPrices[itemName];
    }
}
