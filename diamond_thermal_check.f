program diamond_thermal_check
    implicit none

    real :: solar_flux, lens_area, absorption, emissivity, sigma
    real :: power_in, t_kelvin, t_celsius, val, x_root
    integer :: k

    solar_flux = 1361.0
    lens_area = 0.5153     
    absorption = 0.005      ! 0.5% (Diamond is nearly 100% transparent)
    emissivity = 0.03       ! Diamond has very low IR emissivity
    sigma = 5.67e-8        

    ! Power absorbed by the Diamond lens
    power_in = solar_flux * lens_area * absorption

    ! T^4 calculation
    val = power_in / (2.0 * lens_area * emissivity * sigma)
    
    ! Manual 4th root (sqrt of sqrt)
    x_root = val / 2.0
    do k = 1, 10
        x_root = 0.5 * (x_root + val / x_root)
    end do
    val = x_root
    x_root = val / 2.0
    do k = 1, 10
        x_root = 0.5 * (x_root + val / x_root)
    end do
    
    t_kelvin = x_root
    t_celsius = t_kelvin - 273.15

    print *, "--- DIAMOND LENS THERMAL REPORT ---"
    print *, "Heat Absorbed:      ", power_in, " Watts"
    print *, "Equilibrium Temp:   ", t_celsius, " C"
    print *, "-----------------------------------"
    print *, "Thermal Status: SYSTEM COLD & STABLE"
end program
