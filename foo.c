#include <stdio.h>
#include <bar.h>

void foo(void)
{
    puts("Hello, I'm a shared library");
}

void foobar(void)
{
    puts("foobar");
    bar();
}

