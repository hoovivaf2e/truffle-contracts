pragma solidity ^0.5.16;

contract SimpleStorage {
  uint storedData;
  function set(uint x) public {
    storedData = x;
  }
  function get() view public returns (uint) {
    return storedData;
  }
}