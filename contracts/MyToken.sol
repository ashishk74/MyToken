pragma solidity ^0.5.0;

contract MyToken  {
    
    mapping (address => uint256) private balances;

    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimal;
    address deployer;
    
    constructor () public {
        _totalSupply = 1000000;
        _name = "IPL Token";
        _symbol = "IPL";
        _decimal = 0;
        balances[msg.sender] = _totalSupply;
        deployer = msg.sender;
    }

    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }
    function balanceOf(address _account) public view returns (uint256){
        return balances[_account];
    }
    function transfer(address _recipient, uint256 _amount) public returns (bool){
       require(balances[msg.sender] >= _amount, "Insufficient balance"); 
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        emit Transfer(msg.sender, _recipient, _amount);
        return true;
    }
   
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    modifier onlyDeployer {
        require(msg.sender == deployer, "You are not Deployer of Contract");
        _;
    }
    
    function mint(uint256 _amount)public onlyDeployer returns (uint256){
        _totalSupply += _amount;
        balances[msg.sender] += _amount;
    }
    
    function burn(uint256 _amount)public onlyDeployer returns (uint256){
        _totalSupply -= _amount;
        balances[msg.sender] -= _amount;
    }
       
}