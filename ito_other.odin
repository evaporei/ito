#+build js, wasi, orca
package ito

OS_Thread :: struct {}

_os_thread_init :: proc(os_t: ^OS_Thread) -> (data: ^Thread_Data) {
    unimplemented("ito::thread procedure not supported on target")
    return nil
}

_os_thread_join :: proc(os_t: ^OS_Thread) {
    unimplemented("ito::thread procedure not supported on target")
}

_os_thread_detach :: proc(os_t: ^OS_Thread) {
    unimplemented("ito::thread procedure not supported on target")
}
