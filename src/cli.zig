const std = @import("std");
const clap = @import("zig-clap");

const VERSION = "0.1.0";

// Main function
pub fn init(allocator: std.mem.Allocator) !void {
    _ = allocator;

    const paramsString =
        \\-h, --help                Display this help and exit.
        \\-v, --version             Display the version
        \\<str>...                  Path to file
        \\
    ;
    const params = comptime clap.parseParamsComptime(paramsString);

    // Parse arguments
    var diag = clap.Diagnostic{};
    var res = clap.parse(clap.Help, &params, clap.parsers.default, .{
        .diagnostic = &diag,
    }) catch |err| {
        diag.report(std.io.getStdErr().writer(), err) catch {};
        return err;
    };
    defer res.deinit();

    // Help command
    if (res.args.help != 0) {
        const pretext = "Usage: zfile <FILE_PATH>\n\n";
        return std.debug.print(pretext ++ paramsString, .{});
    }

    // Version command
    if (res.args.version != 0)
        std.debug.print("{s}\n", .{VERSION});
}
