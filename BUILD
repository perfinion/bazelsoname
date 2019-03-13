
config_setting(
    name = "macos",
    values = {
        "cpu": "darwin",
    },
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "libbar.so.1.13.0",
    srcs = [
        "bar.c",
    ],
    linkshared = 1,
    linkopts = select({
        ":macos": ["-Wl,-install_name,@rpath/libbar.so.1"],
        "//conditions:default": ["-Wl,-soname,libbar.so.1"],
    })
)

genrule(
    name = "libbar.so.1_sym",
    outs = ["libbar.so.1"],
    srcs = ["libbar.so.1.13.0"],
    output_to_bindir = 1,
    cmd = "ln -sf $$(basename $<) $@",
)

genrule(
    name = "libbar.so_sym",
    outs = ["libbar.so"],
    srcs = ["libbar.so.1"],
    output_to_bindir = 1,
    cmd = "ln -sf $$(basename $<) $@",
)


cc_binary(
    name = "libfoo.so.1.13.0",
    srcs = [
        "foo.c",
        "bar.h",
    ],
    copts = ["-I."],
    linkshared = 1,
    linkopts = select({
        ":macos": ["-Wl,-install_name,@rpath/libfoo.so.1"],
        "//conditions:default": ["-Wl,-soname,libfoo.so.1"],
    })
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
        ":libbar.so.1",
    ],
    copts = ["-I."],
    deps = [
        ":libfoo.so.1.13.0",
    ],
)
