@ Usig file streams enstead of raw files is better because they do buffering for us.

@c
#include <stdio.h>

int main(void)
{
  FILE *fp_in, *fp_out;
  if ((fp_in = fopen("o.pcm", "r")) == NULL) {
    perror("open failed on input");
    return 1;
  }
  if ((fp_out = fopen("stereo.pcm", "w")) == NULL) {
    perror("open failed on output");
    return 1;
  }
  signed short buf;
  while (fread(&buf, sizeof (signed short), 1, fp_in)) {
    if (!fwrite(&buf, sizeof (signed short), 1, fp_out)) {
      perror("write failed\n");
      return 1;
    }
    buf = 0;
    if (!fwrite(&buf, sizeof (signed short), 1, fp_out)) {
      perror("write failed\n");
      return 1;
    }
  }
  if (ferror(fp_in)) {
    perror("read failed\n");
    return 1;
  }
  fclose(fp_in);
  fclose(fp_out);
  return 0;
}
