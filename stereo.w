@ Usig file streams enstead of raw files is better because they do buffering for us.

@c
#include <wchar.h>
#include <stdio.h>

int main(void)
{
  FILE *fp_in, *fp_out;
  if ((fp_in = fopen("o.pcm", "r")) == NULL) {
    fwprintf(stderr, L"open failed on input: %m");
    return 1;
  }
  if ((fp_out = fopen("stereo.pcm", "w")) == NULL) {
    fwprintf(stderr, L"open failed on output: %m");
    return 1;
  }
  signed short buf;
  while (fread(&buf, sizeof (signed short), 1, fp_in)) {
    if (!fwrite(&buf, sizeof (signed short), 1, fp_out)) {
      fwprintf(stderr, L"write failed: %m\n");
      return 1;
    }
    buf = 0;
    if (!fwrite(&buf, sizeof (signed short), 1, fp_out)) {
      fwprintf(stderr, L"write failed: %m\n");
      return 1;
    }
  }
  if (ferror(fp_in))
    fwprintf(stderr, L"read failed: %m\n");

  fclose(fp_in);
  fclose(fp_out);

  return 0;
}
