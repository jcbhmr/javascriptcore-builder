#!/usr/bin/env bash
# Inspired by https://github.com/adriancooney/Taskfile
set -e
if [[ -n $DEBUG ]]; then set -x; fi

setup() (
    cd WebKit
    if [[ $(uname -s) == "Linux" ]]; then
        if [[ $(lsb_release -is) == "Ubuntu" ]]; then
            sudo apt install libicu-dev python ruby bison flex cmake build-essential ninja-build git gperf
            sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
        else
            echo dunno
            exit 1
        fi
    elif [[ $(uname -s) == "Darwin" ]]; then
        echo dunno
        exit 1
    elif [  "$OS" = "Windows_NT" ]; then
        echo dunno
        exit 1
    else
        echo dunno
        exit 1
    fi
)

build() (
    cd WebKit
    CC=clang-18 CXX=clang++-18 Tools/Scripts/build-webkit --jsc-only
    ln -sf "$PWD"/WebKitBuild/JSCOnly/Release "$(cd .. && pwd)/dist"
)

$@