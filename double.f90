program double
! Compile and run by:
! gfortran -O3 -march=native -ffast-math -funroll-loops double.f90 && ./a.out
implicit none
integer, parameter :: dp = kind(0d0)

real(dp), allocatable :: A(:), B(:), C(:)
integer :: n, m, i, j, niter
real(dp) :: prod
real(dp) :: t1, t2, freq
n = 1000
m = n
allocate(A(0:n-1), B(0:m-1), C(0:n+m-2))
! sin
A = 0
prod = 1
do i = 0, (n-1)/2
    j = 2*i+1
    if (i /= 0) prod = prod * (1-j)
    prod = prod * j;
    A(j) = 1._dp / prod
end do
! cos
B(0) = 1
B(1:) = 0
prod = 1
do i = 1, (m-1)/2
    j = 2*i
    prod = prod * (1-j)
    prod = prod * j;
    B(j) = 1._dp / prod
end do
niter = 10000
call cpu_time(t1)
do i = 1, niter
    call poly_mul(A, B, C)
end do
call cpu_time(t2)
print *, "sin(x) ="
call poly_print(A)
print *
print *, "cos(x) ="
call poly_print(B)
print *
print *, "sin(x)*cos(x) ="
call poly_print(C)

print *, "Total time:", (t2-t1) / niter
freq = 2.6e9_dp
print *, "Clock cycles in loop body:", (t2-t1) / niter * freq / (n*m)

contains

subroutine poly_mul(A, B, C)
real(dp), intent(in) :: A(0:), B(0:)
real(dp), intent(out) :: C(0:)
integer :: i, j
C = 0
do i = 0, size(A)-1
    do j = 0, size(B)-1
        C(i+j) = C(i+j) + A(i)*B(j)
    end do
end do
end subroutine

subroutine poly_print(A)
real(dp), intent(in) :: A(0:)
integer :: i
logical :: first
first = .true.
do i = 0, size(A)-1
    if (abs(A(i)) < tiny(1._dp)) cycle
    if (.not. first) write(*, "(' +')", advance="no")
    first = .false.
    if (i == 0) then
        write(*, "(es10.2)", advance="no") A(i)
    else if (i == 1) then
        write(*, "(es10.2, '*x')", advance="no") A(i)
    else
        write(*, "(es10.2, '*x^', i0)", advance="no") A(i), i
    end if
end do
write(*, "(' + O(x^', i0, ')')") size(A)
end subroutine

end program
