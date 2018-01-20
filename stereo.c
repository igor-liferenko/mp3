#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdio.h> /* |BUFSIZ| */
#include <fcntl.h>

#define MIN(X,Y) ((X) < (Y) ? (X) : (Y))

int main(int argc, char **argv)
{
        struct stat st;

        char buf[BUFSIZ];
 int               fd_in = open(argv[1], O_RDONLY);

                fstat(fd_in, &st);


int                fd_out = open("out.dat", O_CREAT | O_WRONLY, st.st_mode);

        size_t remaining = (size_t) st.st_size; /* see em.w */

        while (remaining > 0) {
                size_t requested = MIN(sizeof(buf), remaining);
                ssize_t rcount = read(fd_in, buf, requested);
                if (rcount < 0) return 1;
                for (int i = 0; i < rcount; i++) {
                        ssize_t wcount = write(fd_out, buf+i, 1);
                        if (wcount < 0 || wcount == 0 || (size_t)rcount < requested)
                            return 1;
                        remaining -= 1;
                        if (i%2 == 0 && i != 0) write(fd_out, "\0\0", 2);
                }
        }

  return 0;
}
