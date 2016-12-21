#!/usr/bin/expect
while {1} {
  spawn "./test.sh"
  expect "Password:" { send "XXXX\r" }
  sleep 1
}
