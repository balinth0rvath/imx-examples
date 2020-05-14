# . /opt/fslc-xwayland/2.5.3/environment-setup-armv7at2hf-neon-fslc-linux-gnueabi
CCFLAGS= -g -c
LDFLAGS= -g -o

SOURCES = $(wildcard *.s )
OBJECTS = $(SOURCES:.s=.o)
TARGET = wasm

wasm: $(OBJECTS)                 
		$(CC) $(CCFLAGS) $(SOURCES)
		${CC} $(LDFLAGS) $@ $^ -lwayland-client -lEGL -lGLESv2 -lwayland-egl  

clean:
	rm *.o wasm 


