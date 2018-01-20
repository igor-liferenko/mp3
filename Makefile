all:
	clang -g -w -c -o perform.o perform.c
	clang -g -w -c -o mp32pcm.o mp32pcm.c
	clang -g -o example example.c perform.o mp32pcm.o -lm
	gtts-cli "hello world" -l en -o o.mp3
	clang -o stereo stereo.c
