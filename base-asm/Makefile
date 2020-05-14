# . /opt/fslc-xwayland/2.5.3/environment-setup-armv7at2hf-neon-fslc-linux-gnueabi
CCFLAGS= -g -c
LDFLAGS= -g -o

CSOURCES = $(wildcard *.c)
SSOURCES = $(wildcard *.s )
SOBJECTS = $(SSOURCES:.s=.o)
COBJECTS = $(CSOURCES:.s=.o)

base: $(SOBJECTS)                 
		$(CC) $(CCFLAGS) $(SSOURCES)
		${CC} $(LDFLAGS) $@ $^ -lwayland-client -lEGL -lGLESv2 -lwayland-egl  

sandbox: $(COBJECTS)                 
		$(CC) $(CCFLAGS) $(CSOURCES)
		${CC} $(LDFLAGS) $@ $^ -lwayland-client -lEGL -lGLESv2 -lwayland-egl  
clean:
	rm *.o base sandbox 


