# . /opt/fslc-xwayland/2.5.3/environment-setup-armv7at2hf-neon-fslc-linux-gnueabi
CCFLAGS= -g -c
LDFLAGS= -g -o

SOURCES = $(wildcard *.s)
OBJECTS = $(SOURCES:.s=.o)
TARGET =base

$(TARGET): $(OBJECTS)                 
		$(CC) $(CCFLAGS) $(SOURCES)
		${CC} $(LDFLAGS) $@ $^    

clean:
	rm *.o $(TARGET)


