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

void wl_registry_add_listener_wrapper(
						struct wl_registry* registry, 
						struct wl_registry_listener* listener,
						struct wl_display* display) 
{
	wl_registry_add_listener(registry, listener, display);
}

void* wl_registry_bind_wrapper(
						struct wl_registry* registry,
						uint32_t name,
						void* compositor_interface,
						uint32_t version)
{
	return wl_registry_bind(registry, name, compositor_interface, version);	
}

struct wl_surface* wl_compositor_create_surface_wrapper(struct wl_compositor* compositor) 
{
	return wl_compositor_create_surface(compositor);
} 

struct wl_shell_surface* wl_shell_get_shell_surface_wrapper(struct wl_shell* shell,
															struct wl_surface* surface)
{
	return wl_shell_get_shell_surface(shell, surface);
}

void wl_shell_surface_set_toplevel_wrapper(struct wl_shell_surface* shell_surface)
{
	return wl_shell_surface_set_toplevel(shell_surface);
}



