#! /bin/sh

echo "digraph {"
echo "ratio=1.0"

file_to_class() {
    echo $1 | grep -Eo '[^/]+$' | cut -d. -f1
}

find . -name \*.java -o -name \*.groovy -type f | grep -vF /test/ | while read file; do
    echo $file >&2
    class=`file_to_class $file`

    # weakness: breaks if extends/implements is on a different line than `class`
    classLine=`grep -E "(class|interface) +$class\b" $file`
    extends=`echo $classLine | grep -E -o "extends +\w+" | sed -E 's/extends +//'`
    implements=`echo $classLine | grep -E -o "implements +\w+" | sed -E 's/implements +//'`

    test -z "$extends" || echo "${extends} -> $class"
    test -z "$implements" || echo "$implements -> $class [style=dotted]"
done

echo "}"
