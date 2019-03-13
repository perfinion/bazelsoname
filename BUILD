
config_setting(
    name = "macos",
    values = {
        "cpu": "darwin",
    },
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "libbar.1.13.0.dylib",
    srcs = [
        "bar.c",
    ],
    linkshared = 1,
    linkopts = select({
        ":macos": ["-Wl,-install_name,@rpath/libbar.1.dylib"],
        "//conditions:default": ["-Wl,-soname,libbar.so.1"],
    })
)

genrule(
    name = "libbar.so.1_sym",
    outs = ["libbar.1.dylib"],
    srcs = ["libbar.1.13.0.dylib"],
    output_to_bindir = 1,
    cmd = "ln -sf $$(basename $<) $@",
)

genrule(
    name = "libbar.so_sym",
    outs = ["libbar.dylib"],
    srcs = ["libbar.1.dylib"],
    output_to_bindir = 1,
    cmd = "ln -sf $$(basename $<) $@",
)


cc_binary(
    name = "libfoo.1.13.0.dylib",
    srcs = [
        "foo.c",
        "bar.h",
    ],
    copts = ["-I."],
    linkshared = 1,
    linkopts = select({
        ":macos": ["-Wl,-install_name,@rpath/libfoo.1.dylib"],
        "//conditions:default": ["-Wl,-soname,libfoo.so.1"],
    })
)

genrule(
    name = "libfoo.so.1_sym",
    outs = ["libfoo.1.dylib"],
    srcs = ["libfoo.1.13.0.dylib"],
    output_to_bindir = 1,
    cmd = "ln -sf $$(basename $<) $@",
)

genrule(
    name = "libfoo.so_sym",
    outs = ["libfoo.dylib"],
    srcs = ["libfoo.1.dylib"],
    output_to_bindir = 1,
    cmd = "ln -sf $$(basename $<) $@",
)

cc_binary(
    name = "main",
    srcs = [
        "main.c",
        "foo.h",
        ":libfoo.1.dylib",
        ":libbar.1.dylib",
    ],
    copts = ["-I."],
    deps = [
        ":libfoo.1.13.0.dylib",
    ],
)
