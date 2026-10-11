#!/bin/sh
ROOT=/work
for f in $(find . -name '*-fr.rc'); do
  d=$(dirname "$f"); b=$(basename "$f" .rc)
  (cd "$d" && i686-w64-mingw32-windres -I"$ROOT/common" -I. "$b.rc" -O res -o "$b.res") && echo "OK $f"
done