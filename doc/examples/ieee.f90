program ieee
  use fgsl
  implicit none
  type(fgsl_file) :: stdout
  integer(fgsl_int) :: status
  real(fgsl_float) :: f
  real(fgsl_double) :: d, fd
  f = 1.0/3.0
  d = 1.D0/3.D0
  fd = f

  stdout = fgsl_stdout()
  write(*, fmt='('' f='')') 
  call fgsl_ieee_printf(f)
  status = fgsl_flush(stdout)
  write(*, '('''')')
  
  write(*, fmt='('' fd='')') 
  call fgsl_ieee_printf(fd)
  status = fgsl_flush(stdout)
  write(*, '('''')')

  write(*, fmt='('' d='')') 
  call fgsl_ieee_printf(d)
  status = fgsl_flush(stdout)
  write(*, '('''')')

end program ieee
