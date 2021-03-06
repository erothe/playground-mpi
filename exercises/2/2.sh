#!/bin/bash

echo -e "Compiling"
cd /project/target/2
rm -rf out 2
mpicc -o 2 2.c 2> err_log
rc=$?
if [[ $rc != 0 ]]; then
    echo -e "Error : mpicc returned"
    cat err_log
    echo "TECHIO> success false"
    rm -rf out
    exit $rc
fi
echo "Compilation is OK"
rm -rf out
mkdir out
rc=0

echo -e "Execution ... "
mpirun --allow-run-as-root  -mca btl sm,tcp,self -np 2 -output-filename out/out ./2
cat out/*
rm -rf out

echo "TECHIO> success true"