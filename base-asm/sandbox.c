// . /opt/fslc-xwayland/2.5.3/environment-setup-armv7at2hf-neon-fslc-linux-gnueabi
// ${CC} -DLINUX -g -o wex wayland-example.c lX11 -lwayland-client -lwayland-egl -lEGL -lGLESv2 
#include <wayland-client.h>

struct wl_display* display;

int main()
{
	display = wl_display_connect(NULL);	
	return 0;
}

