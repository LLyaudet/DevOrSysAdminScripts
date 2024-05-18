# Encore un gros voyage en absurdie du fait que je ne contrôle pas
# les éléments de base qui constituent mon ordinateur.
# Pas possible de faire du code correct ET d'avoir le résultat attendu
# si quelqu'un d'autre te donne un environnement pourri pour
# exécuter ton code.
a=("a 1" "b 2" "c 3")
# declare -A b I may have forgot to add this line in the file,
# but I do think that I did declare an associative array (a or b)
# in my shell
# when I tested before writing this synthesis of my test.
b=(["a 1"]="c 3" ["b 2"]="b 2" ["c 3"]="a 1")

echo "1)"
for k in "${a[@]}"; do
  echo "$k"
done
# a 1
# b 2
# c 3

echo "2)"
for k in "${b[@]}"; do
  echo "$k"
  echo "-"
  echo "$k ${b[$k]}"
  echo "-"
  echo "$k ${b['$k']}"
done
#

echo "3)"
for k in "${!a[@]}"; do
  echo "$k"
done
# 0
# 1
# 2

echo "4)"
for k in "${!b[@]}"; do
  echo "$k"
  echo "$k ${b[$k]}"
done
#

echo "5)"
for k in ${a[@]}; do
  echo "$k"
done
# a
# 1
# b
# 2
# c
# 3

echo "6)"
for k in ${b[@]}; do
  echo "$k"
  echo "$k ${b[$k]}"
done
#

echo "7)"
for k in ${!a[@]}; do
  echo "$k"
done
# 0
# 1
# 2

echo "8)"
for k in ${!b[@]}; do
  echo "$k"
  echo "$k ${b[$k]}"
done
#

echo "9)"
declare -A c
c=(\
  ["a 1"]="c 3"\
  ["b 2"]="b 2"\
  ["c 3"]="a 1"\
)
for k in "${c[@]}"; do
  echo "$k"
  echo "-"
  echo "$k ${'c[$k']}"
  echo "-"
  echo "$k ${c[$k]}"
done
# bash: a 1 : dépassement du niveau de récursivité dans l'expression (le symbole erroné est « a 1 »)

echo "10)"
for k in "${!c[@]}"; do
  echo "$k"
  echo "$k ${c[$k]}"
done
#

echo "11)"
for k in ${c[@]}; do
  echo "$k"
  echo "$k ${c[$k]}"
done
#

echo "12)"
for k in ${!c[@]}; do
  echo "$k"
  echo "$k ${c[$k]}"
done
#

# Ce code-là marche dans mon repository.
files_to_delete=(\
  "current_tree.txt"
  "current_tree_light.txt"
)
for file_name in "${files_to_delete[@]}"; do
  rm -f "$file_name"
done
# Et ce code-là marche aussi :
subdir="build_and_checks_dependencies"
source "./$subdir/get_common_text_glob_patterns.sh"

check_URLs(){
  get_common_text_files_glob_patterns

  declare -A LFBFL_substitutions
  LFBFL_substitutions=(\
    ["http://www.gnu.org/licenses/"]="https://www.gnu.org/licenses/"\
  )

  for LFBFL_pattern in "${common_file_patterns[@]}"; do
    [ "$1" != "-v" ] || echo "Iterating on pattern: $LFBFL_pattern"
    find . -type f -name "$LFBFL_pattern" -printf '%P\n'\
      | xargs grep -H 'http:'\
      | grep -v "^[^:]*check_URLs.sh:"
    for LFBFL_file_name in $LFBFL_pattern; do
      [ -f "$LFBFL_file_name" ] || continue
      LFBFL_base_file_name=$(basename "$LFBFL_file_name")
      [ "$LFBFL_base_file_name" != "check_URLs.sh" ] || continue
      [ "$1" != "-v" ] || echo "Handling the file: $LFBFL_file_name"
      for LFBFL_substitution in "${!LFBFL_substitutions[@]}"; do #ici
        # ça correspond au cas 10) plus haut.
        LFBFL_substitution2=\
${LFBFL_substitutions[$LFBFL_substitution]}
        if grep -q "$LFBFL_substitution" "$LFBFL_file_name"; then
          sed -i "s|$LFBFL_substitution|$LFBFL_substitution2|g"\
            "$LFBFL_file_name"
        fi
      done
    done
  done
}
