
import pytest

@pytest.mark.parametrize("base,discount,expected", [
    (50, 100, 0.0),
    (50, 150, 0.0),
])
def test_discount_never_makes_price_negative(base, discount, expected):
    assert final_price(base, discount) == expected
