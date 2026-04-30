program lunar_explorer_sim
    implicit none

    ! --- Design Metrics (Updated) ---
    real, parameter :: PI = 3.14159265
    real, parameter :: MASS_WET = 382.5       ! kg (with Aluminum tanks)
    real, parameter :: LENS_DIAM = 1.75       ! meters
    real, parameter :: TARGET_O2 = 37.5       ! kg (75% refuel goal)
    
    ! --- Production Constants ---
    real, parameter :: SOLAR_FLUX = 1361.0    ! W/m^2 (Lunar Noon)
    real, parameter :: EFFICIENCY = 0.22      ! System thermal/chem efficiency
    real, parameter :: O2_PER_W_MIN = 0.0006  ! Theoretical O2 (g) per Watt-min
    
    ! --- Propulsion Metrics ---
    real, parameter :: THRUST_AL_LOX = 1500.0 ! Newtons
    real, parameter :: ISP_AL_LOX = 250.0     ! seconds
    real, parameter :: G_LUNAR = 1.625        ! m/s^2
    real, parameter :: G0 = 9.81              ! Earth gravity for ISP calc

    ! --- Simulation Variables ---
    real :: solar_power, o2_rate, days_to_fill
    real :: dv_target, mass_final, propellant_mass, burn_time

    ! 1. OXYGEN PRODUCTION SIMULATION
    solar_power = SOLAR_FLUX * PI * (LENS_DIAM/2.0)**2
    o2_rate = solar_power * O2_PER_W_MIN ! Grams per minute
    
    ! Time to fill 37.5 kg O2 in minutes
    ! 37500g / rate = minutes. Divide by 1440 for Earth days.
    days_to_fill = (TARGET_O2 * 1000.0 / o2_rate) / 1440.0

    ! 2. FLIGHT ABILITY SIMULATION (100 m/s Hop)
    dv_target = 100.0
    ! Tsiolkovsky: dV = Isp * g0 * ln(m0 / m1)
    ! m1 = m0 / e^(dV / (Isp * g0))
    mass_final = MASS_WET / exp(dv_target / (ISP_AL_LOX * G0))
    propellant_mass = MASS_WET - mass_final
    
    ! Burn time calculation: m_dot = Thrust / (Isp * g0)
    burn_time = propellant_mass / (THRUST_AL_LOX / (ISP_AL_LOX * G0))

    ! OUTPUT RESULTS
    print *, "--- Lunar Explorer Simulation (LFortran) ---"
    print *, "Solar Power Captured: ", solar_power, " Watts"
    print *, "O2 Production Rate:   ", o2_rate, " g/min"
    print *, "Days to reach 75% O2: ", days_to_fill, " Earth Days"
    print *, ""
    print *, "--- 100 m/s Hop Physics ---"
    print *, "Propellant Consumed:  ", propellant_mass, " kg"
    print *, "Burn Duration:       ", burn_time, " seconds"
    print *, "Remaining Mass:      ", mass_final, " kg"
    print *, "--------------------------------------------"

end program lunar_explorer_sim
