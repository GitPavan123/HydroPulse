// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Insurance {
    struct Person {
        uint id;
        string name;
        string email;
        bool isEnrolled;
    }

    struct Claim {
        uint id;
        address claimant;
        uint damageCost;
        bool approved;
        bool paid;
    }

    address payable public insuranceCompany;
    mapping(address => Person) public persons;
    mapping(uint => Claim) public claims;
    mapping(address => uint) public premiumsPaid;
    uint public personCount;
    uint public nextClaimId;

    constructor(address payable _insuranceCompany) {
        insuranceCompany = _insuranceCompany;
    }

    function enroll(string memory _name, string memory _email) public {
        require(!persons[msg.sender].isEnrolled, "Person already enrolled");
        personCount++;
        persons[msg.sender] = Person(personCount, _name, _email, true);
    }

    function payPremium() public payable {
        require(msg.value > 0, "Premium must be greater than 0");
        require(persons[msg.sender].isEnrolled, "Person must be enrolled");
        premiumsPaid[msg.sender] += msg.value;
        (bool sent, ) = insuranceCompany.call{value: msg.value}("");
        require(sent, "Failed to send premium");
    }

    function submitClaim(uint _damageCost) public {
        require(persons[msg.sender].isEnrolled, "Person must be enrolled");
        nextClaimId++;
        claims[nextClaimId] = Claim(nextClaimId, msg.sender, _damageCost, false, false);
    }

    function approveClaim(uint _claimId) public {
        require(msg.sender == insuranceCompany, "Only the insurance company can approve claims");
        claims[_claimId].approved = true;
    }

    function payClaim(uint _claimId) public payable {
        require(msg.sender == insuranceCompany, "Only the insurance company can pay claims");
        require(claims[_claimId].approved, "Claim must be approved");
        require(!claims[_claimId].paid, "Claim has already been paid");

        address payable claimant = payable(claims[_claimId].claimant);
        uint damageCost = claims[_claimId].damageCost;

        (bool sent, ) = claimant.call{value: damageCost}("");
        require(sent, "Failed to send claim payout");
        claims[_claimId].paid = true;
    }
}