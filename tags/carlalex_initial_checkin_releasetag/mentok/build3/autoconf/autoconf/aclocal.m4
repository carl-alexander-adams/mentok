##########################################################################
## Additional test to check for socklen_t in socket.h
##  Note: this places (in config.h) the definition
##	#define socklen_t int
##  Untested: If your conventions/religion prefers having
##	typedef int socklen_t;
##  change AC_DEFINE(socklen_t,int) to AC_DEFINE(HAVE_SOCKLEN_T),
##  change the test from "= no" to "= yes",
##  change, in acconfig.h, "#undef socklen_t" to "#undef HAVE_SOCKLEN_T"
##  and in your files that use socklen_t, add
##	#ifndef HAVE_SOCKLEN_T
##	typedef int socklen_t;
##	#endif /* HAVE_SOCKLEN_T */
##########################################################################
AC_DEFUN(AC_TYPE_SOCKLEN_T, 
  [ AC_CACHE_CHECK(
	[for socklen_t],
	ac_cv_type_socklen_t,
	[ AC_TRY_COMPILE([#include <sys/socket.h>],
		 	 [socklen_t s; s = 0;],
  			 ac_cv_type_socklen_t=yes,
			 ac_cv_type_socklen_t=no)]
	)
    if test $ac_cv_type_socklen_t = no; then
	AC_DEFINE(socklen_t,int)
    fi
  ])
