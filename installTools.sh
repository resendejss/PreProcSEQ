#!/bin/bash

cd ~/Downloads

# -- System Libraries
sudo apt-get install libssl-dev openssl libcurl4 libcurl4-openssl-dev default-jdk gdebi libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 xml2 libxml2-dev libtiff-dev libfftw3-dev

# -- FastQC
sudo apt-get update
sudo apt-get -y install fastqc

# -- MultiQC
sudo apt install python3-pip
pip install multiqc

# -- Trimmomatic
sudo apt-get update -y
sudo apt-get install -y trimmomatic

# -- Salmon
sudo apt-get update
sudo apt-get -y install salmon

# -- Kallisto
sudo apt-get update
sudo apt-get install kallisto

# -- R installation (v. 4.2)
sudo apt update -qq
sudo apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install --no-install-recommends r-base

# R packages
Rscript -e 'install.packages(c("BiocManager","readxl","stringr","magrittr"))
BiocManager::install(c("tximport","tximeta","GenomicFeatures","ensembldb","SummarizedExperiment","AnnotationHub","edgeR","sva"))'
