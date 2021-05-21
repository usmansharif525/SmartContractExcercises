pragma solidity ^0.6.12; 
// excercise for payable
contract SimpleWallet{
    
    event Deposit(address sender, uint amount, uint balance);
    event Withdraw(uint amount, uint balance);
    event Transfer(address to, uint amount, uint balance );
    
    address payable public _owner;
    address public _wallet;
    
    constructor() public payable{
        _owner = msg.sender;
        _wallet = address(this);
    }
    
    function deposit() public payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }
    
    modifier _onlyOwner(){
        require(msg.sender == _owner, "Not Owner!");
        _;
    }
    
    function withdraw(uint _amount) public _onlyOwner {
        _owner.transfer(_amount);
        emit Withdraw(_amount, address(this).balance);
    } 
    
    function transfer(address payable _to, uint _amount) public _onlyOwner {
        _to.transfer(_amount);
        emit Transfer(_to, _amount, address(this).balance);
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
