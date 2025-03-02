package tests

import "core:fmt"
import "core:log"
import "core:strings"
import "core:testing"

import ito "../"

thread_fn :: proc(arg: rawptr) {
	n := cast(^u32)arg
	n^ = 42

	// test allocation (will break if ctx is passed incorrectly)
	bla := make(map[int]string)
	defer delete(bla)
	s := strings.clone("asenoto")
	defer delete(s)
	bla[5] = s
}

@(test)
thread_test :: proc(t: ^testing.T) {
	thread: ito.Thread
	// stack is not shared between threads
	// if the main thread dies and the other
	// tries to read stack data, it will be UB
	arg := new(u32)
	defer free(arg)
	arg^ = 0
	ito.thread_init(&thread, thread_fn, arg)
	log.info("before join")
	// // both work
	ito.thread_join(&thread)
	// ito.thread_detach(&thread)
	log.info("after join")
	testing.expect_value(t, arg^, 42)
}
