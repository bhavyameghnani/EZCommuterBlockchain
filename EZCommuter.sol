pragma solidity ^0.4.18;

contract GovernmentContract{
    
    address owner;
    
    struct Tendor {
        string roadTendorTitle;
        string roadLoc;
        uint roadCost;
        uint roadMinTime;
        uint roadMaxTime;
    }
    
    mapping (address => Tendor) tenn;
    address[] public tennAccts;
    
    function setTendor(address _address , string _roadTendorTitle , string _roadLoc , uint _roadCost , uint _roadMinTime , uint _roadMaxTime) public {
        var tendor = tenn[_address];
        
        tendor.roadTendorTitle = _roadTendorTitle;
        tendor.roadLoc = _roadLoc;
        tendor.roadCost = _roadCost;
        tendor.roadMinTime = _roadMinTime;
        tendor.roadMaxTime = _roadMaxTime;
        
        tennAccts.push(_address) -1;
    }
    
    function getTendor() view public returns(address[]) {
        return tennAccts;
    }
    
    function getTendor(address _address) view public returns (string, string , uint ,uint ,uint) {
        return (tenn[_address].roadTendorTitle, tenn[_address].roadLoc, tenn[_address].roadCost, tenn[_address].roadMinTime , tenn[_address].roadMaxTime);
    }
    
    function countTendor() view public returns (uint) {
        return tennAccts.length;
    }
    
}

contract ContractorContract{
    
    struct Contractor {
        uint age;
        string fullName;
        uint reputation;
    }
    
    mapping (address => Contractor) conn;
    address[] public connAccts;
    
    function setContractor(address _address, uint _age, string _fullName, uint _reputation) public {
        var contractor = conn[_address];
        
        contractor.age = _age;
        contractor.fullName = _fullName;
        contractor.reputation = _reputation;
        
        connAccts.push(_address) -1;
    }
    
    function getContractor() view public returns(address[]) {
        return connAccts;
    }
    
    function getContractor(address _address) view public returns (uint, string, uint) {
        return (conn[_address].age, conn[_address].fullName, conn[_address].reputation);
    }
    
    function countContractor() view public returns (uint) {
        return connAccts.length;
    }
    
}

contract auction is GovernmentContract , ContractorContract{
    mapping (uint => bool) started;
    
    mapping (uint => address) beneficiaryContractor;
    mapping (address => address) lowestBidder;
    mapping (uint => address) highestReputation;
    mapping (address => uint) lowestBid;
    mapping (address => bool) tendorBool;
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    function auction() public{
        owner = msg.sender;
    }
    
    function startBid(address tendorAddress) public onlyOwner{
        tendorBool[tendorAddress] = true;
    }
    
    function getLowestBidder(address _contractorAddress) public view returns (address) {
        return lowestBidder[_contractorAddress];
    }
    
       function getLowestBid(address _tendorAddress) public view returns (uint) {
        return lowestBid[_tendorAddress];
    }
}
