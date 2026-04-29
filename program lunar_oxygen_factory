program lunar_oxygen_factory
    implicit none

    ! --- Parameters ---
    integer :: n_rays, count, gx, gy, k
    real :: solar_flux, lens_diam, focal_len, sun_rad, pi
    real :: target_wd, grid(100, 100) 
    real :: rx, ry, dx, dy, dz, dist, r_val, x_root, val_to_sqrt
    real :: r_lens, theta_lens, div_angle, div_phi, tx, ty
    real :: total_power, peak_count, peak_flux
    
    ! --- Oxygen Extraction Variables ---
    real :: energy_per_kg_o2, collection_eff, o2_mass_fraction
    real :: power_watts, kg_per_second, grams_per_minute, daily_breath_kg
    
    ! --- Pseudo-random (LCG) ---
    real :: seed, a, c, m

    ! Initialization
    n_rays = 10000        
    solar_flux = 1361.0   
    lens_diam = 0.5       
    focal_len = 2.0       
    sun_rad = 0.00465 
    pi = 3.14159265
    target_wd = 0.1       
    
    ! ISRU Constants
    energy_per_kg_o2 = 20.0e6  ! Joules needed to liberate 1kg O2 via heat
    collection_eff = 0.20      ! 20% efficiency (conservative)
    daily_breath_kg = 0.84     ! What 1 human needs per day
    
    seed = 12345.0
    a = 1103515245.0
    c = 12345.0
    m = 2147483648.0

    ! [ ... Ray Tracing Loop from previous version ... ]
    ! (Keeping it simple: we assume the lens captures Power = Flux * Area)
    total_power = solar_flux * (pi * (lens_diam * lens_diam / 4.0))

    ! --- OXYGEN CALCULATION ---
    ! Power (Joules/sec) / Energy Required (Joules/kg) = kg of O2 per second
    kg_per_second = (total_power / energy_per_kg_o2) * collection_eff
    grams_per_minute = kg_per_second * 1000.0 * 60.0
    
    ! How many humans can this one 0.5m lens support?
    ! (Total kg per 24 hours / daily need)
    
    print *, "--- LUNAR OXYGEN EXTRACTION REPORT ---"
    print *, "Lens Diameter: ", lens_diam, " meters"
    print *, "Solar Power Captured: ", total_power, " Watts"
    print *, "--------------------------------------"
    print *, "O2 Production: ", grams_per_minute, " grams/minute"
    print *, "Daily O2 Yield: ", kg_per_second * 86400.0, " kg/day"
    print *, "Humans Supported: ", (kg_per_second * 86400.0) / daily_breath_kg
    print *, "--------------------------------------"
    print *, "Note: Requires a vacuum-sealed collection hood."

end program lunar_oxygen_factory
