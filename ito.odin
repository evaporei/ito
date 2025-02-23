package ito

Thread :: struct {
    os_thread: OS_Thread,
    data: ^Thread_Data,
}

Thread_Data :: struct {
    fn: proc(rawptr),
    arg: rawptr,
}

thread_init :: proc (t: ^Thread, fn: proc(rawptr), arg: rawptr) {
    t.data = _os_thread_init(&t.os_thread, fn, arg)
}

thread_join :: proc (t: ^Thread) {
    _os_thread_join(&t.os_thread)
    free(t.data)
}

thread_detach :: proc (t: ^Thread) {
    _os_thread_detach(&t.os_thread)
}
