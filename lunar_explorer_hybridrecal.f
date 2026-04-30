program lunar_explorer_fixed
    implicit none

    ! --- Design Metrics ---
    real, parameter :: PI = 3.14159265
    real, parameter :: MASS_WET = 382.5       
    real, parameter :: LENS_DIAM = 1.75       
    real, parameter :: TARGET_O2 = 37.5       
    
    ! --- Production Constants ---
    real, parameter :: SOLAR_FLUX = 1361.0    
    real, parameter :: O2_PER_W_MIN = 0.0006  
    
    ! --- Propulsion Metrics ---
    real, parameter :: THRUST_TOTAL = 1500.0 
    real, parameter :: ISP_AL_LOX = 250.0     
    real, parameter :: G0 = 9.81              

    ! --- Pre-Calculated Math (to bypass exp() limitation) ---
    ! For dV = 100, Isp = 250: mass_ratio = 1.04163
    real, parameter :: MASS_RATIO_100 = 1.04163

    ! --- Simulation Variables ---
    real :: solar_power, o2_rate, days_to_fill
    real :: mass_final, propellant_mass, burn_time, m_dot

    ! 1. OXYGEN PRODUCTION
    solar_power = SOLAR_FLUX * PI * (LENS_DIAM / 2.0)**2
    o2_rate = solar_power * O2_PER_W_MIN 
    
    ! (37.5kg * 1000g) / rate / 1440 mins per day
    days_to_fill = (TARGET_O2 * 1000.0 / o2_rate) / 1440.0

    ! 2. FLIGHT PHYSICS (100 m/s Hop)
    mass_final = MASS_WET / MASS_RATIO_100
    propellant_mass = MASS_WET - mass_final
    
    ! m_dot = F / (Isp * g0)
    m_dot = THRUST_TOTAL / (ISP_AL_LOX * G0)
    burn_time = propellant_mass / m_dot

    ! OUTPUT
    print *, "--- Hybrid Lunar Explorer (Metric Config) ---"
    print *, "Solar Power:      ", solar_power, " Watts"
    print *, "O2 Rate:          ", o2_rate, " g/min"
    print *, "Refuel (75%):     ", days_to_fill, " Earth Days"
    print *, ""
    print *, "--- 100 m/s Hop Result ---"
    print *, "Propellant Used:  ", propellant_mass, " kg"
    print *, "Burn Time:        ", burn_time, " seconds"
    print *, "Mass Post-Kick:   ", mass_final, " kg"
    print *, "--------------------------------------------"

end program lunar_explorer_fixed
