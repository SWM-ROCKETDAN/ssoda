def calculate_expenditure_count(price):
    if not price:
        price = 0
    return price


def calculate_level_expenditure(reward_level: int, reward_price: int) -> list:
    level_expenditure = [0, 0, 0, 0, 0]
    if not reward_level and not reward_price:
        return level_expenditure
    if reward_level < 1 or reward_level > 5:
        return level_expenditure
    level_expenditure[int(reward_level - 1)] += reward_price
    return level_expenditure
