#!/bin/bash

for i in {1..100}
do
    IDADE=$(((RANDOM % 100)+1))
    echo "./pessoas -i Pessoa${i} $IDADE"

    ./pessoas -i Pessoa${i} $IDADE

done
