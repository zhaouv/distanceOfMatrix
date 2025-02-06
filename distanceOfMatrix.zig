const std = @import("std");
const Allocator = std.mem.Allocator;
const stdout = std.io.getStdOut().writer();

const mt = [4]i32{ 1, 1, 0, 1 };
const mts = [4]i32{ 1, 0, 1, 1 };
const matrices = [2][4]i32{ mt, mts };

fn multiply(a: []const i32, b: []const i32, mod: i32, r: []i32) void {
    const x1 = (a[0] + a[3]) * (b[0] + b[3]);
    const x2 = (a[2] + a[3]) * b[0];
    const x3 = a[0] * (b[1] - b[3]);
    const x4 = a[3] * (b[2] - b[0]);
    const x5 = (a[0] + a[1]) * b[3];
    const x6 = (a[2] - a[0]) * (b[0] + b[1]);
    const x7 = (a[1] - a[3]) * (b[2] + b[3]);

    r[0] = @mod(x1 + x4 - x5 + x7, mod);
    r[1] = @mod(x3 + x5, mod);
    r[2] = @mod(x2 + x4, mod);
    r[3] = @mod(x1 + x3 - x2 + x6, mod);
}

fn backtrack(t: usize, mod: i32, wlength: usize, x: []i32, ce: [][]i32, found: *bool) void {
    if (found.*) return;

    if (t >= wlength) {
        const e = ce[ce.len - 1];
        const cond1 = e[0] == 1 and e[1] == 0 and e[2] == 0 and e[3] == 1;
        const cond2 = e[0] == mod - 1 and e[1] == 0 and e[2] == 0 and e[3] == mod - 1;
        if (cond1 or cond2) found.* = true;
        return;
    }

    for (0..2) |i| {
        x[t] = @intCast(i);
        const mi = matrices[i][0..];

        if (t == 0) {
            @memcpy(ce[t], mi);
        } else {
            multiply(mi, ce[t - 1], mod, ce[t]);
        }

        backtrack(t + 1, mod, wlength, x, ce, found);
        if (found.*) return;
    }
}

fn processMod(mod: i32, allocator: Allocator) !void {
    try stdout.print("\n{d}\n", .{mod});
    var wlength: usize = 0;

    while (true) {
        wlength += 1;
        const x = try allocator.alloc(i32, wlength);
        defer allocator.free(x);

        var ce = try allocator.alloc([]i32, wlength);
        defer {
            for (ce) |item| allocator.free(item);
            allocator.free(ce);
        }

        for (ce) |*item| {
            item.* = try allocator.alloc(i32, 4);
        }

        var found = false;
        backtrack(0, mod, wlength, x, ce, &found);

        if (found and wlength < mod) {
            try stdout.print("length: {d}\n[", .{wlength});
            for (x, 0..) |val, i| {
                try stdout.print("{d}{s}", .{ val, if (i == x.len - 1) "" else "," });
            }
            try stdout.writeAll("]\n[");

            for (ce, 0..) |item, i| {
                try stdout.print("[[{d},{d}],[{d},{d}]]{s}", .{
                    item[0], item[1],
                    item[2], item[3],
                    if (i == ce.len - 1) "" else ",\n"
                });
            }
            try stdout.writeAll("]\n");
            break;
        }

        if (found) break;
    }
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    var start: usize = 400;
    var end: usize = 405;

    var args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len >= 3) {
        start = try std.fmt.parseInt(usize, args[1], 10);
        end = try std.fmt.parseInt(usize, args[2], 10);
    }

    for (start..end) |i| {
        try processMod(@intCast(i), allocator);
    }
}