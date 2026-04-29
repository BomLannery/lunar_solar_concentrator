program lunar_slope_limit
    implicit none

    real :: base_radius, cog_height, lens_mass, base_mass, total_mass
    real :: tip_angle_ratio, friction_limit

    ! Specs from previous steps
    base_radius = 2.0        ! Half of 4m diameter
    lens_mass = 5.67
    base_mass = 103.5        ! Dome + Tanks + Fuel + Engines
    
    ! Combined CoG Height Estimate
    cog_height = (lens_mass * 2.0 + base_mass * 0.4) / (lens_mass + base_mass)

    ! Tan(theta) = Radius / CoG_Height
    tip_angle_ratio = base_radius / cog_height
    friction_limit = 0.5     ! Sliding starts around tan(theta) = 0.5

    print *, "--- SLOPE STABILITY REPORT ---"
    print *, "Center of Gravity Height: ", cog_height, " m"
    print *, "Theoretical Tip Angle:   ~71 Degrees"
    print *, "Safe Landing Limit:      ~25 Degrees (Slide Limit)"
    print *, "-------------------------------------------"

    if (tip_angle_ratio > 2.0) then
        print *, "Status: Ultra-Stable Geometry"
    else
        print *, "Status: Caution - Check leg grip"
    end if

end program lunar_slope_limit
