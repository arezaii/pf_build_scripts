#!/bin/bash
if [ "$#" -ne 2]; then
    echo "Usage: rebuild_parflow <pf_libs directory> <ParFlow_directory>"
    exit 2
fi

# LIBDIR=$1
# PFDIR=$2

# cd $PFDIR
# rm -rf install build

# mkdir build install
# cd build


# cmake ../parflow -DCMAKE_INSTALL_PREFIX=${DIR}/install -DPARFLOW_AMPS_LAYER=mpi1 -DPARFLOW_ENABLE_TIMING=true -DPARFLOW_HAVE_CLM=ON -DTK_INCLUDE_PATH=${TK_INCLUDE_PATH} -DHYPRE_ROOT=${PARFLOW_HYPRE} -DSILO_ROOT=${PARFLOW_SILO} -DHDF5_ROOT=${PARFLOW_HDF5} -DTCL_INCLUDE_PATH=${TCL_INCLUDE_PATH} -DPARFLOW_AMPS_SEQUENTIAL_IO=True

# make
# make install

# cd ../parflow/test/washita/tcl_scripts/
# tclsh Dist_Forcings.tcl
    # if [ "$#" -ne 2 ]; then
 #        echo "Usage: build_parflow <pf_libs directory> <parflow_dir>"
 #        exit 2
 #    fi

PFLIBS=$1
PFDIR=$2


if [ ! -d $PFDIR ]; then    
 mkdir -p $PFDIR
fi  

cd $PFDIR

#-----------------------------------------------------------------------------
# Script Env variables we need
#-----------------------------------------------------------------------------
export CORE_COUNT=2
export PARFLOW_DIR=$PFDIR
export OMPI_DIR=${PFLIBS}/ompi
export HDF5_DIR=${PFLIBS}/hdf5
export NETCDF_DIR=${PFLIBS}/netcdf
export SILO_DIR=${PFLIBS}/silo
export HYPRE_DIR=${PFLIBS}/hypre
export PATH=${OMPI_DIR}/bin:$PATH
export LD_LIBRARY_PATH=${HDF5_DIR}/lib:${OMPI_DIR}/lib:$LD_LIBRARY_PATH

#-----------------------------------------------------------------------------
# Parflow configure and build
#-----------------------------------------------------------------------------          

mkdir -p build install && \
cd build && \
cmake3 ../parflow \
-DPARFLOW_AMPS_LAYER=mpi1 \
-DPARFLOW_AMPS_SEQUENTIAL_IO=TRUE \
-DHYPRE_ROOT=${HYPRE_DIR} \
-DSILO_ROOT=${SILO_DIR} \
-DHDF5_ROOT=${HDF5_DIR} \
-DPARFLOW_ENABLE_TIMING=TRUE \
-DPARFLOW_HAVE_CLM=ON \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=${PARFLOW_DIR}/install && \
make install -j${CORE_COUNT} && \
cd ..  