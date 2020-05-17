// . /opt/fslc-xwayland/2.5.3/environment-setup-armv7at2hf-neon-fslc-linux-gnueabi
// ${CC} -DLINUX -g -o wex wayland-example.c lX11 -lwayland-client -lwayland-egl -lEGL -lGLESv2 
/*
#include <wayland-client.h>
*/
#include <string.h>
#include <stdio.h>
/*
struct wl_display* display;
struct wl_registry* registry;

void global_object_available(void*, struct wl_registry*, uint32_t, const char*, uint32_t);
void global_object_removed(void*, struct wl_registry*, uint32_t);

void global_object_available(
						void* data,
						struct wl_registry* registry,
						uint32_t name,
						const char* interface,
						uint32_t version)
{
	printf("data %i", data);
	printf("registry %i", registry);
	printf("name %i", name);
	printf("interface %i", interface);
	printf("version %i", version);
}

void global_object_removed(
						void* data,
						struct wl_registry* registry,
						uint32_t name)
{
}
	
struct wl_registry_listener listener = {
	global_object_available,
	global_object_removed
}; 
*/
int main()
{
	/*
	display = wl_display_connect(NULL);
	registry= wl_display_get_registry(display);
	wl_registry_add_listener(registry, &listener, display);
	wl_display_dispatch(display);
	*/
	char a[20] = {"wl_compositor"};
	char b[20] = {"wl_seat"};

	if (strcmp(a,b)==0)
	{
		printf("Equal \n");
	}
		
	return 0;
}

