pragma solidity >=0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Gaming.sol";

contract TestGaming {
    uint public initialBalance = 10 ether;
    Gaming gaming;

    event emitBalances(uint256 b, uint256 a);

    function beforeAll() public {
        gaming = Gaming(DeployedAddresses.Gaming());
    }

    function testPlayerWonGuessHigher() public {
        bool expected = true;
        bool result = gaming.determineWinner(5, 4, true);

        Assert.equal(expected, result, "The player should have won by guessing the mystery number was higher than their number");
    }

    function testPlayerLostGuessLower() public {
        bool expected = false;
        bool result = gaming.determineWinner(5, 4, false);

        Assert.equal(expected, result, "The player should have lost by guessing the mystery number was lower than their number");
    }

    function testWithdrawFunds() public {
        uint256 ownerBalanceStart = address(gaming.owner).balance;
        gaming.withdrawFunds();
        uint256 ownerBalanceEnd = address(gaming.owner).balance;

        emit emitBalances(ownerBalanceStart,ownerBalanceEnd);

        Assert.equal(ownerBalanceStart+10 ether, ownerBalanceEnd, "The owner balane should increase by 10");
    }
}
