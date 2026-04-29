def calculate_o2_cost():
    # Constants
    days_per_cycle = 14  # Active sunlight days
    cycles = 24
    total_days = days_per_cycle * cycles
    
    # Payload & Landing (Using $1.2M/kg rate)
    landing_rate = 1.2e6
    propellant_mass = 20.0
    
    # --- Fused Silica Case ---
    dry_mass_silica = 89.17
    mfg_cost_silica = 30000.0
    landing_cost_silica = (dry_mass_silica + propellant_mass) * landing_rate
    total_mission_cost_silica = mfg_cost_silica + landing_cost_silica
    
    # O2 Yield for Silica: 2.56 kg/day for 12 cycles, 2.36 kg/day for 12 cycles
    o2_total_silica = (2.56 * 14 * 12) + (2.36 * 14 * 12)
    
    # --- Diamond Case ---
    dry_mass_diamond = 88.02
    mfg_cost_diamond = 1800000.0
    landing_cost_diamond = (dry_mass_diamond + propellant_mass) * landing_rate
    total_mission_cost_diamond = mfg_cost_diamond + landing_cost_diamond
    
    # O2 Yield for Diamond: Constant 2.56 kg/day for 24 cycles
    o2_total_diamond = 2.56 * 14 * 24
    
    # Final Calculations (Cost per gram)
    cost_per_gram_silica = total_mission_cost_silica / (o2_total_silica * 1000)
    cost_per_gram_diamond = total_mission_cost_diamond / (o2_total_diamond * 1000)
    
    return {
        "Total O2 Silica (kg)": o2_total_silica,
        "Total O2 Diamond (kg)": o2_total_diamond,
        "Cost per Gram Silica ($)": cost_per_gram_silica,
        "Cost per Gram Diamond ($)": cost_per_gram_diamond,
        "Total Mission Silica ($M)": total_mission_cost_silica / 1e6,
        "Total Mission Diamond ($M)": total_mission_cost_diamond / 1e6
    }

print(calculate_o2_cost())
