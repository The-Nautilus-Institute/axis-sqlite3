#!/bin/bash

shopt -s nocasematch

function assert_sqlite3_hex_eq {
  local expression="$1"
  local expected="$2"
  local actual=$(./sqlite3 :memory: "select hex($expression);")

  if [[ $actual == $expected ]]; then
    echo "PASS: $expression = $expected"
    return 0
  else
    echo "FAIL: $expression"
    echo "  Expected: $expected"
    echo "  Actual:   $actual"
    exit 1
  fi
}

assert_sqlite3_hex_eq "sha224('abc')" \
  "23097D223405D8228642A477BDA255B32AADBCE4BDA0B3F7E36C9DA7"
assert_sqlite3_hex_eq "sha256('abc')" \
  "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
assert_sqlite3_hex_eq "sha384('abc')" \
  "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7"
assert_sqlite3_hex_eq "sha512('abc')" \
  "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f"

assert_sqlite3_hex_eq "sha224('abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq')" \
  "75388b16512776cc5dba5da1fd890150b0c6455cb4f58b1952522525"
assert_sqlite3_hex_eq "sha256('abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq')" \
  "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1"

assert_sqlite3_hex_eq "sha384('abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu')" \
  "09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039"
assert_sqlite3_hex_eq "sha512('abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu')" \
  "8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909"