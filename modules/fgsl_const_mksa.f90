module fgsl_const_mksa
  !> Physical constants in MKSA uhits
  use fgsl_base
  
  implicit none
  
  
  real(fgsl_double), parameter, public :: fgsl_const_mksa_speed_of_light = 2.99792458e8_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_gravitational_constant = 6.673e-11_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_plancks_constant_h = 6.62606896e-34_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_plancks_constant_hbar = 1.05457162825e-34_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_astronomical_unit = 1.49597870691e11_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_light_year = 9.46053620707e15_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_parsec = 3.08567758135e16_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_grav_accel = 9.80665e0_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_electron_volt = 1.602176487e-19_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_mass_electron = 9.10938188e-31_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_mass_muon = 1.88353109e-28_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_mass_proton = 1.67262158e-27_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_mass_neutron = 1.67492716e-27_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_rydberg = 2.17987196968e-18_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_boltzmann = 1.3806504e-23_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_bohr_magneton = 9.27400899e-24_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_nuclear_magneton = 5.05078317e-27_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_electron_magnetic_moment = 9.28476362e-24_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_proton_magnetic_moment = 1.410606633e-26_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_molar_gas = 8.314472e0_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_standard_gas_volume = 2.2710981e-2_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_minute = 6e1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_hour = 3.6e3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_day = 8.64e4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_week = 6.048e5_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_inch = 2.54e-2_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_foot = 3.048e-1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_yard = 9.144e-1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_mile = 1.609344e3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_nautical_mile = 1.852e3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_fathom = 1.8288e0_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_mil = 2.54e-5_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_point = 3.52777777778e-4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_texpoint = 3.51459803515e-4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_micron = 1e-6_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_angstrom = 1e-10_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_hectare = 1e4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_acre = 4.04685642241e3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_barn = 1e-28_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_liter = 1e-3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_us_gallon = 3.78541178402e-3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_quart = 9.46352946004e-4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_pint = 4.73176473002e-4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_cup = 2.36588236501e-4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_fluid_ounce = 2.95735295626e-5_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_tablespoon = 1.47867647813e-5_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_teaspoon = 4.92892159375e-6_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_canadian_gallon = 4.54609e-3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_uk_gallon = 4.546092e-3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_miles_per_hour = 4.4704e-1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_kilometers_per_hour = 2.77777777778e-1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_knot = 5.14444444444e-1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_pound_mass = 4.5359237e-1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_ounce_mass = 2.8349523125e-2_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_ton = 9.0718474e2_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_metric_ton = 1e3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_uk_ton = 1.0160469088e3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_troy_ounce = 3.1103475e-2_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_carat = 2e-4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_unified_atomic_mass = 1.660538782e-27_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_gram_force = 9.80665e-3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_pound_force = 4.44822161526e0_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_kilopound_force = 4.44822161526e3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_poundal = 1.38255e-1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_calorie = 4.1868e0_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_btu = 1.05505585262e3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_therm = 1.05506e8_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_horsepower = 7.457e2_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_bar = 1e5_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_std_atmosphere = 1.01325e5_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_torr = 1.33322368421e2_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_meter_of_mercury = 1.33322368421e5_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_inch_of_mercury = 3.38638815789e3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_inch_of_water = 2.490889e2_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_psi = 6.89475729317e3_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_poise = 1e-1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_stokes = 1e-4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_faraday = 9.64853429775e4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_electron_charge = 1.602176487e-19_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_gauss = 1e-4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_stilb = 1e4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_lumen = 1e0_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_lux = 1e0_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_phot = 1e4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_footcandle = 1.076e1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_lambert = 1e4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_footlambert = 1.07639104e1_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_curie = 3.7e10_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_roentgen = 2.58e-4_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_rad = 1e-2_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_solar_mass = 1.98892e30_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_bohr_radius = 5.291772083e-11_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_newton = 1e0_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_dyne = 1e-5_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_joule = 1e0_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_erg = 1e-7_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_stefan_boltzmann_constant = 5.67040047374e-8_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_thomson_cross_section = 6.65245893699e-29_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_vacuum_permittivity = 8.854187817e-12_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_vacuum_permeability = 1.25663706144e-6_fgsl_double
  real(fgsl_double), parameter, public :: fgsl_const_mksa_debye = 3.33564095198e-30_fgsl_double
  
end module fgsl_const_mksa
