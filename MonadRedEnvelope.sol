// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract MonadRedEnvelope {
    struct Envelope { address creator; uint256 totalAmount; uint256 remainingAmount; uint256 shares; uint256 remainingShares; }
    uint256 public nextId = 1;
    mapping(uint256 => Envelope) public envelopes;
    mapping(uint256 => mapping(address => bool)) public claimed;
    event EnvelopeCreated(uint256 indexed id, address indexed creator, uint256 amount, uint256 shares);
    event Claimed(uint256 indexed id, address indexed user, uint256 amount);
    function createRedEnvelope(uint256 shares) external payable returns (uint256 id) {
        require(shares > 0 && msg.value >= shares, "invalid input");
        id = nextId++;
        envelopes[id] = Envelope(msg.sender,msg.value,msg.value,shares,shares);
        emit EnvelopeCreated(id,msg.sender,msg.value,shares);
    }
    function claim(uint256 id) external {
        Envelope storage e = envelopes[id];
        require(e.creator != address(0), "not found");
        require(!claimed[id][msg.sender], "already claimed");
        require(e.remainingShares > 0, "empty");
        uint256 amount = e.remainingShares == 1 ? e.remainingAmount : e.remainingAmount / e.remainingShares;
        claimed[id][msg.sender] = true; e.remainingShares--; e.remainingAmount -= amount;
        (bool ok,) = payable(msg.sender).call{value: amount}(""); require(ok, "transfer failed"); emit Claimed(id,msg.sender,amount);
    }
    function getEnvelope(uint256 id) external view returns(address,uint256,uint256,uint256,uint256) { Envelope memory e=envelopes[id]; return(e.creator,e.totalAmount,e.remainingAmount,e.shares,e.remainingShares); }
    function hasClaimed(uint256 id,address user) external view returns(bool) { return claimed[id][user]; }
}

