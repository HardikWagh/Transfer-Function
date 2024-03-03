// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherTransfer {
    struct Person {
        string name;
        string email;
        address _accountAddress;
        uint balance;
    }
    
    mapping(uint => Person) public persons;
    uint public totalPersons;
    
    event Transfer(address indexed _from, address indexed _to, uint _amount);
    
    constructor() {
        totalPersons = 0;
    }
    
    function registerPerson(string memory _name, string memory _email, address _accountAddress, uint balance) public {
        totalPersons++;
        persons[totalPersons] = Person(_name, _email, _accountAddress, balance);
    }
    
    function transferEther(uint _senderId, uint _receiverId, uint _amount) public {
        require(_senderId <= totalPersons , "Invalid sender or receiver ID");
        require(persons[_senderId].balance >= _amount, "Insufficient balance");
        
        persons[_senderId].balance -= _amount;
        persons[_receiverId].balance += _amount;
        
        emit Transfer(persons[_senderId]._accountAddress, persons[_receiverId]._accountAddress, _amount);
    }
    
    function getPersonDetails(uint _personId) public view returns (string memory, string memory, address, uint) {
        require(_personId <= totalPersons, "Invalid person ID");
        return (persons[_personId].name, persons[_personId].email, persons[_personId]._accountAddress, persons[_personId].balance);
    }
}
