package ito

import "base:runtime"

Thread :: struct {
	os_thread: OS_Thread,
	data:      ^Thread_Data,
}

Thread_Data :: struct {
	fn:  proc(_: rawptr),
	arg: rawptr,
}

wrapper_ctx: runtime.Context

thread_init :: proc(t: ^Thread, fn: proc(_: rawptr), arg: rawptr) {
	wrapper_ctx = context

	data := new(Thread_Data)
	data.fn = fn
	data.arg = arg
	t.data = data

	_os_thread_init(&t.os_thread, data)
}

thread_join :: proc(t: ^Thread) {
	_os_thread_join(&t.os_thread)
	free(t.data)
}

thread_detach :: proc(t: ^Thread) {
	_os_thread_detach(&t.os_thread)
}
