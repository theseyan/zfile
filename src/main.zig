const std = @import("std");
const cli = @import("cli.zig");

const MAX_FILENAME_LENGTH = 256;
const MAX_BYTES_TO_READ = 2 * 1024; // 2KB buffer to read file

// Initialize main allocator
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
var arena = std.heap.ArenaAllocator.init(gpa.allocator());
var allocator = arena.allocator();

pub fn main() !void {
    
    // Free all memory when main exits
    defer arena.deinit();

    // Initialize CLI
    try cli.init(allocator);

}
