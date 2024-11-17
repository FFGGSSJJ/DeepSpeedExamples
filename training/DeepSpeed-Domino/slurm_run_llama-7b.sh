#!/bin/bash

#SBATCH --job-name=deepspeed_llama-7b
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --gpus-per-node=1
#SBATCH --time=00:10:00
#SBATCH --output=./slurm-log/slurm-%j.out
#SBATCH --error=./slurm-log/slurm-%j.err

# ntasks-per-node = gpus-per-node
# world size = nodes*ntasks-per-node

echo "=== MASTER SETUP BEGIN ==="
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
master_port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo "Master Addr: "$master_addr" Master Port: "$master_port
echo "=== MASTER SETUP END ==="

echo "=== WORKLOAD BEGIN ==="
srun bash pretrain_llama_7b.sh $master_addr $master_port