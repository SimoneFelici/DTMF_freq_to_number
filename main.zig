const std = @import("std");
const stdout = std.io.getStdOut().writer();
const cwd = std.fs.cwd();

pub fn main() !void {
    var buf: [1024]u8 = undefined;
    const filename = "dtmf.txt";
    const result = try std.fs.cwd().readFile(filename, &buf);
    var frequency: u32 = 0;
    var i: usize = 0;
    var a: usize = 0;
    var decoded_chars: [1024]u8 = undefined;
    var decoded_count: usize = 0;

    while (i < result.len) : (i+=1) {
        const char = result[i];
        frequency = frequency * 10 + (char - '0');
        a +=1;
        if (a == 4) {
            const out: u8 = switch (frequency) {
                1906 => '1',
                2033 => '2',
                2174 => '3',
                2330 => 'A',
                1979 => '4',
                2106 => '5',
                2247 => '6',
                2403 => 'B',
                2061 => '7',
                2188 => '8',
                2329 => '9',
                2485 => 'C',
                2150 => '*',
                2277 => '0',
                2418 => '#',
                2574 => 'D',
                else => '?', 
            };
            decoded_chars[decoded_count] = out;
            decoded_count += 1;
            a = 0;
            frequency = 0;
        }
    }
    i = 0;
    while (i < decoded_count) : (i += 1) {
        const number:u8 = decoded_chars[i];
        try stdout.print("{c}", .{number});
    }
    try stdout.print("\n", .{});
}
