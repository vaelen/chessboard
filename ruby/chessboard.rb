#!/usr/bin/env ruby

### Board Size

board_size = 8

### Data

moves = {
  :queen => [
    { :x=>  1, :y=>  1, :times => 8},
    { :x=>  1, :y=>  0, :times => 8},
    { :x=>  1, :y=> -1, :times => 8},
    { :x=> -1, :y=>  1, :times => 8},
    { :x=> -1, :y=>  0, :times => 8},
    { :x=> -1, :y=> -1, :times => 8},
    { :x=>  0, :y=>  1, :times => 8},
    { :x=>  0, :y=> -1, :times => 8}
  ],
  :rook => [
    { :x=>  1, :y=>  0, :times => 8},
    { :x=> -1, :y=>  0, :times => 8},
    { :x=>  0, :y=>  1, :times => 8},
    { :x=>  0, :y=> -1, :times => 8}
  ],
  :bishop => [
    { :x=>  1, :y=>  1, :times => 8},
    { :x=>  1, :y=> -1, :times => 8},
    { :x=> -1, :y=>  1, :times => 8},
    { :x=> -1, :y=> -1, :times => 8},
  ],
  :knight => [
    { :x=>  2, :y=>  3, :times => 1},
    { :x=>  3, :y=>  2, :times => 1},
    { :x=>  2, :y=> -3, :times => 1},
    { :x=>  3, :y=> -2, :times => 1},
    { :x=> -2, :y=>  3, :times => 1},
    { :x=> -3, :y=>  2, :times => 1},
    { :x=> -2, :y=> -3, :times => 1},
    { :x=> -3, :y=> -2, :times => 1}
  ],
}

### Parse Arguments

if (ARGV.length < 2)
  puts "Usage: chessboard.rb <piece> <position>"
  exit 1
end

piece = ARGV[0].downcase.to_sym

if (!moves.has_key?(piece))
  puts "Invalid piece: #{ARGV[0]}"
  exit 1
end

pos_string = ARGV[1].downcase

pos_parts = pos_string.split(//)
x = pos_parts[0].codepoints[0] - 96 # "a" == 97 in ASCII / Unicode
y = pos_parts[1].to_i

if (pos_string.length != 2 || x < 1 || x > board_size || y < 1 || y > board_size )
  puts "Invalid position: #{ARGV[1]}"
  exit 1
end

### Calculate possible positions

possible_moves = moves[piece].collect { | move |
  (1..move[:times]).collect { |distance|
    new_x = x + (move[:x] * distance)
    new_y = y + (move[:y] * distance)
    [new_x, new_y]
  }
}.flatten(1).sort { |m1,m2|
  c = (m1[0] <=> m2[0])
  c == 0 ? (m1[1] <=> m2[1]) : c
}

### Remove invalid moves

valid_moves = possible_moves.reject { |m| m[0] < 1 || m[0] > board_size || m[1] < 1 || m[1] > board_size }

### Output results

puts valid_moves.collect { |m|
  x = (m[0] + 96).chr
  y = m[1]
  "#{x}#{y}"
}.join(", ")

