from brownie import UBToken

from scripts.scripts_util import get_account

def test_symbol():
    account= get_account()
    ubToken = UBToken.deploy({"from":account});
    symbol = ubToken.symbol()
    assert(symbol == "UB")
    
def test_name():
    account= get_account()
    ubToken = UBToken.deploy({"from":account});
    name = ubToken.name()
    assert(name == "University of Bridgeport")
    