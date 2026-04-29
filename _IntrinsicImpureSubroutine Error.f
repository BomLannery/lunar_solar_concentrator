program lunar_concentrator
    implicit none

    ! --- Parameters ---
    integer :: n_rays, count, gx, gy
    real :: solar_flux, lens_diam, focal_len, sun_rad, pi
    real :: target_wd, grid(100, 100) 
    real :: rx, ry, dx, dy, dz, dist, r_val
    real :: r_lens, theta_lens, div_angle, div_phi, tx, ty
    real :: total_power, peak_count, peak_flux

    n_rays = 100000      ! Reduced for speed in browser
    solar_flux = 1361.0   
    lens_diam = 0.5       
    focal_len = 2.0       
    sun_rad = 0.00465 
    pi = 3.14159265
    target_wd = 0.1       

    do gx = 1, 100
        do gy = 1, 100
            grid(gx, gy) = 0.0
        end do
    end do

    print *, "Tracing rays with math-bypass..."

    count = 1
    do while (count <= n_rays)
        call random_number(r_val)
        r_lens = (lens_diam / 2.0) * sqrt(r_val)
        call random_number(r_val)
        theta_lens = 2.0 * pi * r_val
        
        ! Manual Cosine/Sine approximation (Taylor Series) to avoid link errors
        rx = r_lens * (1.0 - (theta_lens**2/2.0) + (theta_lens**4/24.0))
        ry = r_lens * (theta_lens - (theta_lens**3/6.0) + (theta_lens**5/120.0))

        call random_number(r_val)
        div_angle = sun_rad * sqrt(r_val)
        call random_number(r_val)
        div_phi = 2.0 * pi * r_val
        
        dx = div_angle * (1.0 - (div_phi**2/2.0))
        dy = div_angle * div_phi
        dz = 1.0 - (div_angle**2 / 2.0)

        ! Ideal Refraction
        dx = dx + (0.0 - rx) / focal_len
        dy = dy + (0.0 - ry) / focal_len
        dist = sqrt(dx*dx + dy*dy + dz*dz)
        dx = dx / dist
        dy = dy / dist
        dz = dz / dist

        tx = rx + dx * (focal_len / dz)
        ty = ry + dy * (focal_len / dz)

        gx = int(((tx + (target_wd/2.0)) / target_wd) * 100.0) + 1
        gy = int(((ty + (target_wd/2.0)) / target_wd) * 100.0) + 1

        if (gx >= 1 .and. gx <= 100 .and. gy >= 1 .and. gy <= 100) then
            grid(gx, gy) = grid(gx, gy) + 1.0
        end if
        count = count + 1
    end do

    total_power = solar_flux * (pi * (lens_diam/2.0)**2)
    peak_count = 0.0
    do gx = 1, 100
        do gy = 1, 100
            if (grid(gx, gy) > peak_count) peak_count = grid(gx, gy)
        end do
    end do
    
    peak_flux = (peak_count / n_rays) * total_power / ((target_wd/100.0)**2)
    print *, "Peak Flux (W/m^2): ", peak_flux
end program lunar_concentrator
