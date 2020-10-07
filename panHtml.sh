echo "Processing $1"

pandoc \
   --to html5+smart \
   --toc \
   --section-divs \
   --from markdown+tex_math_single_backslash \
   --css=./pandoc-github.css \
   --mathjax="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML" \
   --standalone \
   -o $2 $1
   #--csl=chicago-fullnote-bibliography.csl \
   #--bibliography=${HOME}/share/bib/bib.bib \
   #--metadata suppress-bibliography=true \
   #--template=$HOME/share/tufte-pandoc-css/tufte.html5 \
   #--css=../assets/tufte-extra.css \
   #--css=../assets/pandoc.css \
   #--css=../assets/pandoc-solarized.css \
   #--metadata author="Devendra Ghate" \
   #--metadata date="$(date +'%d/%m/%Y')" \
   #--filter abp \
   #--filter pandoc-crossref \
   #--include-before-body=$1 \
   #--katex \
