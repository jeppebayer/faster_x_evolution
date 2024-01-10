#!/bin/bash

# Sources necessary environment
if [ "$USER" == "jepe" ]; then
    source /home/"$USER"/.bashrc
    source activate cactus
    source /home/"$USER"/software/cactus-bin-v2.6.0/cactus_env/bin/activate
fi

cactus \
    --consCores 32 \
    <JobStorePath> \
    <SeqFile> \
    <OutputHAL>

exit 0