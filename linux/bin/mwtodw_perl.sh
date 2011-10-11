#! /bin/sh
# Mediawiki2Dokuwiki Converter
# originally by Johannes Buchner <buchner.johannes [at] gmx.at>
# Licence: GPL (http://www.gnu.org/licenses/gpl.txt)
 
# Headings
cat mediawiki | \
   perl -pe 's/^[ ]*=([^=])/<h1> ${1}/g' | \
   perl -pe 's/([^=])=[ ]*$/${1} <\/h1>/g' | \
   perl -pe 's/^[ ]*==([^=])/<h2> ${1}/g' | \
   perl -pe 's/([^=])==[ ]*$/${1} <\/h2>/g' | \
   perl -pe 's/^[ ]*===([^=])/<h3> ${1}/g' | \
   perl -pe 's/([^=])===[ ]*$/${1} <\/h3>/g' | \
   perl -pe 's/^[ ]*====([^=])/<h4> ${1}/g' | \
   perl -pe 's/([^=])====[ ]*$/${1} <\/h4>/g' | \
   perl -pe 's/^[ ]*=====([^=])/<h5> ${1}/g' | \
   perl -pe 's/([^=])=====[ ]*$/${1} <\/h5>/g' | \
   perl -pe 's/^[ ]*======([^=])/<h6> ${1}/g' | \
   perl -pe 's/([^=])======[ ]*$/${1} <\/h6>/g' \
    > mediawiki1
 
cat mediawiki1 | \
   perl -pe 's/<\/?h1>/======/g' | \
   perl -pe 's/<\/?h2>/=====/g' | \
   perl -pe 's/<\/?h3>/====/g' | \
   perl -pe 's/<\/?h4>/===/g' | \
   perl -pe 's/<\/?h5>/==/g' | \
   perl -pe 's/<\/?h6>/=/g' | \
   cat > mediawiki2
 
# lists
cat mediawiki2 |
  perl -pe 's/^[\*#]{4}\*/          * /g'  | \
  perl -pe 's/^[\*#]{3}\*/        * /g'    | \
  perl -pe 's/^[\*#]{2}\*/      * /g'      | \
  perl -pe 's/^[\*#]{1}\*/    * /g'        | \
  perl -pe 's/^\*/  * /g'                  | \
  perl -pe 's/^[\*#]{4}#/          \- /g'  | \
  perl -pe 's/^[\*\#]{3}\#/      \- /g'    | \
  perl -pe 's/^[\*\#]{2}\#/    \- /g'      | \
  perl -pe 's/^[\*\#]{1}\#/  \- /g'        | \
  perl -pe 's/^\#/  - /g'                  | \
  cat > mediawiki3
 
#[link] => [[link]]
cat mediawiki3 |
  perl -pe 's/([^\[])\[([^\[])/${1}[[${2}/g' |
  perl -pe 's/^\[([^\[])/[[${1}/g' |
  perl -pe 's/([^\]])\]([^\]])/${1}]]${2}/g' |
  perl -pe 's/([^\]])\]$/${1}]]/g' \
  > mediawiki4
 
#[[url text]] => [[url|text]]
cat mediawiki4 |
  perl -pe 's/(\[\[[^| \]]*) ([^|\]]*\]\])/${1}|${2}/g' \
  > mediawiki5
 
# bold, italic
cat mediawiki5 |
  perl -pe "s/'''/**/g" |
  perl -pe "s/''/\/\//g" \
  > mediawiki6
 
# talks
cat mediawiki6 |
  perl -pe "s/^[ ]*:/>/g" |
  perl -pe "s/>:/>>/g" |
  perl -pe "s/>>:/>>>/g" |
  perl -pe "s/>>>:/>>>>/g" |
  perl -pe "s/>>>>:/>>>>>/g" |
  perl -pe "s/>>>>>:/>>>>>>/g" |
  perl -pe "s/>>>>>>:/>>>>>>>/g" \
  > mediawiki7
 
cat mediawiki7 |
  perl -pe "s/<pre>/<code>/g" |
  perl -pe "s/<\/pre>/<\/code>/g" \
  > mediawiki8
 
cat mediawiki8 > dokuwiki