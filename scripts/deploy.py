from brownie import UBToken

from scripts.scripts_util import get_account

def deploy():
    account = get_account()
    print(get_account())
    _name = "University of bridgeport< Computer Science Department"
    _symbol = "UBCS"
    _decimals=18
    _initialSupply = 1000000*10**_decimals
    ubToken = UBToken.deploy(_name,_symbol,_decimals,_initialSupply,{"from":account})
    
    symbol = ubToken.symbol()
    name = ubToken.name()
    total_supply = ubToken.getTotalSupply()
    decimals = ubToken.decimals()
    
    print(symbol,name,total_supply/decimals)
    
    account_to = get_account(1)
    ubToken.transfer(account_to,100*10**18,{'from':account})
    balance_account_to = ubToken.balanceOf(account_to)
    print(f'Balance of account to: {balance_account_to/(10**decimals):,}')
    ubToken.mint(account,10000*10**decimals,{'from':account})
    
    total_supply = ubToken.totalSupply()
    print(total_supply)
    
def main():
    deploy()