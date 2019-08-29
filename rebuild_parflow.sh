#!/bin/bash


DIR=$1

cd $DIR
rm -rf install build

#git clone https://github.com/parflow/parflow.git

mkdir build install
cd build
cmake ../parflow -DCMAKE_INSTALL_PREFIX=${DIR}/install -DPARFLOW_AMPS_LAYER=mpi1 -DPARFLOW_ENABLE_TIMING=true -DPARFLOW_HAVE_CLM=ON -DTK_INCLUDE_PATH=${TK_INCLUDE_PATH} -DHYPRE_ROOT=${PARFLOW_HYPRE} -DSILO_ROOT=${PARFLOW_SILO} -DHDF5_ROOT=${PARFLOW_HDF5} -DTCL_INCLUDE_PATH=${TCL_INCLUDE_PATH}

make
make install

# cd ../parflow/test/washita/tcl_scripts/
# tclsh Dist_Forcings.tcl
