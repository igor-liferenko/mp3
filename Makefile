all:
	clang -g -w -c -o perform.o perform.c
	clang -g -w -c -o mp32pcm.o mp32pcm.c
	clang -g -o example example.c perform.o mp32pcm.o -lm
	gtts-cli o -l en -o o.mp3
