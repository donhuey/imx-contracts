// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract IMXToken is ERC20, AccessControl {
  bytes32 public constant MINTER_ROLE = keccak256('MINTER_ROLE');

  constructor(address minter) ERC20('Immutable X', 'IMX') {
    _setupRole(MINTER_ROLE, minter);
  }

  modifier checkRole(
    bytes32 role,
    address account,
    string memory message
  ) {
    require(hasRole(role, account), message);
    _;
  }

  function mint(address to, uint256 amount) external checkRole(MINTER_ROLE, msg.sender, 'Caller is not a minter') {
    super._mint(to, amount);
  }
}
