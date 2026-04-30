import math

# Constants
production_rate_per_min = 0.924 # g/min for 1.2m lens (from previous turns)
target_o2 = 50000 # 50kg in grams
days_limit = 13
minutes_in_13_days = 13 * 24 * 60

# Check production
produced_o2_13_days = production_rate_per_min * minutes_in_13_days

# Efficiency factor needed to hit 50kg in 13 days
required_rate = target_o2 / minutes_in_13_days
lens_area_scaling = required_rate / 0.924 # relative to 1.2m lens
old_diameter = 1.2
new_diameter = old_diameter * math.sqrt(lens_area_scaling)

print(f"{produced_o2_13_days=}")
print(f"{required_rate=}")
print(f"{new_diameter=}")
