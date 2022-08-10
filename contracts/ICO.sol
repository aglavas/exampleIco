// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import { ERC20Token } from './ERC20Token.sol';

contract ICO {
  struct Sale {
    address investor;
    uint quantity;
  }
  Sale[] public sales;
  mapping(address => bool) public investors;
  address public tokenAdress;
  address public admin;
  uint public endDate;
  uint public initialPrice;
  uint public availableTokens;
  uint public minPurchase;
  uint public maxPurchase;
  bool public released;

  constructor(string memory name, string memory symbol, uint8 decimals, uint totalSupply) {
    tokenAdress = address(new ERC20Token(name, symbol, decimals, totalSupply));
    admin = msg.sender;
  }

  function start (uint duration, uint price, uint tokenNumber, uint min, uint max) external onlyAdmin() icoNotActive() {
    require(duration > 0, 'Duration should be bigger than 0.');
    uint totalSupply = ERC20Token(tokenAdress).totalSupply();
    require(tokenNumber > 0 && tokenNumber <= totalSupply, 'Available tokens should be > 0 and <= totalSupply.');
    require(min > 0, 'Min should be bigger than 0.');
    require(max > 0 && max <= tokenNumber, 'Max should be > 0 and <= availableTokens.');
    endDate = duration + block.timestamp;
    initialPrice = price;
    availableTokens = tokenNumber;
    minPurchase = min;
    maxPurchase = max;
  }

  function whitelist(address investorAddress) external onlyAdmin() {
    investors[investorAddress] = true;
  }

  function buy() payable external onlyInvestors() icoActive() {
    require(msg.value % initialPrice == 0, 'Have to send a multiple of the price.');
    require(msg.value >= minPurchase && msg.value <= maxPurchase, 'Have to send between minPurchase and maxPurchase.');
    uint quantity = msg.value / initialPrice;
    require(quantity <= availableTokens, 'Not enough tokens left for sale.');
    sales.push(Sale(msg.sender, quantity));
  }

  function release() external onlyAdmin() icoEnded() tokensNotReleased() {
    ERC20Token tokenInstance = ERC20Token(tokenAdress);
    for (uint i = 0; i < sales.length; i++) {
      Sale storage sale = sales[i];
      tokenInstance.transfer(sale.investor, sale.quantity);
    }
    released = true;
  }

  function withdraw(address payable to, uint amount) external onlyAdmin() icoEnded() tokensReleased() {
    to.transfer(amount);
  }

  modifier icoActive() {
    require(endDate > 0 && block.timestamp < endDate && availableTokens > 0, "ICO must be active.");
    _;
  }
    
  modifier icoNotActive() {
    require(endDate == 0, 'ICO should not be active.');
    _;
  }
    
  modifier icoEnded() {
    require(endDate > 0 && (block.timestamp >= endDate || availableTokens == 0), 'ICO must have ended.');
    _;
  }
    
  modifier tokensNotReleased() {
    require(released == false, 'Tokens must NOT have been released.');
    _;
  }
    
  modifier tokensReleased() {
    require(released == true, 'Tokens must have been released.');
    _;
  }
    
  modifier onlyInvestors() {
    require(investors[msg.sender] == true, 'Only investor action.');
    _;
  }
    
  modifier onlyAdmin() {
    require(msg.sender == admin, 'Only admin action.');
    _;
  }
}
