pragma solidity ^0.8.0;

contract Voting {
    struct Voter {
        bool voted;
        uint vote;
    }
    
    struct Candidate {
        string name;
        uint voteCount;
    }
    
    address public chairperson;
    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    
    constructor(string[] memory candidateNames) {
        chairperson = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }
    
    function vote(uint candidateIndex) public {
        require(!voters[msg.sender].voted, "Already voted.");
        require(candidateIndex < candidates.length, "Invalid candidate index.");
        voters[msg.sender].voted = true;
        voters[msg.sender].vote = candidateIndex;
        candidates[candidateIndex].voteCount += 1;
    }
    
    function getResults() public view returns (string[] memory, uint[] memory) {
        string[] memory candidateNames = new string[](candidates.length);
        uint[] memory voteCounts = new uint[](candidates.length);
        for (uint i = 0; i < candidates.length; i++) {
            candidateNames[i] = candidates[i].name;
            voteCounts[i] = candidates[i].voteCount;
        }
        return (candidateNames, voteCounts);
    }
}
