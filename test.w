@ TODO: read from file (from \.{curl} which writes internet radio to pipe) and write to file
(sound card device - see {\sl pcm\/})

@c
#include <unistd.h>                                                  /*  17 */
#include <fcntl.h>
#include "mp32pcm.h"
#define BUFSIZE (4*MP3_MIN_BUFFER)
int
main (void)
{
  int id, my;

  mp3_sample buffer[BUFSIZE];

  int size;

  id = mp3_open(read, NULL);
  if (id < 0)
    return 1;
  my = open("o.mp3", O_RDONLY);
  dup2(my, STDIN_FILENO);
  close(my);
  my = open("o.pcm", O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR);
  dup2(my, STDOUT_FILENO);
  close(my);
  while ((size = mp3_read (id, buffer, BUFSIZE)) > 0)
    write (1, buffer, size * sizeof (mp3_sample));
  if (mp3_close (id) < 0)
    return 1;
  return 0;
}
