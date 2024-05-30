module fgsl_ntuples
  !> N-Tuples
  use fgsl_base
  use fgsl_io
  use fgsl_histograms
  
  implicit none
  
  private :: gsl_ntuple_create, gsl_ntuple_open, gsl_ntuple_write, gsl_ntuple_read, &
    gsl_ntuple_close, fgsl_ntuple_select_fn_cinit, fgsl_ntuple_value_fn_cinit, &
    fgsl_ntuple_select_fn_cfree, fgsl_ntuple_value_fn_cfree, gsl_ntuple_project, &
    fgsl_aux_ntuple_data, fgsl_aux_ntuple_size
    
  !
  !> Types
  type, public :: fgsl_ntuple
     private
     type(c_ptr) :: gsl_ntuple = c_null_ptr
  end type fgsl_ntuple
  type, public :: fgsl_ntuple_select_fn
     private
     type(c_ptr) :: gsl_ntuple_select_fn = c_null_ptr
  end type fgsl_ntuple_select_fn
  type, public :: fgsl_ntuple_value_fn
     private
     type(c_ptr) :: gsl_ntuple_value_fn = c_null_ptr
  end type fgsl_ntuple_value_fn
  !
  !> Generics
  interface fgsl_well_defined
     module procedure fgsl_ntuple_status
     module procedure fgsl_ntuple_value_fn_status
     module procedure fgsl_ntuple_select_fn_status
  end interface
  !
  !> C interfaces
  interface
	  function gsl_ntuple_create(fname, data, size) bind(c)
	    import
	    type(c_ptr), value :: fname
	    type(c_ptr), value :: data
	    integer(c_size_t), value :: size
	    type(c_ptr) :: gsl_ntuple_create
	  end function gsl_ntuple_create
	  function gsl_ntuple_open(fname, data, size) bind(c)
	    import
	    type(c_ptr), value :: fname
	    type(c_ptr), value :: data
	    integer(c_size_t), value :: size
	    type(c_ptr) :: gsl_ntuple_open
	  end function gsl_ntuple_open
	  function gsl_ntuple_write(ntuple) bind(c)
	    import
	    type(c_ptr), value :: ntuple
	    integer(c_int) :: gsl_ntuple_write
	  end function gsl_ntuple_write
	  function gsl_ntuple_read(ntuple) bind(c)
	    import
	    type(c_ptr), value :: ntuple
	    integer(c_int) :: gsl_ntuple_read
	  end function gsl_ntuple_read
	  function gsl_ntuple_close(ntuple) bind(c)
	    import
	    type(c_ptr), value :: ntuple
	    integer(c_int) :: gsl_ntuple_close
	  end function gsl_ntuple_close
	  function fgsl_ntuple_select_fn_cinit(func, params) bind(c)
	    import
	    type(c_funptr), value :: func
	    type(c_ptr), value :: params
	    type(c_ptr) :: fgsl_ntuple_select_fn_cinit
	  end function fgsl_ntuple_select_fn_cinit
	  function fgsl_ntuple_value_fn_cinit(func, params) bind(c)
	    import
	    type(c_funptr), value :: func
	    type(c_ptr), value :: params
	    type(c_ptr) :: fgsl_ntuple_value_fn_cinit
	  end function fgsl_ntuple_value_fn_cinit
	  subroutine fgsl_ntuple_select_fn_cfree(sfunc) bind(c)
	    import
	    type(c_ptr), value :: sfunc
	  end subroutine fgsl_ntuple_select_fn_cfree
	  subroutine fgsl_ntuple_value_fn_cfree(sfunc) bind(c)
	    import
	    type(c_ptr), value :: sfunc
	  end subroutine fgsl_ntuple_value_fn_cfree
	  function gsl_ntuple_project(h, ntuple, value_func, select_func) bind(c)
	    import
	    type(c_ptr), value :: h, ntuple, value_func, select_func
	    integer(c_int) :: gsl_ntuple_project
	  end function gsl_ntuple_project
	!
	  function fgsl_aux_ntuple_data(ntuple) bind(c)
	    import
	    type(c_ptr), value :: ntuple
	    type(c_ptr) :: fgsl_aux_ntuple_data
	  end function fgsl_aux_ntuple_data
	  function fgsl_aux_ntuple_size(ntuple) bind(c)
	    import
	    type(c_ptr), value :: ntuple
	    integer(c_size_t) :: fgsl_aux_ntuple_size
	  end function fgsl_aux_ntuple_size
  end interface
contains
  function fgsl_ntuple_create(fname, data, size)
    character(kind=fgsl_char, len=*), intent(in) :: fname
    type(c_ptr), intent(in) :: data
    integer(fgsl_size_t), intent(in) :: size
    type(fgsl_ntuple) :: fgsl_ntuple_create
!
    character(kind=fgsl_char,len=fgsl_pathmax), target :: lname
    if (len(trim(fname)) < fgsl_pathmax) then
       lname = trim(fname) // c_null_char
       fgsl_ntuple_create%gsl_ntuple = &
            gsl_ntuple_create(c_loc(lname), data, size)
    else
       fgsl_ntuple_create%gsl_ntuple = c_null_ptr
    end if
  end function fgsl_ntuple_create
  function fgsl_ntuple_open(fname, data, size)
    character(kind=fgsl_char, len=*), intent(in) :: fname
    type(c_ptr), intent(in) :: data
    integer(fgsl_size_t), intent(in) :: size
    type(fgsl_ntuple) :: fgsl_ntuple_open
!
    character(kind=fgsl_char,len=fgsl_pathmax), target :: lname
    if (len(trim(fname)) < fgsl_pathmax) then
       lname = trim(fname) // c_null_char
       fgsl_ntuple_open%gsl_ntuple = &
            gsl_ntuple_open(c_loc(lname), data, size)
    else
       fgsl_ntuple_open%gsl_ntuple = c_null_ptr
    end if
  end function fgsl_ntuple_open
  function fgsl_ntuple_write(ntuple)
    type(fgsl_ntuple), intent(in) :: ntuple
    integer(fgsl_int) :: fgsl_ntuple_write
    fgsl_ntuple_write = gsl_ntuple_write(ntuple%gsl_ntuple)
  end function fgsl_ntuple_write
  function fgsl_ntuple_bookdata(ntuple)
    type(fgsl_ntuple), intent(in) :: ntuple
    integer(fgsl_int) :: fgsl_ntuple_bookdata
    fgsl_ntuple_bookdata = gsl_ntuple_write(ntuple%gsl_ntuple)
  end function fgsl_ntuple_bookdata
  function fgsl_ntuple_read(ntuple)
    type(fgsl_ntuple), intent(inout) :: ntuple
    integer(fgsl_int) :: fgsl_ntuple_read
    fgsl_ntuple_read = gsl_ntuple_read(ntuple%gsl_ntuple)
  end function fgsl_ntuple_read
  function fgsl_ntuple_close(ntuple)
    type(fgsl_ntuple), intent(inout) :: ntuple
    integer(fgsl_int) :: fgsl_ntuple_close
    fgsl_ntuple_close = gsl_ntuple_close(ntuple%gsl_ntuple)
  end function fgsl_ntuple_close
  function fgsl_ntuple_select_fn_init(func, params)
    interface
       function func(data, params) bind(c)
         use, intrinsic :: iso_c_binding
         type(c_ptr), value :: data
         type(c_ptr), value :: params
         integer(c_int) :: func
       end function func
    end interface
    type(c_ptr), intent(in) :: params
    type(fgsl_ntuple_select_fn) :: fgsl_ntuple_select_fn_init
!
    type(c_funptr) :: fp
    fp = c_funloc(func)
    fgsl_ntuple_select_fn_init%gsl_ntuple_select_fn = &
         fgsl_ntuple_select_fn_cinit(fp, params)
  end function fgsl_ntuple_select_fn_init
  function fgsl_ntuple_value_fn_init(func, params)
    interface
       function func(data, params) bind(c)
         use, intrinsic :: iso_c_binding
         type(c_ptr), value :: data
         type(c_ptr), value :: params
         real(c_double) :: func
       end function func
    end interface
    type(c_ptr), intent(in) :: params
    type(fgsl_ntuple_value_fn) :: fgsl_ntuple_value_fn_init
!
    type(c_funptr) :: fp
    fp = c_funloc(func)
    fgsl_ntuple_value_fn_init%gsl_ntuple_value_fn = &
         fgsl_ntuple_value_fn_cinit(fp, params)
  end function fgsl_ntuple_value_fn_init
  subroutine fgsl_ntuple_select_fn_free(sfunc)
    type(fgsl_ntuple_select_fn), intent(inout) :: sfunc
    call fgsl_ntuple_select_fn_cfree(sfunc%gsl_ntuple_select_fn)
  end subroutine fgsl_ntuple_select_fn_free
  subroutine fgsl_ntuple_value_fn_free(sfunc)
    type(fgsl_ntuple_value_fn), intent(inout) :: sfunc
    call fgsl_ntuple_value_fn_cfree(sfunc%gsl_ntuple_value_fn)
  end subroutine fgsl_ntuple_value_fn_free
  function fgsl_ntuple_project(h, ntuple, value_func, select_func)
    type(fgsl_histogram), intent(inout) :: h
    type(fgsl_ntuple), intent(in) :: ntuple
    type(fgsl_ntuple_value_fn), intent(in) :: value_func
    type(fgsl_ntuple_select_fn), intent(in) :: select_func
    integer(fgsl_int) :: fgsl_ntuple_project
    fgsl_ntuple_project = gsl_ntuple_project(h%gsl_histogram, &
         ntuple%gsl_ntuple, value_func%gsl_ntuple_value_fn, &
         select_func%gsl_ntuple_select_fn)
  end function fgsl_ntuple_project
! Add-ons
  function fgsl_ntuple_data(ntuple)
    type(fgsl_ntuple), intent(in) :: ntuple
    type(c_ptr) :: fgsl_ntuple_data
    fgsl_ntuple_data = fgsl_aux_ntuple_data(ntuple%gsl_ntuple)
  end function fgsl_ntuple_data
  function fgsl_ntuple_size(ntuple)
    type(fgsl_ntuple), intent(in) :: ntuple
    integer(fgsl_size_t) :: fgsl_ntuple_size
    fgsl_ntuple_size = fgsl_aux_ntuple_size(ntuple%gsl_ntuple)
  end function fgsl_ntuple_size
  function fgsl_ntuple_status(ntuple)
    type(fgsl_ntuple), intent(in) :: ntuple
    logical :: fgsl_ntuple_status
    fgsl_ntuple_status = .true.
    if (.not. c_associated(ntuple%gsl_ntuple)) fgsl_ntuple_status = .false.
  end function fgsl_ntuple_status
  function fgsl_ntuple_value_fn_status(ntuple_value_fn)
    type(fgsl_ntuple_value_fn), intent(in) :: ntuple_value_fn
    logical :: fgsl_ntuple_value_fn_status
    fgsl_ntuple_value_fn_status = .true.
    if (.not. c_associated(ntuple_value_fn%gsl_ntuple_value_fn)) &
         fgsl_ntuple_value_fn_status = .false.
  end function fgsl_ntuple_value_fn_status
  function fgsl_ntuple_select_fn_status(ntuple_select_fn)
    type(fgsl_ntuple_select_fn), intent(in) :: ntuple_select_fn
    logical :: fgsl_ntuple_select_fn_status
    fgsl_ntuple_select_fn_status = .true.
    if (.not. c_associated(ntuple_select_fn%gsl_ntuple_select_fn)) &
         fgsl_ntuple_select_fn_status = .false.
  end function fgsl_ntuple_select_fn_status

end module fgsl_ntuples
 
