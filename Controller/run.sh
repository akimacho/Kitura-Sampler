#!/usr/bin/env sh
swift build
make && ./.build/debug/Controller
