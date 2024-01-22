# Local RevealJS/MathJax3 setup for pandoc

## Requirements

- `pandoc` is installed

## Installation and configuration:

1. Download and extract https://github.com/hakimel/reveal.js/archive/master.zip
   ```
   wget https://github.com/hakimel/reveal.js/archive/master.zip
   unzip master.zip
   ```
   (Will unzip revealjs to folder `reveal.js-master`.)
2. Install mathjax:
  ```shell
  npm install mathjax@3
  ```
3. Configure pandoc revealjs template for MathJax3:
   - Step by step:
       - download https://github.com/jgm/pandoc-templates/blob/master/default.revealjs
       - add in `$if(mathjax)$ ... $endif$` enclosing:
         
         ```js
         mathjax3: {
           mathjax: '$mathjaxurl$',
           tex: {
             inlineMath: [[ '$$', '$$' ], [ '\\(', '\\)' ]]
           },
           options: {
             skipHtmlTags: [ 'script', 'noscript', 'style', 'textarea', 'pre' ]
           },
         },
         ```
         (note the double `$` signs in contrast to the [revealjs documentation](https://revealjs.com/math/#mathjax-3-4.2.0))
         and replace `RevealMath` plugin by `RevealMath.MathJax3` in `plugins: [...]` list.

         (As of 2024-01-22, the `default.revealjs` file seems to be set up for MathJax2.)
   - Automatic via patch (works with https://github.com/jgm/pandoc-templates/blob/bc7a16b590122a2dc99d1f17f222b72152acc1e7/default.revealjs): 

     ```shell
     wget https://raw.githubusercontent.com/jgm/pandoc-templates/master/default.revealjs
     patch -p0 < mathjax3.patch
     mv default.revealjs template.md
     ```
     
   - Example: see [`template.md`](https://github.com/dajuno/pandoc-revealjs-mathjax/blob/main/template.md) file of this repository
4. Set `mathjaxurl` in the header of the presentation markdown file:
  - `mathjaxurl: node_modules/mathjax/es5/tex-mml-chtml.js` for the local installation
  - `mathjaxurl:  /usr/share/mathjax/tex-mml-chtml.js` or similar for a (possible)
    system package
  - `mathjaxurl: https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js` for the CDN package (works only with an internet connection; default when `mathjaxurl` is not specified)

## Compilation with pandoc

Assuming, the `revealjs` and `node_modules` folders, pandoc template (modified `default.revealjs`, renamed `template.md`) and presentation markdown file (`pres.md`) are all located in the current path:

```shell
pandoc -s --mathjax -i -t revealjs pres.md -template=template.md -V center=false -V history=false -V revealjs-url=reveal.js-master -o pres.html
```
