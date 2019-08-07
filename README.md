# ulid
Universally Unique Lexicographically Sortable Identifier implementation for Elixir

<h1 align="center">
	<br>
	<br>
	<img width="360" src="logo.png" alt="ulid">
	<br>
	<br>
	<br>
</h1>

[![Gem Downloads](http://img.shields.io/gem/dt/ulid.svg)](https://rubygems.org/gems/ulid)
[![GitHub License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/rafaelsales/ulid)

# Universally Unique Lexicographically Sortable Identifier

UUID can be suboptimal for many uses-cases because:

- It isn't the most character efficient way of encoding 128 bits of randomness
- The string format itself is apparently based on the original MAC & time version (UUIDv1 from Wikipedia)
- It provides no other information than randomness

Instead, herein is proposed ULID:

- 128-bit compatibility with UUID
- 1.21e+24 unique ULIDs per millisecond
- Lexicographically sortable!
- Canonically encoded as a 26 character string, as opposed to the 36 character UUID
- Uses Crockford's base32 for better efficiency and readability (5 bits per character)
- Case insensitive
- No special characters (URL safe)

### Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `ulid` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ulid, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ulid` is started before your application:

    ```elixir
    def application do
      [applications: [:ulid]]
    end
    ```

### Usage

```elixir
Ulid.generate # 01ARZ3NDEKTSV4RRFFQ69G5FAV
```

## Specification

Below is the current specification of ULID as implemented in this repository. *Note: the binary format has not been implemented.*

```
 01AN4Z07BY      79KA1307SR9X4MV3

|----------|    |----------------|
 Timestamp          Randomness
  10 chars           16 chars
   48bits             80bits
   base32             base32
```

### Components

**Timestamp**
- 48 bit integer
- UNIX-time in milliseconds
- Won't run out of space till the year 10895 AD.

**Randomness**
- 80 bits
- Cryptographically secure source of randomness, if possible

### Sorting

The left-most character must be sorted first, and the right-most character sorted last. The default ASCII order is used for sorting.

### Binary Layout and Byte Order

The components are encoded as 16 octets. Each component is encoded with the Most Significant Byte first (network byte order).

```
0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                      32_bit_uint_time_high                    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|     16_bit_uint_time_low      |       16_bit_uint_random      |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                       32_bit_uint_random                      |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                       32_bit_uint_random                      |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

### String Representation

```
ttttttttttrrrrrrrrrrrrrrrr

where
t is Timestamp
r is Randomness
```

## Test Suite

```sh
mix test
```

### Benchmarking

To run the benchmarks yourself, just do the following

```sh
mix run bench/ulid_bench.exs
```

```
Operating System: Linux
CPU Information: Intel(R) Xeon(R) CPU E5-2630 v2 @ 2.60GHz
Number of Available Cores: 24
Available memory: 62.92 GB
Elixir 1.8.2
Erlang 22.0.7

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
parallel: 1
inputs: none specified
Estimated total run time: 14 s

Benchmarking generate...
Benchmarking generate_binary...

Name                      ips        average  deviation         median         99th %
generate_binary      484.37 K        2.06 μs  ±1231.73%        1.91 μs        2.75 μs
generate             159.64 K        6.26 μs   ±417.75%        5.56 μs       12.53 μs

Comparison:
generate_binary      484.37 K
generate             159.64 K - 3.03x slower +4.20 μs
```

### Credits and references:

* https://github.com/alizain/ulid
* https://github.com/ulid-org/spec
