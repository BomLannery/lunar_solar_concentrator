program oxygen_degradation
    implicit none

    real :: initial_transparency, final_transparency
    real :: initial_pwr, final_pwr, initial_o2, final_o2
    real :: flux_initial, flux_final
    real :: melt_threshold

    ! Initial Specs (0.81m lens, 1.0m focus)
    initial_pwr = 701.3     ! Watts
    initial_o2 = 2.56       ! kg/day
    initial_transparency = 0.98 ! 98% (new glass)
    melt_threshold = 1713000.0  ! W/m^2

    ! --- SOLAR FLARE DAMAGE ---
    ! We assume 8% darkening from a massive X-class flare
    final_transparency = initial_transparency - 0.08
    
    ! Final Power = Initial Power * (New / Old Transparency)
    final_pwr = initial_pwr * (final_transparency / initial_transparency)
    
    ! Since oxygen yield is linear with power (at these temps)
    final_o2 = initial_o2 * (final_pwr / initial_pwr)

    ! Calculate Flux to ensure we can still melt
    ! Spot area was ~0.00027 m^2
    flux_initial = initial_pwr / 0.000271
    flux_final = final_pwr / 0.000271

    print *, "--- POST-FLARE SYSTEM RADIOLOGY ---"
    print *, "Lens Transparency:  ", final_transparency * 100.0, "%"
    print *, "Captured Power:     ", final_pwr, " Watts"
    print *, "-----------------------------------"
    print *, "Original O2 Yield:  ", initial_o2, " kg/day"
    print *, "New O2 Yield:       ", final_o2, " kg/day"
    print *, "Total Yield Loss:   ", (initial_o2 - final_o2) * 1000.0, " grams/day"
    print *, "-----------------------------------"

    if (flux_final > melt_threshold) then
        print *, "Thermal Status: SYSTEM OPERATIONAL (Flux > Threshold)"
    else
        print *, "Thermal Status: SYSTEM FAILURE - Cannot melt regolith"
    end if

end program oxygen_degradation
