#!/bin/sh

# tail a specified Kinesis stream

stream=$1
shard=$2
seq=$3

it=$(aws kinesis get-shard-iterator --stream-name "$stream" \
         --shard-id "$shard" --shard-iterator-type AT_SEQUENCE_NUMBER \
         --starting-sequence-number "$seq" | jq .ShardIterator)

while [ "$it" != "" ]; do
    r=$(aws kinesis get-records --shard-iterator "$it")
    echo "$r" | jq .Records
    it=$(echo "$r" | jq .NextShardIterator)
done
