program lunar_concentrator
    implicit none

    ! --- Parameters ---
    integer :: n_rays, count, gx, gy, k
    real :: solar_flux, lens_diam, focal_len, sun_rad, pi
    real :: target_wd, grid(100, 100) 
    real :: rx, ry, dx, dy, dz, dist, r_val
    real :: r_lens, theta_lens, div_angle, div_phi, tx, ty
    real :: total_power, peak_count, peak_flux
    real :: x_root, val_to_sqrt
    
    ! Pseudo-random (LCG)
    real :: seed, a, c, m

    ! Initialization
    n_rays = 10000        
    solar_flux = 1361.0   
    lens_diam = 0.5       
    focal_len = 2.0       
    sun_rad = 0.00465 
    pi = 3.14159265
    target_wd = 0.1       
    
    seed = 12345.0
    a = 1103515245.0
    c = 12345.0
    m = 2147483648.0

    do gx = 1, 100
        do gy = 1, 100
            grid(gx, gy) = 0.0
        end do
    end do

    print *, "Tracing rays using pure arithmetic (No library calls)..."

    count = 1
    do while (count <= n_rays)
        
        ! Random r_val
        seed = mod(a * seed + c, m)
        r_val = seed / m
        
        ! --- Manual SQRT for r_lens ---
        val_to_sqrt = r_val
        x_root = val_to_sqrt / 2.0 + 0.1
        do k = 1, 5
            x_root = 0.5 * (x_root + val_to_sqrt / x_root)
        end do
        r_lens = (lens_diam / 2.0) * x_root
        
        ! Random theta
        seed = mod(a * seed + c, m)
        theta_lens = 2.0 * pi * (seed / m)
        
        ! Trig Approx
        rx = r_lens * (1.0 - (theta_lens*theta_lens/2.0))
        ry = r_lens * theta_lens

        ! Random div_angle
        seed = mod(a * seed + c, m)
        val_to_sqrt = seed / m
        x_root = val_to_sqrt / 2.0 + 0.01
        do k = 1, 5
            x_root = 0.5 * (x_root + val_to_sqrt / x_root)
        end do
        div_angle = sun_rad * x_root
        
        seed = mod(a * seed + c, m)
        div_phi = 2.0 * pi * (seed / m)
        
        dx = div_angle * (1.0 - (div_phi*div_phi/2.0))
        dy = div_angle * div_phi
        dz = 1.0 - (div_angle*div_angle / 2.0)

        ! Refraction
        dx = dx + (0.0 - rx) / focal_len
        dy = dy + (0.0 - ry) / focal_len
        
        ! --- Manual SQRT for Distance ---
        val_to_sqrt = dx*dx + dy*dy + dz*dz
        x_root = val_to_sqrt / 2.0 + 0.1
        do k = 1, 5
            x_root = 0.5 * (x_root + val_to_sqrt / x_root)
        end do
        dist = x_root
        
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

    peak_count = 0.0
    do gx = 1, 100
        do gy = 1, 100
            if (grid(gx, gy) > peak_count) peak_count = grid(gx, gy)
        end do
    end do
    
    total_power = solar_flux * (pi * (lens_diam*lens_diam / 4.0))
    peak_flux = (peak_count / n_rays) * total_power / ((target_wd/100.0)**2)
    
    print *, "Peak Flux (W/m^2): ", peak_flux
    print *, "SiO2 Melting Point: 1713000 W/m^2"

end program lunar_concentrator
