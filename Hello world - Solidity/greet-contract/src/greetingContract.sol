pragma solidity ^0.8.0;

contract GreetingContract {
    mapping(address => string) private names;
    address public owner;

    event NameStored(address indexed user, string name);
    event NameGreeted(address indexed user, string greeting);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier hasName() {
        require(bytes(names[msg.sender]).length > 0, "Name not stored");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function storeName(string memory _name) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        names[msg.sender] = _name;
        emit NameStored(msg.sender, _name);
    }

    function greetMe() public view hasName returns (string memory) {
        return string(abi.encodePacked("Hola, ", names[msg.sender], "!"));
    }

    function greetAddress(address _user) public view returns (string memory) {
        require(bytes(names[_user]).length > 0, "User has no name stored");
        return string(abi.encodePacked("Hola, ", names[_user], "!"));
    }

    function getName(address _user) public view returns (string memory) {
        return names[_user];
    }

    function deleteMyName() public hasName {
        delete names[msg.sender];
    }

    function emergencyReset(address _user) public onlyOwner {
        delete names[_user];
    }
}
