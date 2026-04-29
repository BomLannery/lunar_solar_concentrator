program solar_flare_impact
    implicit none

    real :: flare_intensity, shield_thickness, radiation_dose
    logical :: cpu_error, motor_fail
    real :: lens_transparency, seed, a, c, m

    ! --- Flare Parameters ---
    flare_intensity = 150.0  ! Arbitrary "X-class" units
    shield_thickness = 5.0   ! 5mm Aluminum equivalent
    lens_transparency = 0.98 ! Start at 98%
    
    ! Pseudo-random flare timing
    seed = 54321.0
    a = 1103515245.0
    c = 12345.0
    m = 2147483648.0

    print *, "--- SOLAR FLARE EVENT DETECTED (Cycle 12) ---"

    ! 1. Calculate Dose reaching internal electronics
    ! (Simplistic inverse relationship)
    radiation_dose = flare_intensity / (shield_thickness * 1.5)
    
    ! 2. Check for Bit-Flipping (SEU)
    seed = mod(a * seed + c, m)
    if ((seed / m) < 0.15) then
        cpu_error = .true.
        print *, "EVENT: CPU Bit-Flip detected! Flight computer rebooting..."
    else
        cpu_error = .false.
    end if

    ! 3. Lens Darkening (Degradation)
    lens_transparency = lens_transparency - (flare_intensity * 0.0001)

    print *, "Internal Radiation Dose: ", radiation_dose, " mSv"
    print *, "Lens Transparency:      ", lens_transparency * 100.0, "%"
    print *, "---------------------------------------------"

    if (radiation_dose > 50.0) then
        print *, "CRITICAL: Compressor motor shielding breached."
    else
        print *, "STATUS: Shielding held. Systems operational."
    end if

end program solar_flare_impact
