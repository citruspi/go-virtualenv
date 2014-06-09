#!/usr/bin/sh

# A simple script to emulate Python's virtual environments for Go's workspaces.
# Virtual environments are created in $HOME/.go-virtualenvs

# Usage:
#
# go-mkvirtualenv <name> (Creates a new virtualenv and activates it)
# go-workon <name>     (Activates a virtualenv by exporting the GOPATH variable)
# go-deactivate        (Deactivates a virtualenv by exporting the default GOPATH variable)

# Copyright © 2014 Mihir Singh <me@mihirsingh.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the “Software”), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY
# KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
# PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

func go-mkvirtualenv () {
    if [ ! -d "$HOME/.go-virtualenvs/$1" ]; then
        mkdir -p $HOME/.go-virtualenvs/$1/{src,pkg,bin}
        go-workon $1
    fi
}

func go-workon () {
    if [ -d "$HOME/.go-virtualenvs/$1" ]; then
        export OLD_GOPATH="$GOPATH"
        export GOPATH="$HOME/.go-virtualenvs/$1"
        export OLD_PS1="$PS1"
        export PS1="($1) $PS1"
    fi
}

func go-deactivate () {
    export PS1="$OLD_PS1"
    unset OLD_PS1
    export GOPATH="$OLD_GOPATH"
    unset OLD_GOPATH
}
