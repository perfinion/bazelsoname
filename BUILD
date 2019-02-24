
cc_binary(
    name = "libfoo.so.1.13.0",
    srcs = [
        "foo.c",
    ],
    linkshared = 1,
    linkopts = ["-Wl,-soname,libfoo.so.1"],
)

genrule(
    name = "libfoo.so.1_sym",
    outs = ["libfoo.so.1"],
    srcs = ["libfoo.so.1.13.0"],
    output_to_bindir = 1,
    cmd = "ln -sf $$(basename $<) $@",
)

genrule(
    name = "libfoo.so_sym",
    outs = ["libfoo.so"],
    srcs = ["libfoo.so.1"],
    output_to_bindir = 1,
    cmd = "ln -sf $$(basename $<) $@",
)

cc_binary(
    name = "main",
    srcs = [
        "main.c",
        "foo.h",
        ":libfoo.so.1",
    ],
    deps = [
        ":libfoo.so.1.13.0",
    ],
)
