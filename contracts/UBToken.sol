//SPDX-License-Identifier: MIT
pragma solidity >=0.8.10;

import '../interfaces/IER20.sol';
// import "OpenZeppelin/openzeppelin-contracts@3.0.0/contracts/access/Owner.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract UBToken is IER20,Ownable{
    uint256 public totalSupply;
    uint256 public MaxTokens =100000000*10**18;
    string public name;
    string public symbol;
    uint8 public decimals;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    constructor(string memory _name,string memory _symbol ,uint8 _decimals ,uint256 _initialSupply) Ownable() {
        totalSupply = _initialSupply;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        balanceOf[msg.sender] = totalSupply;
    }

    function getTotalSupply() external view returns (uint256){
        return totalSupply;
    }

    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool) {
        require(
            amount <= balanceOf[msg.sender],
            "Not Enough Balance to transfer."
        );
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        require(
            amount <= (balanceOf[msg.sender] + allowance[msg.sender][spender]),
            "Not enough tokens to approve."
        );
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        require(
            amount < allowance[sender][msg.sender],
            "Not enough tokens approved to transfer"
        );

        if (amount > allowance[sender][msg.sender]) {
            return false;
        }
        
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(address recipient, uint256 amount ) external onlyOwner{
        require(totalSupply + amount <= MaxTokens,"Max supply reached");        
        totalSupply +=amount;
        balanceOf[recipient] += amount;

        emit Transfer(address(0), recipient, amount);
    }
}