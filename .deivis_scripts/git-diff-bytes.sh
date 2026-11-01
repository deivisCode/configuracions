#!/bin/bash
USAGE='[<rev-list-options>...]

Show file size changes between two commits or the index and a commit.'

SUBDIRECTORY_OK=1
. "$(git --exec-path)/git-sh-setup"
args=$(git rev-parse --sq "$@")
[ -n "$args" ] || usage
eval "git diff-tree -r $args" | {
    total=0
    total_abs=0
    while read A B C D M P
    do
        case $M in
            M) bytes=$(( $(git cat-file -s $D) - $(git cat-file -s $C) )) ;;
            A) bytes=$(git cat-file -s $D) ;;
            D) bytes=-$(git cat-file -s $C) ;;
            "")
                echo >&2 "warning: probably should use \"<rev>..[.][other rev]\"\n"
                continue
                ;;
            *)
                echo >&2 "warning: unhandled mode [$M] in \"$A $B $C $D $M $P\"\n"
                continue
                ;;
        esac
        total=$(( $total + $bytes ))
        total_abs=$(( $total_abs + ${bytes#-} ))
        printf '%+10s %+10s %s\n' $bytes ${bytes#-} "$P"
    done
    echo "     NETO^      ABST^"
    total="$(echo $total | awk '{printf ("%3.3f KiB", ( $1 / 1024) )}')"
    total_abs="$(echo $total_abs | awk '{printf ("%3.3f KiB", ( $1 / 1024) )}')"
    echo "\nTotal neto: $total"
    echo "Total abst: $total_abs"

}
