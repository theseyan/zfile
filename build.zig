const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // zig-clap module
    const clap_module = b.createModule(.{ .source_file = .{
        .path = "deps/zig-clap/clap.zig",
    } });

    const exe = b.addExecutable(.{
        .name = "zfile",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    // Add modules
    exe.addModule("zig-clap", clap_module);

    b.installArtifact(exe);
}
