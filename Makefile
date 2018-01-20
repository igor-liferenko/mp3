all:
	clang -g -w -c -o perform.o perform.c
	clang -g -w -c -o mp32pcm.o mp32pcm.c
	clang -g -o example example.c perform.o mp32pcm.o -lm
	gtts-cli "hello world" -l en -o o.mp3
	./example
	clang -o stereo stereo.c
	./stereo
	../wavhdr/wavhdr -r 24000 stereo.pcm
	cp stereo.pcm stereo.raw
	sox -r 24000 -e signed -b 16 -c 2 stereo.raw stereo.wav
	cp o.pcm o.raw
	sox -r 24000 -e signed -b 16 -c 1 o.raw stereo-sox.wav remix 1 0
	echo all three must be equal:
	md5sum stereo.pcm.wav stereo.wav stereo-sox.wav
	sox stereo-sox.wav mono.wav remix 1
	sox -r 24000 -e signed -b 16 -c 1 o.raw o.wav
	echo the following two must be equal:
	md5sum o.wav mono.wav
