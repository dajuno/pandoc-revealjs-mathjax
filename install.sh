#!/bin/bash
set -e

cwd=$(pwd)
echo "Current working dir: $cwd"
tmpdir=$(mktemp -d)
echo "Created temp dir: $tmpdir"
echo "Change to $tmpdir"
cd $tmpdir
echo "$tmpdir: download reveal.js"
wget -q https://github.com/hakimel/reveal.js/archive/master.zip
echo "$tmpdir: download pandoc reveal.js template"
wget -q https://raw.githubusercontent.com/jgm/pandoc-templates/bc7a16b590122a2dc99d1f17f222b72152acc1e7/default.revealjs
echo "$tmpdir: download mathjax3 patch for pandoc reveal.js template"
wget -q https://raw.githubusercontent.com/dajuno/pandoc-revealjs-mathjax/main/mathjax3.patch
echo "$tmpdir: apply patch"
patch -p0 < mathjax3.patch
echo "Change to $cwd"
cd $cwd
echo "Write pandoc reveal.js template to ./template.md"
mv $tmpdir/default.revealjs template.md
echo "Extract reveal.js-master"
unzip $tmpdir/master.zip
echo "Install mathjax3 via node"
npm install mathjax@3
echo "Remove $tmpdir"
rm -r $tmpdir/master.zip $tmpdir/mathjax3.patch
rmdir $tmpdir
echo "Done"
