// 使用 ReleaseFast 模式编译以禁用安全检查并优化速度
// zig build-exe -O ReleaseFast main.zig

const std = @import("std");

const M = [2][4]u32{
    [4]u32{ 1, 1, 0, 1 },
    [4]u32{ 1, 0, 1, 1 },
};

fn multiply(a: [4]u32, b: [4]u32, mod_val: u32) [4]u32 {
    const x1 = (a[0] + a[3]) * (b[0] + b[3]);
    const x2 = (a[2] + a[3]) * b[0];
    const x3 = a[0] * (b[1] - b[3]);
    const x4 = a[3] * (b[2] - b[0]);
    const x5 = (a[0] + a[1]) * b[3];
    const x6 = (a[2] - a[0]) * (b[0] + b[1]);
    const x7 = (a[1] - a[3]) * (b[2] + b[3]);
    const c11 = (x1 + x4 - x5 + x7) % mod_val;
    const c12 = (x3 + x5) % mod_val;
    const c21 = (x2 + x4) % mod_val;
    const c22 = (x1 + x3 - x2 + x6) % mod_val;
    return [4]u32{ c11, c12, c21, c22 };
}

fn backtrack(t: usize, mod_val: u32, wlength: u32, ce: *[100][4]u32, x: *[100]u32) bool {
    if (t >= @as(usize, @intCast(wlength))) {
        const e = ce.*[t - 1];
        return (e[0] == 1 and e[1] == 0 and e[2] == 0 and e[3] == 1) or
               (e[0] == mod_val - 1 and e[1] == 0 and e[2] == 0 and e[3] == mod_val - 1);
    } else {
        inline for (0..2) |i| {
            x.*[t] = @as(u32, @intCast(i));
            if (t == 0) {
                ce.*[t] = M[i];
            } else {
                ce.*[t] = multiply(M[i], ce.*[t - 1], mod_val);
            }
            if (backtrack(t + 1, mod_val, wlength, ce, x)) {
                return true;
            }
        }
        return false;
    }
}

fn process(mod_val: u32) void {
    std.debug.print("\n{d}\n", .{mod_val});
    var wlength: u32 = 0;
    while (true) {
        wlength += 1;
        var x: [100]u32 = undefined;
        var ce: [100][4]u32 = undefined;
        if (backtrack(0, mod_val, wlength, &ce, &x)) {
            if (wlength < mod_val) {
                std.debug.print("length: {d}\n[", .{wlength});
                for (0..@as(usize, @intCast(wlength))) |ii| {
                    std.debug.print("{d}", .{x[ii]});
                    if (ii != @as(usize, @intCast(wlength)) - 1) std.debug.print(",", .{});
                }
                std.debug.print("]\n[", .{});
                for (0..@as(usize, @intCast(wlength))) |ii| {
                    const e = ce[ii];
                    std.debug.print("[[{d},{d}],[{d},{d}]]", .{ e[0], e[1], e[2], e[3] });
                    if (ii != @as(usize, @intCast(wlength)) - 1) std.debug.print(",\n", .{});
                }
                std.debug.print("]\n", .{});
            }
            break;
        }
    }
}

pub fn main() void {
    var start: u32 = 400;
    var end: u32 = 405;
    const args = std.process.argsAlloc(std.heap.page_allocator) catch @panic("args alloc");
    defer std.process.argsFree(std.heap.page_allocator, args);
    if (args.len >= 3) {
        start = std.fmt.parseInt(u32, args[1], 10) catch @panic("invalid start");
        end = std.fmt.parseInt(u32, args[2], 10) catch @panic("invalid end");
    }
    var i = start;
    while (i < end) : (i += 1) {
        process(i);
    }
}
