#!/bin/sh
file=$1
build_number=$2

if [ ! -e "$file" ]
    then echo "file '$file' is missing" >&2; exit 1
fi

if [ -z ${build_number+x} ]; then echo "build_number is unset"; exit 1
else echo "build_number is set to '$build_number'";
fi
echo "sed -i \"s/build_number\x27] = \x27[[:digit:]]\+\x27/build_number\x27] = \x27$build_number\x27/\" $file"
sed -i "s/build_number\x27] = \x27[[:digit:]]\+\x27/build_number\x27] = \x27$build_number\x27/" $file
