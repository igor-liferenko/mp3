#include <stdio.h>

int main(int argc, char **argv)
{
  (void) argc;
  FILE *fp_in, *fp_out;
  if ((fp_in = fopen(argv[1],"r")) == NULL) {
    perror("open failed on input");
    return 1;
  }
  if ((fp_out = fopen("stereo.pcm","w")) == NULL) {
    perror("open failed on output");
    return 1;
  }
  signed short buf;
  while (fread(&buf, sizeof (signed short), 1, fp_in) > 0) {
    fwrite(&buf, sizeof (signed short), 1, fp_out);
    if (ferror(fp_out)) {
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
