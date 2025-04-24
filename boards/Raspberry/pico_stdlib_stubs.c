// Weak stubs for syscalls to satisfy newlib when not linking with pico_stdlib
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

__attribute__((weak)) int _fstat(int fd, struct stat *st) { (void)fd; (void)st; return -1; }
__attribute__((weak)) int _isatty(int fd) { (void)fd; return 0; }
__attribute__((weak)) int _kill(int pid, int sig) { (void)pid; (void)sig; return -1; }
__attribute__((weak)) int _getpid(void) { return 1; }
__attribute__((weak)) int _close(int fd) { (void)fd; return -1; }
__attribute__((weak)) int _lseek(int fd, int ptr, int dir) { (void)fd; (void)ptr; (void)dir; return -1; }
__attribute__((weak)) int _read(int fd, void *buf, size_t cnt) { (void)fd; (void)buf; (void)cnt; return -1; }
__attribute__((weak)) int _write(int fd, const void *buf, size_t cnt) { (void)fd; (void)buf; (void)cnt; return -1; }
