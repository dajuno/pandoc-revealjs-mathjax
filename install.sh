#!/bin/bash
set -e

cwd=$(pwd)
echo "Current working dir: $cwd"
tmpdir=$(mktemp -d)
echo "Creating temp dir: $tmpdir"
cd $tmpdir
wget https://github.com/hakimel/reveal.js/archive/master.zip
wget https://raw.githubusercontent.com/jgm/pandoc-templates/bc7a16b590122a2dc99d1f17f222b72152acc1e7/default.revealjs
wget https://raw.githubusercontent.com/dajuno/pandoc-revealjs-mathjax/main/mathjax3.patch
patch -p0 < mathjax3.patch
mv default.revealjs $cwd/template.md
cd $cwd
unzip $tmpdir/master.zip
npm install mathjax@3

echo "Done"
