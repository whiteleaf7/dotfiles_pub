
# ex.)
# touchp test/a.txt
# touchp test/{a,b}.txt
touchp() {
    for i in "$@"
    do
        mkdir -p $(dirname "$i")
        touch "$i"
    done
}
