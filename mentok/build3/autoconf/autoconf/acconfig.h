/*
 * Solaris 2.6 does not have socklen_t.  We know that socklen_t must
 * always be int, so we defined it as such.
 */
#undef socklen_t


/* Define which threading model we have on the local machine.
** If we don't have one of these we're screwed.
*/
#undef HAVE_PTHREAD
#undef HAVE_PTHREAD_RWLOCK
#undef HAVE_SOLTHREADS
