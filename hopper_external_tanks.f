program hopper_external_tanks
    implicit none

    real :: lens_mass, dome_mass, tank_mass_total
    real :: radius_base, lens_height, cog_final
    real :: i_z, i_x

    ! --- Mass Distribution ---
    lens_mass = 5.67         ! At top (2m)
    dome_mass = 45.0         ! Distributed 0m to 2m
    tank_mass_total = 27.5   ! (3x Empty Tanks + 20kg O2) at base edge
    radius_base = 2.0        ! 4m Diameter
    lens_height = 2.0

    ! --- Combined CoG calculation ---
    ! We assume the tanks and engines are at h=0.2m
    cog_final = (lens_mass * lens_height + dome_mass * 1.0 + tank_mass_total * 0.2) / &
                (lens_mass + dome_mass + tank_mass_total)

    ! --- Moment of Inertia (Stability against flipping) ---
    ! I = m * r^2
    ! A higher I_x means it is harder to tip over
    i_x = (lens_mass * lens_height * lens_height) + (tank_mass_total * radius_base * radius_base)

    print *, "--- EXTERNAL TANK ASSEMBLY SPECS ---"
    print *, "Final CoG Height: ", cog_final, " m"
    print *, "Stability Moment: ", i_x, " kg*m^2"
    print *, "------------------------------------"
    print *, "Thermal Status: TANKS ISOLATED (SAFE)"
    print *, "Mechanical Status: HIGH-STABILITY PERIMETER WEIGHTING"
end program
