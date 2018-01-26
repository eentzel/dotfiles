#!/usr/bin/env bash

## example of timing different functions to see which is faster

t () {
    local name=$1; shift
    local start=$(date +%s%N)
    $@ > /dev/null
    local end=$(date +%s%N)
    local delta=$((($end-$start)/1000000))
    printf "%s: %sms\n" $name $delta
}

# 1500659238656871000 - 1500659206268616000 = 32s
current () {
    rm -f outputs/*
    echo current
    date +%s%N
    for f in sparkleformation/templates/*; do f=${f##*/}; make outputs/${f%%.*}.json; done
    date +%s%N
}

# 1500659271755790000 - 1500659238667723000 = 33s
xargs_plain () {
    rm -f outputs/*
    echo xargs_plain
    date +%s%N
    find sparkleformation/templates -type f -name '*.rb' \
        | sed -e 's,^sparkleformation/templates/,,' -e 's,.rb$,,' \
        | xargs -I{} make outputs/{}.json
    date +%s%N
}

#  1500659495616368000 - 1500659480480870000 = 15s
xargs_par () {
    rm -f outputs/*
    echo xargs_par
    date +%s%N
    find sparkleformation/templates -type f -name '*.rb' \
        | sed -e 's,^sparkleformation/templates/,,' -e 's,.rb$,,' \
        | xargs -P6 -I{} make outputs/{}.json

    date +%s%N
}

# 1500659509204333000 - 1500659495625506000= 13s
make_par () {
    rm -f outputs/*
    echo make_par
    date +%s%N
    find sparkleformation/templates -type f -name '*.rb' \
        | sed -e 's,^sparkleformation/templates/,outputs/,' -e 's,.rb$,.json,' \
        | xargs make -j6
    date +%s%N
}

# 1500659521492552000 - 1500659509215177000 = 12s
gefu () {
    rm -f outputs/*
    echo gefu
    date +%s%N
    for f in sparkleformation/templates/*; do
        f=${f##*/}
        make outputs/${f%%.*}.json &
    done
    wait
    date +%s%N
}

t current current
t xargs_plain xargs_plain
t xargs_par xargs_par
t make_par make_par
t gefu gefu
