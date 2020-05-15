// linker cannot link static inline shared object function calls in assembly code
// Wrapper is a workaround until I find a better solution. Weston source
// shouldnt modififed. -fno-inline flag didnt work either.

#include <wayland-client.h>
#include <wayland-egl.h>
struct wl_registry* wl_display_get_registry_wrapper(struct wl_display* display)
{
	return wl_display_get_registry(display);
}

void wl_registry_add_listener_wrapper(
						struct wl_registry* registry, 
						struct wl_registry_listener* listener,
						struct wl_display* display) 
{
	wl_registry_add_listener(registry, listener, display);
}
