#include <stdint.h>
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


int main(int argc, char * argv[])
{
  FILE * p_bin;
  FILE * p_header;
  int ch,i=0;
  char h_ch[5];
  char header_name[100];
  
  p_bin = fopen(argv[1], "r");
  assert(p_bin);
  sprintf(header_name,"%s.h",argv[1]);
  p_header = fopen(header_name,"w");
  assert(p_header);
  fprintf(p_header,"/* %s",argv[1]);
  fprintf(p_header,"*/\n");
  while ((ch = getc(p_bin)) != EOF)
  {
    if (i%16 == 0)
      fprintf(p_header,"\n");
      
    sprintf(h_ch, "0x%02X,",ch);
    fprintf(p_header,h_ch);
    i++;
  }
  return 0;
}
