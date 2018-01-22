all:
	clang -g -w -c -o perform.o perform.c
	clang -g -w -c -o mp32pcm.o mp32pcm.c
	clang -g -o example example.c perform.o mp32pcm.o -lm
	gtts-cli "hello world" -l en -o o.mp3
	./example
	ctangle stereo
	clang -o stereo stereo.c
	./stereo
	cp stereo.pcm stereo.raw
	sox -r 24000 -e signed -b 16 -c 2 stereo.raw stereo.wav
	cp o.pcm o.raw
	sox -r 24000 -e signed -b 16 -c 1 o.raw stereo-sox.wav remix 1 0
	echo all two must be equal:
	md5sum stereo.wav stereo-sox.wav
	sox stereo-sox.wav mono.wav remix 1
	sox -r 24000 -e signed -b 16 -c 1 o.raw o.wav
	echo the following two must be equal:
	md5sum o.wav mono.wav
	sox stereo.wav -r 44100 ready.wav
	rm o.raw
	dd if=o.wav of=o.raw bs=1 skip=44
	echo the following two must be equal:
	md5sum o.raw o.pcm
	rm stereo.raw
	dd if=stereo.wav of=stereo.raw bs=1 skip=44
	echo the following two must be equal:
	md5sum stereo.raw stereo.pcm
	dd if=/usr/share/sounds/alsa/Front_Right.wav of=Front_Right.raw bs=1 skip=44
	sox -r 48000 -e signed -b 16 -c 1 Front_Right.raw Front_Right.wav
	echo the following two must be equal:
	md5sum Front_Right.wav /usr/share/sounds/alsa/Front_Right.wav
