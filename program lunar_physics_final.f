program lunar_physics_final
    implicit none

    real :: solar_pwr, energy_req, efficiency, pi
    real :: total_o2_daily, mission_total, mass_per_tank
    real :: tank_vol_l, tank_press_bar, r_o2, temp_k

    ! Specs from our 1.0m focal length run
    solar_pwr = 267.23
    pi = 3.14159265
    energy_req = 20.0e6   ! 20 MJ/kg for pure thermal dissociation
    efficiency = 0.85     ! Dome collection rate
    
    ! 1. Daily Mass Calculation
    ! (Watts / Joules) * Efficiency * Seconds_in_day
    total_o2_daily = (solar_pwr / energy_req) * efficiency * 86400.0
    mission_total = total_o2_daily * 14.0
    mass_per_tank = mission_total / 3.0

    ! 2. Pressure Calculation (P = mRT / V)
    tank_vol_l = 15.0      ! 15 Liter tanks
    temp_k = 294.0         ! Room temp storage
    r_o2 = 259.8           ! Gas constant
    
    ! (kg * R * T) / (Volume in m^3) = Pascals
    ! 1 bar = 100,000 Pascals
    tank_press_bar = (mass_per_tank * r_o2 * temp_k) / (tank_vol_l / 1000.0) / 100000.0

    print *, "--- 14-DAY THERMAL MISSION REPORT ---"
    print *, "Total Oxygen Yield:   ", mission_total, " kg"
    print *, "Yield per Day:        ", total_o2_daily, " kg/day"
    print *, "--------------------------------------"
    print *, "Per Tank (3 total):   ", mass_per_tank, " kg"
    print *, "Tank Pressure:        ", tank_press_bar, " bar"
    print *, "--------------------------------------"
    print *, "Status: Sustainable Mechanical Operation"

end program lunar_physics_final
