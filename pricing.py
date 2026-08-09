def final_price(base, discount_pct, tax_pct=0):
    discount_pct = min(max(discount_pct, 0), 100)
    discounted = base * (1 - discount_pct / 100)
    return round(discounted * (1 + tax_pct / 100), 2)
