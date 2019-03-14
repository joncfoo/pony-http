#!/bin/sh

while true; do
  find ./test ./http -type f | entr -dnc make
done
