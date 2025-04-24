// Weak stubs for syscalls to satisfy newlib when not linking with pico_stdlib
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

__attribute__((weak)) int _fstat(int fd, struct stat *st) { (void)fd; (void)st; return -1; }
__attribute__((weak)) int _isatty(int fd) { (void)fd; return 0; }
__attribute__((weak)) int _kill(int pid, int sig) { (void)pid; (void)sig; return -1; }
__attribute__((weak)) int _getpid(void) { return 1; }
