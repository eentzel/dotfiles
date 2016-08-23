#! /bin/sh

# Prints dependency graph of a project

echo "digraph {"

file_to_class() {
    echo $1 | grep -Eo '[^/]+$' | cut -d. -f1
}

find . -name \*.java -o -name \*.groovy -type f | grep -vF /test/ | while read file; do
    echo $file >&2
    class=`file_to_class $file`
    find . -name \*.java -o -name \*.groovy -type f | grep -vF /test/ | while read sf; do
        other=`file_to_class $sf`
        if test $class != $other && grep -E '\b'$class'\b' $sf >/dev/null; then
            echo "$other -> $class;"
        fi
    done
done

echo "}"
