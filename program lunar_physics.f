program lunar_physics_sim
    implicit none

    ! --- Design Metrics ---
    real, parameter :: m0 = 382.5             ! Initial mass (kg)
    real, parameter :: gl = 1.625             ! Lunar gravity (m/s^2)
    real, parameter :: f_thrust = 1500.0      ! Thrust (N)
    real, parameter :: m_dot = 0.612          ! Mass flow (kg/s)
    
    ! --- Trajectory Variables ---
    real :: dt = 0.5                          ! Time step (seconds)
    real :: t, mass, vx, vz, px, pz
    real :: ax, az, burn_t
    
    ! --- Manual Trig Approximation (45 degrees) ---
    ! cos(45) and sin(45) are approx 0.7071
    real, parameter :: cos45 = 0.7071
    real, parameter :: sin45 = 0.7071

    ! Initialize Mission
    t = 0.0
    mass = m0
    vx = 0.0; vz = 0.0
    px = 0.0; pz = 0.0
    burn_t = 25.0                             ! 25 second "Kick"

    print *, "T(s)  | Mass(kg) | Alt(m) | Range(km)"
    print *, "------------------------------------"

    ! Simulation Loop
    do while (t < 1.0 .or. pz > 0.0)
        
        if (t <= burn_t) then
            ! --- Powered Flight ---
            ax = (f_thrust * cos45) / mass
            az = ((f_thrust * sin45) - (mass * gl)) / mass
            mass = mass - (m_dot * dt)
        else
            ! --- Ballistic Flight ---
            ax = 0.0
            az = -gl
        end if

        ! Euler Integration
        vx = vx + (ax * dt)
        vz = vz + (az * dt)
        px = px + (vx * dt)
        pz = pz + (vz * dt)
        t = t + dt

        ! Output every 20 steps to avoid clutter
        if (mod(t, 10.0) < 0.1) then
            print *, t, mass, pz, px/1000.0
        end if

        ! Safety exit
        if (t > 300.0) exit
    end do

    print *, "------------------------------------"
    print *, "Final Range (km): ", px / 1000.0
    print *, "Final Mass (kg):  ", mass
end program lunar_physics_sim
