#!/bin/bash

cd /users/gfu/DeepSpeedExamples/training/HelloDeepSpeed
NODE_RANK=$SLURM_NODEID
echo "Node Rank: $NODE_RANK"
deepspeed --hostfile='./myhostfile' \
    --no_ssh --node_rank=$NODE_RANK \
    --master_addr=$1 --master_port=$2 \
    train_bert_ds.py --checkpoint_dir './experiment_deepspeed'
