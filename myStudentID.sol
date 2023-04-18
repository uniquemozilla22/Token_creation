// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.0;
contract myStudentId {
    uint StudentId;
    address owner;
    constructor(uint _studentid) {
        StudentId = _studentid;
        owner = msg.sender;
    }
    function viewMyId() public view returns(uint) {
        return StudentId;
    }
    function updateID(uint _newId) public {
        require(msg.sender == owner);
        StudentId = _newId;
    }
}