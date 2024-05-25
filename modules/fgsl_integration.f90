module fgsl_integration
  !> Numerical integration
  use fgsl_base
  use fgsl_math
  implicit none

  private :: gsl_integration_qng, gsl_integration_workspace_alloc, &
    gsl_integration_workspace_free, gsl_integration_qag, gsl_integration_qags, &
    gsl_integration_qagp, gsl_integration_qagi, gsl_integration_qagiu, &
    gsl_integration_qagil, gsl_integration_qawc, gsl_integration_qaws_table_alloc, &
    gsl_integration_qaws_table_set, gsl_integration_qaws_table_free, &
    gsl_integration_qaws, gsl_integration_qawo_table_alloc, &
    gsl_integration_qawo_table_set, gsl_integration_qawo_table_set_length, &
    gsl_integration_qawo_table_free, gsl_integration_qawo, gsl_integration_qawf, &
    gsl_integration_cquad_workspace_alloc, gsl_integration_cquad_workspace_free, &
    gsl_integration_cquad, gsl_integration_romberg_alloc, gsl_integration_romberg_free, &
    gsl_integration_romberg, gsl_integration_glfixed_table_alloc, &
    gsl_integration_glfixed_table_free, gsl_integration_glfixed, &
    gsl_integration_glfixed_point, gsl_integration_fixed_free, gsl_integration_fixed_n, &
    gsl_integration_fixed_nodes, gsl_integration_fixed_weights, gsl_integration_fixed
    
   private :: gsl_aux_sizeof_integration_workspace, gsl_aux_sizeof_integration_qaws_table, &
     gsl_aux_sizeof_integration_qawo_table, gsl_aux_integration_fixed_alloc
     
  ! Types and Constants
  !
  type, public :: fgsl_integration_workspace
     private
     type(c_ptr) :: gsl_integration_workspace = c_null_ptr
  end type fgsl_integration_workspace
  integer(fgsl_int), parameter, public :: fgsl_integ_gauss15 = 1
  integer(fgsl_int), parameter, public :: fgsl_integ_gauss21 = 2
  integer(fgsl_int), parameter, public :: fgsl_integ_gauss31 = 3
  integer(fgsl_int), parameter, public :: fgsl_integ_gauss41 = 4
  integer(fgsl_int), parameter, public :: fgsl_integ_gauss51 = 5
  integer(fgsl_int), parameter, public :: fgsl_integ_gauss61 = 6
  type, public :: fgsl_integration_qaws_table
     private
     type(c_ptr) :: gsl_integration_qaws_table = c_null_ptr
  end type fgsl_integration_qaws_table
  type, public :: fgsl_integration_qawo_table
     private
     type(c_ptr) :: gsl_integration_qawo_table = c_null_ptr
  end type fgsl_integration_qawo_table
  integer(fgsl_int), parameter, public :: fgsl_integ_cosine = 0
  integer(fgsl_int), parameter, public :: fgsl_integ_sine = 1
  type, public :: fgsl_integration_cquad_workspace
     private
     type(c_ptr) :: gsl_integration_cquad_workspace = c_null_ptr
  end type fgsl_integration_cquad_workspace
  type, public :: fgsl_integration_romberg_workspace
     private
     type(c_ptr) :: gsl_integration_romberg_workspace  = c_null_ptr
  end type fgsl_integration_romberg_workspace
  type, public :: fgsl_integration_glfixed_table
     private
     type(c_ptr) :: gsl_integration_glfixed_table = c_null_ptr
  end type fgsl_integration_glfixed_table
  type, public :: fgsl_integration_fixed_workspace
     private
     type(c_ptr) :: gsl_integration_fixed_workspace = c_null_ptr
  end type fgsl_integration_fixed_workspace
  integer(fgsl_int), parameter, public :: fgsl_integration_fixed_legendre = 1
  integer(fgsl_int), parameter, public :: fgsl_integration_fixed_chebyshev = 2
  integer(fgsl_int), parameter, public :: fgsl_integration_fixed_gegenbauer = 3
  integer(fgsl_int), parameter, public :: fgsl_integration_fixed_jacobi = 4
  integer(fgsl_int), parameter, public :: fgsl_integration_fixed_laguerre = 5
  integer(fgsl_int), parameter, public :: fgsl_integration_fixed_hermite = 6
  integer(fgsl_int), parameter, public :: fgsl_integration_fixed_exponential = 7
  integer(fgsl_int), parameter, public :: fgsl_integration_fixed_rational = 8
  integer(fgsl_int), parameter, public :: fgsl_integration_fixed_chebyshev2 = 9
  
  !
  ! Generics
  interface fgsl_well_defined
     module procedure fgsl_integration_workspace_status
     module procedure fgsl_integration_cquad_workspace_status
     module procedure fgsl_integration_qawo_table_status
     module procedure fgsl_integration_qaws_table_status
     module procedure fgsl_integration_glfixed_table_status    
  end interface
  interface fgsl_sizeof
     module procedure fgsl_sizeof_integration_workspace
     module procedure fgsl_sizeof_integration_qaws_table
     module procedure fgsl_sizeof_integration_qawo_table  
  end interface
  !
  ! C interfaces
  interface
    function gsl_integration_qng(f, a, b, epsabs, epsrel, result, abserr, neval) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: a, b, epsabs, epsrel
      real(c_double), intent(out) :: result, abserr
      integer(c_size_t), intent(inout) :: neval
      integer(c_int) :: gsl_integration_qng
    end function gsl_integration_qng
    function gsl_integration_workspace_alloc (n) bind(c)
      import
      integer(c_size_t), value :: n
      type(c_ptr) :: gsl_integration_workspace_alloc
    end function gsl_integration_workspace_alloc
    subroutine gsl_integration_workspace_free (w) bind(c)
      import
      type(c_ptr), value :: w
    end subroutine gsl_integration_workspace_free
    function gsl_integration_qag(f, a, b, epsabs, epsrel, limit, key, &
         workspace, result, abserr) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: a, b, epsabs, epsrel
      integer(c_size_t), value :: limit
      integer(c_int), value :: key
      type(c_ptr), value :: workspace
      real(c_double), intent(out) :: result, abserr
      integer(c_int) :: gsl_integration_qag
    end function gsl_integration_qag
    function gsl_integration_qags(f, a, b, epsabs, epsrel, limit, &
         workspace, result, abserr) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: a, b, epsabs, epsrel
      integer(c_size_t), value :: limit
      type(c_ptr), value :: workspace
      real(c_double), intent(out) :: result, abserr
      integer(c_int) :: gsl_integration_qags
    end function gsl_integration_qags
    function gsl_integration_qagp(f, pts, npts, epsabs, epsrel, limit, &
         workspace, result, abserr) bind(c)
      import
      type(c_ptr), value :: f
      type(c_ptr), value :: pts
      integer(c_size_t), value :: npts
      real(c_double), value :: epsabs, epsrel
      integer(c_size_t), value :: limit
      type(c_ptr), value :: workspace
      real(c_double), intent(out) :: result, abserr
      integer(c_int) :: gsl_integration_qagp
    end function gsl_integration_qagp
    function gsl_integration_qagi(f, epsabs, epsrel, limit, &
         workspace, result, abserr) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: epsabs, epsrel
      integer(c_size_t), value :: limit
      type(c_ptr), value :: workspace
      real(c_double), intent(out) :: result, abserr
      integer(c_int) :: gsl_integration_qagi
    end function gsl_integration_qagi
    function gsl_integration_qagiu(f, a, epsabs, epsrel, limit, &
         workspace, result, abserr) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: a, epsabs, epsrel
      integer(c_size_t), value :: limit
      type(c_ptr), value :: workspace
      real(c_double), intent(out) :: result, abserr
      integer(c_int) :: gsl_integration_qagiu
    end function gsl_integration_qagiu
    function gsl_integration_qagil(f, b, epsabs, epsrel, limit, &
         workspace, result, abserr) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: b, epsabs, epsrel
      integer(c_size_t), value :: limit
      type(c_ptr), value :: workspace
      real(c_double), intent(out) :: result, abserr
      integer(c_int) :: gsl_integration_qagil
    end function gsl_integration_qagil
    function gsl_integration_qawc(f, a, b, c, epsabs, epsrel, limit, &
         workspace, result, abserr) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: a, b, c, epsabs, epsrel
      integer(c_size_t), value :: limit
      type(c_ptr), value :: workspace
      real(c_double), intent(out) :: result, abserr
      integer(c_int) :: gsl_integration_qawc
    end function gsl_integration_qawc
    function gsl_integration_qaws_table_alloc (alpha, beta, mu, nu) bind(c)
      import
      real(c_double), value :: alpha, beta
      integer(c_int), value :: mu, nu
      type(c_ptr) :: gsl_integration_qaws_table_alloc
    end function gsl_integration_qaws_table_alloc
    function gsl_integration_qaws_table_set(t, alpha, beta, mu, nu) bind(c)
      import
      type(c_ptr), value :: t
      real(c_double), value :: alpha, beta
      integer(c_int), value :: mu, nu
      integer(c_int) :: gsl_integration_qaws_table_set
    end function gsl_integration_qaws_table_set
    subroutine gsl_integration_qaws_table_free (w) bind(c)
      import
      type(c_ptr), value :: w
    end subroutine gsl_integration_qaws_table_free
    function gsl_integration_qaws(f, a, b, t, epsabs, epsrel, limit, workspace, &
         result, abserr) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: a, b, epsabs, epsrel
      type(c_ptr), value :: t
      integer(c_size_t), value :: limit
      type(c_ptr), value :: workspace
      real(c_double), intent(out) :: result, abserr
      integer(c_int) :: gsl_integration_qaws
    end function gsl_integration_qaws
    function gsl_integration_qawo_table_alloc(omega, l, sine, n) bind(c)
      import
      real(c_double), value :: omega, l
      integer(c_int), value :: sine
      integer(c_size_t), value :: n
      type(c_ptr) :: gsl_integration_qawo_table_alloc
    end function gsl_integration_qawo_table_alloc
    function gsl_integration_qawo_table_set(t, omega, l, sine) bind(c)
      import
      type(c_ptr), value :: t
      real(c_double), value :: omega, l
      integer(c_int), value :: sine
      integer(c_int) :: gsl_integration_qawo_table_set
    end function gsl_integration_qawo_table_set
    function gsl_integration_qawo_table_set_length(t, l) bind(c)
      import
      type(c_ptr), value :: t
      real(c_double), value :: l
      integer(c_int) :: gsl_integration_qawo_table_set_length
    end function gsl_integration_qawo_table_set_length
    subroutine gsl_integration_qawo_table_free (w) bind(c)
      import
      type(c_ptr), value :: w
    end subroutine gsl_integration_qawo_table_free
    function gsl_integration_qawo(f, a, epsabs, epsrel, limit, workspace, &
         wf, result, abserr) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: a,  epsabs, epsrel
      integer(c_size_t), value :: limit
      type(c_ptr), value :: workspace, wf
      real(c_double), intent(out) :: result, abserr
      integer(c_int) :: gsl_integration_qawo
    end function gsl_integration_qawo
    function gsl_integration_qawf(f, a, epsabs, limit, workspace, cyc_workspace, &
         wf, result, abserr) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: a,  epsabs
      integer(c_size_t), value :: limit
      type(c_ptr), value :: workspace, cyc_workspace, wf
      real(c_double), intent(out) :: result, abserr
      integer(c_int) :: gsl_integration_qawf
    end function gsl_integration_qawf
    function gsl_integration_cquad_workspace_alloc (n) bind(c)
      import
      integer(c_size_t), value :: n
      type(c_ptr) :: gsl_integration_cquad_workspace_alloc
    end function gsl_integration_cquad_workspace_alloc
    subroutine gsl_integration_cquad_workspace_free (w) bind(c)
      import
      type(c_ptr), value :: w
    end subroutine gsl_integration_cquad_workspace_free
    function gsl_integration_cquad(f, a, b, epsabs, epsrel, &
         workspace, result, abserr, nevals) bind(c)
      import
      type(c_ptr), value :: f
      real(c_double), value :: a, b, epsabs, epsrel
      type(c_ptr), value :: workspace
      real(c_double), intent(out) :: result, abserr
      integer(c_size_t) :: nevals
      integer(c_int) :: gsl_integration_cquad
    end function gsl_integration_cquad
    function gsl_integration_romberg_alloc(n) bind(c)
      import :: c_ptr, c_size_t
      type(c_ptr) :: gsl_integration_romberg_alloc
      integer(c_size_t), value :: n
    end function gsl_integration_romberg_alloc
    subroutine gsl_integration_romberg_free(w) bind(c)
      import :: c_ptr
      type(c_ptr), value :: w 
    end subroutine gsl_integration_romberg_free
    function gsl_integration_romberg(f, a, b, epsabs, epsrel, result, neval, w) &
         bind(c)
      import :: c_ptr, c_double, c_size_t, c_int
      integer(c_int) :: gsl_integration_romberg
      type(c_ptr), value :: f
      real(c_double), value :: a, b, epsabs, epsrel
      real(c_double) :: result
      integer(c_size_t) :: neval
      type(c_ptr), value :: w
    end function gsl_integration_romberg
    function gsl_integration_glfixed_table_alloc(n) bind(c)
      import :: c_size_t, c_ptr
      integer(c_size_t), value :: n
      type(c_ptr) :: gsl_integration_glfixed_table_alloc
    end function gsl_integration_glfixed_table_alloc
    subroutine gsl_integration_glfixed_table_free(t) bind(c)
      import :: c_ptr
      type(c_ptr), value :: t
    end subroutine gsl_integration_glfixed_table_free
    function gsl_integration_glfixed(f, a, b, t) bind(c)
      import :: c_double, c_ptr
      real(c_double) :: gsl_integration_glfixed
      type(c_ptr), value :: f
      real(c_double), value :: a, b
      type(c_ptr), value :: t
    end function gsl_integration_glfixed
    function gsl_integration_glfixed_point(a, b, i, xi, wi, t) bind(c)
      import :: c_double, c_ptr, c_size_t, c_int
      integer(c_int) :: gsl_integration_glfixed_point
      real(c_double), value :: a, b
      integer(c_size_t), value :: i
      real(c_double) :: xi, wi
      type(c_ptr), value :: t
    end function gsl_integration_glfixed_point
    subroutine gsl_integration_fixed_free(w) bind(c)
      import :: c_ptr
      type(c_ptr), value :: w
    end subroutine gsl_integration_fixed_free
    function gsl_integration_fixed_n(w) bind(c)
      import :: c_size_t, c_ptr
      integer(c_size_t) :: gsl_integration_fixed_n
      type(c_ptr), value :: w
    end function gsl_integration_fixed_n
    function gsl_integration_fixed_nodes(w) bind(c)
      import :: c_ptr
      type(c_ptr) :: gsl_integration_fixed_nodes
      type(c_ptr), value :: w
    end function gsl_integration_fixed_nodes
    function gsl_integration_fixed_weights(w) bind(c)
      import :: c_ptr
      type(c_ptr) :: gsl_integration_fixed_weights
      type(c_ptr), value :: w
    end function gsl_integration_fixed_weights
    function gsl_integration_fixed(func, result, w) bind(c)
      import :: c_ptr, c_int
      integer(c_int) :: gsl_integration_fixed
      type(c_ptr), value :: func, w, result
    end function gsl_integration_fixed
!
    function gsl_aux_sizeof_integration_workspace() bind(c)
      import :: c_size_t
      integer(c_size_t) :: gsl_aux_sizeof_integration_workspace
    end function gsl_aux_sizeof_integration_workspace
    function gsl_aux_sizeof_integration_qaws_table() bind(c)
      import :: c_size_t
      integer(c_size_t) :: gsl_aux_sizeof_integration_qaws_table
    end function gsl_aux_sizeof_integration_qaws_table
    function gsl_aux_sizeof_integration_qawo_table() bind(c)
      import :: c_size_t
      integer(c_size_t) :: gsl_aux_sizeof_integration_qawo_table
    end function gsl_aux_sizeof_integration_qawo_table
    function gsl_aux_integration_fixed_alloc(t, n, a, b, alpha, beta) bind(c)
      import :: c_ptr, c_size_t, c_double, c_int
      type(c_ptr) :: gsl_aux_integration_fixed_alloc
      integer(c_int), value :: t
      integer(c_size_t), value :: n
      real(c_double), value :: a, b, alpha, beta
    end function gsl_aux_integration_fixed_alloc
 
  end interface
contains	
! API
  function fgsl_integration_qng(f, a, b, epsabs, epsrel, result, abserr, neval)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: a, b, epsabs, epsrel
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_size_t), intent(inout) :: neval
    integer(fgsl_int) :: fgsl_integration_qng
    fgsl_integration_qng = gsl_integration_qng(f%gsl_function, a, b, epsabs, epsrel, &
         result, abserr, neval)
  end function fgsl_integration_qng
  function fgsl_integration_workspace_alloc(n)
    integer(fgsl_size_t), intent(in) :: n
    type(fgsl_integration_workspace) :: fgsl_integration_workspace_alloc
    fgsl_integration_workspace_alloc%gsl_integration_workspace = &
         gsl_integration_workspace_alloc(n)
  end function fgsl_integration_workspace_alloc
  subroutine fgsl_integration_workspace_free(w)
    type(fgsl_integration_workspace), intent(inout) :: w
    if (c_associated(w%gsl_integration_workspace)) &
         call gsl_integration_workspace_free (w%gsl_integration_workspace)
  end subroutine fgsl_integration_workspace_free
  function fgsl_integration_qag(f, a, b, epsabs, epsrel, limit, key, &
         workspace, result, abserr)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: a, b, epsabs, epsrel
    integer(fgsl_size_t), intent(in) :: limit
    integer(fgsl_int), intent(in) :: key
    type(fgsl_integration_workspace), intent(inout) :: workspace
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_int) :: fgsl_integration_qag
    fgsl_integration_qag = gsl_integration_qag(f%gsl_function, &
         a, b, epsabs, epsrel, limit, key, workspace%gsl_integration_workspace, &
         result, abserr)
  end function fgsl_integration_qag
  function fgsl_integration_qags(f, a, b, epsabs, epsrel, limit, &
         workspace, result, abserr)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: a, b, epsabs, epsrel
    integer(fgsl_size_t), intent(in) :: limit
    type(fgsl_integration_workspace), intent(inout) :: workspace
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_int) :: fgsl_integration_qags
    fgsl_integration_qags = gsl_integration_qags(f%gsl_function, &
         a, b, epsabs, epsrel, limit, workspace%gsl_integration_workspace, &
         result, abserr)
  end function fgsl_integration_qags
  function fgsl_integration_qagp(f, pts, epsabs, epsrel, limit, &
         workspace, result, abserr)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in), target, contiguous :: pts(:)
    real(fgsl_double), intent(in) :: epsabs, epsrel
    integer(fgsl_size_t), intent(in) :: limit
    type(fgsl_integration_workspace), intent(inout) :: workspace
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_int) :: fgsl_integration_qagp
    fgsl_integration_qagp = gsl_integration_qagp(f%gsl_function, &
         c_loc(pts), size(pts, dim=1, kind=fgsl_size_t), epsabs, epsrel, &
         limit, workspace%gsl_integration_workspace, result, abserr)
  end function fgsl_integration_qagp
  function fgsl_integration_qagi(f, epsabs, epsrel, limit, &
         workspace, result, abserr)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: epsabs, epsrel
    integer(fgsl_size_t), intent(in) :: limit
    type(fgsl_integration_workspace), intent(inout) :: workspace
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_int) :: fgsl_integration_qagi
    fgsl_integration_qagi = gsl_integration_qagi(f%gsl_function, &
         epsabs, epsrel, limit, workspace%gsl_integration_workspace, &
         result, abserr)
  end function fgsl_integration_qagi
  function fgsl_integration_qagiu(f, a, epsabs, epsrel, limit, &
         workspace, result, abserr)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: a, epsabs, epsrel
    integer(fgsl_size_t), intent(in) :: limit
    type(fgsl_integration_workspace), intent(inout) :: workspace
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_int) :: fgsl_integration_qagiu
    fgsl_integration_qagiu = gsl_integration_qagiu(f%gsl_function, &
         a, epsabs, epsrel, limit, workspace%gsl_integration_workspace, &
         result, abserr)
  end function fgsl_integration_qagiu
  function fgsl_integration_qagil(f, b, epsabs, epsrel, limit, &
         workspace, result, abserr)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: b, epsabs, epsrel
    integer(fgsl_size_t), intent(in) :: limit
    type(fgsl_integration_workspace), intent(inout) :: workspace
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_int) :: fgsl_integration_qagil
    fgsl_integration_qagil = gsl_integration_qagil(f%gsl_function, &
         b, epsabs, epsrel, limit, workspace%gsl_integration_workspace, &
         result, abserr)
  end function fgsl_integration_qagil
  function fgsl_integration_qawc(f, a, b, c, epsabs, epsrel, limit, &
         workspace, result, abserr)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: a, b, c, epsabs, epsrel
    integer(fgsl_size_t), intent(in) :: limit
    type(fgsl_integration_workspace), intent(inout) :: workspace
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_int) :: fgsl_integration_qawc
    fgsl_integration_qawc = gsl_integration_qawc(f%gsl_function, &
         a, b, c, epsabs, epsrel, limit, workspace%gsl_integration_workspace, &
         result, abserr)
  end function fgsl_integration_qawc
  function fgsl_integration_qaws_table_alloc (alpha, beta, mu, nu)
    real(fgsl_double), intent(in) :: alpha, beta
    integer(fgsl_int), intent(in) :: mu, nu
    type(fgsl_integration_qaws_table) :: fgsl_integration_qaws_table_alloc
    fgsl_integration_qaws_table_alloc%gsl_integration_qaws_table = &
         gsl_integration_qaws_table_alloc (alpha, beta, mu, nu)
  end function fgsl_integration_qaws_table_alloc
  function fgsl_integration_qaws_table_set (t, alpha, beta, mu, nu)
    type(fgsl_integration_qaws_table) :: t
    real(fgsl_double), intent(in) :: alpha, beta
    integer(fgsl_int), intent(in) :: mu, nu
    integer(c_int) :: fgsl_integration_qaws_table_set
    fgsl_integration_qaws_table_set = &
         gsl_integration_qaws_table_set (t%gsl_integration_qaws_table, alpha, beta, mu, nu)
  end function fgsl_integration_qaws_table_set
  subroutine fgsl_integration_qaws_table_free (w)
    type(fgsl_integration_qaws_table), intent(inout) :: w
    if (c_associated(w%gsl_integration_qaws_table)) &
         call gsl_integration_qaws_table_free (w%gsl_integration_qaws_table)
  end subroutine fgsl_integration_qaws_table_free
  function fgsl_integration_qaws(f, a, b, t, epsabs, epsrel, limit, workspace, &
       result, abserr)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: a, b, epsabs, epsrel
    type(fgsl_integration_qaws_table), intent(in) :: t
    integer(fgsl_size_t), intent(in) :: limit
    type(fgsl_integration_workspace), intent(inout) :: workspace
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_int) :: fgsl_integration_qaws
    fgsl_integration_qaws = gsl_integration_qaws(f%gsl_function, a, b, &
         t%gsl_integration_qaws_table, epsabs, epsrel, limit, &
         workspace%gsl_integration_workspace, result, abserr)
  end function fgsl_integration_qaws
  function fgsl_integration_qawo_table_alloc(omega, l, sine, n)
    real(fgsl_double), intent(in) :: omega, l
    integer(fgsl_int), intent(in) :: sine
    integer(fgsl_size_t), intent(in) :: n
    type(fgsl_integration_qawo_table) :: fgsl_integration_qawo_table_alloc
    fgsl_integration_qawo_table_alloc%gsl_integration_qawo_table = &
         gsl_integration_qawo_table_alloc(omega, l, sine, n)
  end function fgsl_integration_qawo_table_alloc
  function fgsl_integration_qawo_table_set(t, omega, l, sine)
    type(fgsl_integration_qawo_table), intent(inout) :: t
    real(fgsl_double), intent(in) :: omega, l
    integer(fgsl_int), intent(in) :: sine
    integer(fgsl_int) :: fgsl_integration_qawo_table_set
    fgsl_integration_qawo_table_set = &
         gsl_integration_qawo_table_set(t%gsl_integration_qawo_table, omega, l, sine)
  end function fgsl_integration_qawo_table_set
  function fgsl_integration_qawo_table_set_length(t, l)
    type(fgsl_integration_qawo_table), intent(inout) :: t
    real(fgsl_double), intent(in) :: l
    integer(fgsl_int) :: fgsl_integration_qawo_table_set_length
    fgsl_integration_qawo_table_set_length = &
         gsl_integration_qawo_table_set_length(t%gsl_integration_qawo_table, l)
  end function fgsl_integration_qawo_table_set_length
  subroutine fgsl_integration_qawo_table_free (w)
    type(fgsl_integration_qawo_table), intent(inout) :: w
    if (c_associated(w%gsl_integration_qawo_table)) &
         call gsl_integration_qawo_table_free (w%gsl_integration_qawo_table)
  end subroutine fgsl_integration_qawo_table_free
  function fgsl_integration_qawo (f, a, epsabs, epsrel, limit, workspace, &
         wf, result, abserr)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: a,  epsabs, epsrel
    integer(fgsl_size_t), intent(in) :: limit
    type(fgsl_integration_workspace), intent(inout) :: workspace
    type(fgsl_integration_qawo_table), intent(in) :: wf
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_int) :: fgsl_integration_qawo
    fgsl_integration_qawo = gsl_integration_qawo(f%gsl_function, a, epsabs, epsrel, &
         limit, workspace%gsl_integration_workspace, wf%gsl_integration_qawo_table, &
         result, abserr)
  end function fgsl_integration_qawo
  function fgsl_integration_qawf(f, a, epsabs, limit, workspace, cyc_workspace, &
       wf, result, abserr)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: a,  epsabs
    integer(fgsl_size_t), intent(in) :: limit
    type(fgsl_integration_workspace), intent(inout) :: workspace, cyc_workspace
    type(fgsl_integration_qawo_table), intent(in) :: wf
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_int) :: fgsl_integration_qawf
    fgsl_integration_qawf = gsl_integration_qawf(f%gsl_function, a, epsabs, limit, &
         workspace%gsl_integration_workspace, cyc_workspace%gsl_integration_workspace, &
         wf%gsl_integration_qawo_table, result, abserr)
  end function fgsl_integration_qawf
  function fgsl_integration_cquad_workspace_alloc(n)
    integer(fgsl_size_t), intent(in) :: n
    type(fgsl_integration_cquad_workspace) :: fgsl_integration_cquad_workspace_alloc
    fgsl_integration_cquad_workspace_alloc%gsl_integration_cquad_workspace = &
         gsl_integration_cquad_workspace_alloc(n)
  end function fgsl_integration_cquad_workspace_alloc
  subroutine fgsl_integration_cquad_workspace_free(w)
    type(fgsl_integration_cquad_workspace), intent(inout) :: w
    if (c_associated(w%gsl_integration_cquad_workspace)) &
         call gsl_integration_cquad_workspace_free (w%gsl_integration_cquad_workspace)
  end subroutine fgsl_integration_cquad_workspace_free
  function fgsl_integration_cquad(f, a, b, epsabs, epsrel, workspace, result, abserr, nevals)
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: a, b, epsabs, epsrel
    type(fgsl_integration_cquad_workspace), intent(inout) :: workspace
    real(fgsl_double), intent(out) :: result, abserr
    integer(fgsl_size_t), intent(inout) :: nevals
    integer(fgsl_int) :: fgsl_integration_cquad
    fgsl_integration_cquad = gsl_integration_cquad(f%gsl_function, &
         a, b, epsabs, epsrel, workspace%gsl_integration_cquad_workspace, &
         result, abserr, nevals)
  end function fgsl_integration_cquad

  function fgsl_integration_romberg_alloc(n) 
    type(fgsl_integration_romberg_workspace) :: fgsl_integration_romberg_alloc
    integer(fgsl_size_t), intent(in) :: n
    fgsl_integration_romberg_alloc%gsl_integration_romberg_workspace = &
          gsl_integration_romberg_alloc(n)
  end function fgsl_integration_romberg_alloc
  subroutine fgsl_integration_romberg_free(w) 
    type(fgsl_integration_romberg_workspace), intent(inout) :: w 
    call gsl_integration_romberg_free(w%gsl_integration_romberg_workspace)
  end subroutine fgsl_integration_romberg_free
  function fgsl_integration_romberg(f, a, b, epsabs, epsrel, result, neval, w)
    integer(fgsl_int) :: fgsl_integration_romberg
    type(fgsl_function) :: f
    real(fgsl_double), intent(in) :: a, b, epsabs, epsrel
    real(fgsl_double), intent(inout) :: result
    integer(c_size_t), intent(inout) :: neval
    type(fgsl_integration_romberg_workspace), intent(inout) :: w
    fgsl_integration_romberg = gsl_integration_romberg(f%gsl_function, a, b, &
         epsabs, epsrel, result, neval, w%gsl_integration_romberg_workspace)
  end function fgsl_integration_romberg

  function fgsl_integration_glfixed_table_alloc(n)
    integer(fgsl_size_t), intent(in) :: n
    type(fgsl_integration_glfixed_table) :: fgsl_integration_glfixed_table_alloc
    fgsl_integration_glfixed_table_alloc%gsl_integration_glfixed_table = &
         gsl_integration_glfixed_table_alloc(n)
  end function fgsl_integration_glfixed_table_alloc
  subroutine fgsl_integration_glfixed_table_free(t)
    type(fgsl_integration_glfixed_table) :: t
    call gsl_integration_glfixed_table_free(t%gsl_integration_glfixed_table)
  end subroutine fgsl_integration_glfixed_table_free
  function fgsl_integration_glfixed(f, a, b, t)
    real(fgsl_double) :: fgsl_integration_glfixed
    type(fgsl_function), intent(in) :: f
    real(fgsl_double), intent(in) :: a, b
    type(fgsl_integration_glfixed_table), intent(in) :: t
    fgsl_integration_glfixed = gsl_integration_glfixed(f%gsl_function, a, b, &
         t%gsl_integration_glfixed_table)
  end function fgsl_integration_glfixed
  function fgsl_integration_glfixed_point(a, b, i, xi, wi, t)
    integer(fgsl_int) :: fgsl_integration_glfixed_point
    real(fgsl_double), intent(in) :: a, b
    integer(fgsl_size_t), intent(in) :: i
    real(fgsl_double), intent(inout) :: xi, wi
    type(fgsl_integration_glfixed_table), intent(in) :: t
    fgsl_integration_glfixed_point = gsl_integration_glfixed_point(a, b, i, &
         xi, wi, t%gsl_integration_glfixed_table)
  end function fgsl_integration_glfixed_point
  function fgsl_integration_fixed_alloc(t, n, a, b, alpha, beta)
    type(fgsl_integration_fixed_workspace) :: fgsl_integration_fixed_alloc
    integer(fgsl_int), intent(in) :: t
    integer(fgsl_size_t), intent(in) :: n
    real(fgsl_double), intent(in) :: a, b, alpha, beta
    fgsl_integration_fixed_alloc%gsl_integration_fixed_workspace = &
         gsl_aux_integration_fixed_alloc(t, n, a, b, alpha, beta)
  end function fgsl_integration_fixed_alloc
  subroutine fgsl_integration_fixed_free(w)
    type(fgsl_integration_fixed_workspace), intent(inout) :: w
    call gsl_integration_fixed_free(w%gsl_integration_fixed_workspace)
  end subroutine fgsl_integration_fixed_free
  function fgsl_integration_fixed_n(w) 
    integer(fgsl_size_t) :: fgsl_integration_fixed_n
    type(fgsl_integration_fixed_workspace), intent(in) :: w
    fgsl_integration_fixed_n = gsl_integration_fixed_n(&
         w%gsl_integration_fixed_workspace)
  end function fgsl_integration_fixed_n
  function fgsl_integration_fixed_nodes(w) 
    real(fgsl_double), pointer :: fgsl_integration_fixed_nodes(:)
    type(fgsl_integration_fixed_workspace), intent(in) :: w
    integer(fgsl_size_t) :: n
    type(c_ptr) :: p
    n = gsl_integration_fixed_n(w%gsl_integration_fixed_workspace)
    p = gsl_integration_fixed_nodes(w%gsl_integration_fixed_workspace)
    if (c_associated(p)) then
       call c_f_pointer(p,fgsl_integration_fixed_nodes,[n])
    else
       nullify(fgsl_integration_fixed_nodes)
    end if
  end function fgsl_integration_fixed_nodes
  function fgsl_integration_fixed_weights(w) 
    real(fgsl_double), pointer :: fgsl_integration_fixed_weights(:)
    type(fgsl_integration_fixed_workspace), intent(in) :: w
    integer(fgsl_size_t) :: n
    type(c_ptr) :: p
    n = gsl_integration_fixed_n(w%gsl_integration_fixed_workspace)
    p = gsl_integration_fixed_weights(w%gsl_integration_fixed_workspace)
    if (c_associated(p)) then
       call c_f_pointer(p,fgsl_integration_fixed_weights,[n])
    else
       nullify(fgsl_integration_fixed_weights)
    end if
  end function fgsl_integration_fixed_weights
  function fgsl_integration_fixed(func, result, w)
    integer(fgsl_int) :: fgsl_integration_fixed
    type(fgsl_function), intent(inout) :: func
    real(fgsl_double), target :: result
    type(fgsl_integration_fixed_workspace), intent(in) :: w
    fgsl_integration_fixed = gsl_integration_fixed(func%gsl_function, &
         c_loc(result), w%gsl_integration_fixed_workspace)
  end function fgsl_integration_fixed
!
! additional utilities
!
  function fgsl_integration_workspace_status(integration_workspace)
    type(fgsl_integration_workspace), intent(in) :: integration_workspace
    logical :: fgsl_integration_workspace_status
    fgsl_integration_workspace_status = .true.
    if (.not. c_associated(integration_workspace%gsl_integration_workspace)) &
         fgsl_integration_workspace_status = .false.
  end function fgsl_integration_workspace_status
  function fgsl_integration_qaws_table_status(integration_qaws_table)
    type(fgsl_integration_qaws_table), intent(in) :: integration_qaws_table
    logical :: fgsl_integration_qaws_table_status
    fgsl_integration_qaws_table_status = .true.
    if (.not. c_associated(&
         integration_qaws_table%gsl_integration_qaws_table)) &
         fgsl_integration_qaws_table_status = .false.
  end function fgsl_integration_qaws_table_status
  function fgsl_integration_qawo_table_status(integration_qawo_table)
    type(fgsl_integration_qawo_table), intent(in) :: integration_qawo_table
    logical :: fgsl_integration_qawo_table_status
    fgsl_integration_qawo_table_status = .true.
    if (.not. c_associated(&
         integration_qawo_table%gsl_integration_qawo_table)) &
         fgsl_integration_qawo_table_status = .false.
  end function fgsl_integration_qawo_table_status
  function fgsl_integration_cquad_workspace_status(integration_workspace)
    type(fgsl_integration_cquad_workspace), intent(in) :: integration_workspace
    logical :: fgsl_integration_cquad_workspace_status
    fgsl_integration_cquad_workspace_status = .true.
    if (.not. c_associated(integration_workspace%gsl_integration_cquad_workspace)) &
         fgsl_integration_cquad_workspace_status = .false.
  end function fgsl_integration_cquad_workspace_status
 function fgsl_integration_glfixed_table_status(integration_glfixed_table)
    type(fgsl_integration_glfixed_table), intent(in) :: integration_glfixed_table
    logical :: fgsl_integration_glfixed_table_status
    fgsl_integration_glfixed_table_status = .true.
    if (.not. c_associated(&
         integration_glfixed_table%gsl_integration_glfixed_table)) &
         fgsl_integration_glfixed_table_status = .false.
  end function fgsl_integration_glfixed_table_status
  function fgsl_sizeof_integration_workspace(w)
    type(fgsl_integration_workspace), intent(in) :: w
    integer(fgsl_size_t) :: fgsl_sizeof_integration_workspace
    fgsl_sizeof_integration_workspace = gsl_aux_sizeof_integration_workspace()
  end function fgsl_sizeof_integration_workspace
  function fgsl_sizeof_integration_qaws_table(w)
    type(fgsl_integration_qaws_table), intent(in) :: w
    integer(fgsl_size_t) :: fgsl_sizeof_integration_qaws_table
    fgsl_sizeof_integration_qaws_table = &
         gsl_aux_sizeof_integration_qaws_table()
  end function fgsl_sizeof_integration_qaws_table
  function fgsl_sizeof_integration_qawo_table(w)
    type(fgsl_integration_qawo_table), intent(in) :: w
    integer(fgsl_size_t) :: fgsl_sizeof_integration_qawo_table
    fgsl_sizeof_integration_qawo_table = &
         gsl_aux_sizeof_integration_qawo_table()
  end function fgsl_sizeof_integration_qawo_table

end module fgsl_integration 
