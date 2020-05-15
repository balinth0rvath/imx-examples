// linker cannot link static inline shared object function calls in assembly code
// Wrapper is a workaround until I find a better solution. Weston source
// shouldnt modififed. -fno-inline flag didnt work either.

#include <wayland-client.h>
#include <wayland-egl.h>
#include <stdio.h>
struct wl_registry* wl_display_get_registry_wrapper(struct wl_display* display)
{
	return wl_display_get_registry(display);
}

void global_object_available2(
						void* data,
						struct wl_registry* registry,
						uint32_t name,
						const char* interface,
						uint32_t version)
{
	printf("avail");
}

void global_object_removed2(
						void* data,
						struct wl_registry* registry,
						uint32_t name)
{
}
	
struct wl_registry_listener listener2 = {
	global_object_available2,
	global_object_removed2
}; 


void wl_registry_add_listener_wrapper(
						struct wl_registry* registry, 
						struct wl_registry_listener* listener,
						struct wl_display* display) 
{
	wl_registry_add_listener(registry, listener, display);
}
