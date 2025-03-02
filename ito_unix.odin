#+build linux, darwin, freebsd, openbsd, netbsd, haiku
package ito

import "core:sys/posix"

OS_Thread :: struct {
    handle: posix.pthread_t,
}

wrapper_fn :: proc "c" (arg: rawptr) -> rawptr {
    context = wrapper_ctx

    data := cast(^Thread_Data) arg
    data.fn(data.arg)
    return nil
}

_os_thread_init :: proc(os_t: ^OS_Thread, data: ^Thread_Data) {
    result := posix.pthread_create(&os_t.handle, nil, wrapper_fn, data)
    assert(result == posix.Errno.NONE)
}

_os_thread_join :: proc(os_t: ^OS_Thread) {
    result := posix.pthread_join(os_t.handle, nil);
    assert(result == posix.Errno.NONE)
}

_os_thread_detach :: proc(os_t: ^OS_Thread) {
    result := posix.pthread_detach(os_t.handle);
    assert(result == posix.Errno.NONE)
}
