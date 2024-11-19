#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --gpus-per-node=1
#SBATCH --time=00:10:00
#SBATCH --partition=amdrtx
#SBATCH --nodelist=ault[43-44]
#SBATCH --time=00:10:00
#SBATCH --output=./slurm-log/slurm-%j.out
#SBATCH --error=./slurm-log/slurm-%j.err

module load openmpi/4.1.1
module load cuda/11.8.0
module load rdma-core/34.0
module load gcc/10.2.0

echo "=== MASTER SETUP BEGIN ==="
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
master_port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo "Master Addr: "$master_addr" Master Port: "$master_port
echo "=== MASTER SETUP END ==="

srun bash run_ds.sh $master_addr $master_port
