#!/usr/bin/env bash

check_files() {
    if git diff --cached --name-only | grep models;
    then
        notify-send "ATTENTION : models modifiés" "Vérifiez si besoin de migrations"
        notify-send "ATTENTION : models modifiés" "Pensez aussi aux contraintes d'unicités dès la création du modèle"
    fi
    if git diff --cached --name-only | grep serializer;
    then
        notify-send "ATTENTION : serializers modifiés" "Les nouveaux preloadings sont interdits -> #Prefetch()"
    fi
    return 0
}

check_no_abusive_trailing_comma() {
    if git diff --cached -r | grep ' = .*,\s*$';
    then
        notify-send "ATTENTION" "Il semblerait que vous affectiez un tuple au lieu d'une autre valeur dans une variable."
        return 1
    fi
    return 0
}

check_black_code_formatting() {
    # attention ça ne marche que sur les fichiers "stagés" avec git add
    files_string=$(git diff --cached --name-only | grep '\.py')
    echo $files_string
    mapfile -t some_files <<< "$files_string"
    my_error=0
    for file in ${some_files[@]};
    do
        echo "Black will check formatting on file $file"
        if ! ~/ReposGit/bin/black --check --diff "$file";
        then 
            my_error=1
        fi
    done
    if [ $my_error -eq '1' ];
    then
        return 1
    fi
    return 0
}

