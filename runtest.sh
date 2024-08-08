
zsh
__mlconfig
cd ~/projects/gputil

for num_nodes in `seq 1 4` 
do
    for num_images in 1 5 10 50 100 500 1000
    do
        salloc -N $num_nodes --exclusive

        export CHPL_COMM="gasnet"
        export CHPL_LAUNCHER="slurm_amudprun"
        export GASNET_SSH_SERVERS=$(scontrol show hostnames | xargs echo)

        echo "Running on $num_nodes on $(scontrol show hostnames | xargs echo) with "

        python3 times.py measure "./MultiLocaleInference -nl $num_nodes --numImages=$num_images --numTries=10 --printResults=false" --name "ml_test_${num_nodes}_${num_images}"
        exit
    done
done

