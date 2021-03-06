#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: dl_and_build_libs <base_working_directory>"
    exit 2
fi

# Setup the number of cores to build with
export CORE_COUNT=2

# Assign a base directory to work within
# All other paths are relative to base (home) directory
HOME_DIR=$1

export PARFLOW_LIB_DIR=${HOME_DIR}/pflib
export DOWNLOAD_DIR=${HOME_DIR}/downloads
mkdir -p ${PARFLOW_LIB_DIR}
cd ${HOME_DIR}   

#-----------------------------------------------------------------------------
# Build libraries
#-----------------------------------------------------------------------------

#
# OMPI
# 
echo "Installing Open MPI"
export OMPI_DIR=${PARFLOW_LIB_DIR}/ompi
export OMPI_VERSION=4.0.1
export OMPI_URL="https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-$OMPI_VERSION.tar.gz"
mkdir -p ${DOWNLOAD_DIR}/ompi    
mkdir -p $OMPI_DIR
# Download
cd ${DOWNLOAD_DIR}/ompi && wget -O openmpi-$OMPI_VERSION.tar.gz $OMPI_URL && tar -xf openmpi-$OMPI_VERSION.tar.gz
# Compile and install
cd ${DOWNLOAD_DIR}/ompi/openmpi-$OMPI_VERSION && ./configure --prefix=$OMPI_DIR && make install -j${CORE_COUNT}
cd ../.. 
#rm -fr ompi
# Set env variables so we can
# compile our application
export PATH=$OMPI_DIR/bin:$PATH
export LD_LIBRARY_PATH=$OMPI_DIR/lib:$LD_LIBRARY_PATH
#export MANPATH=$OMPI_DIR/share/man:$MANPATH


#
# HDF5
#
echo "Installing HDF5"
export HDF5_DIR=${PARFLOW_LIB_DIR}/hdf5
export HDF5_VERSION=1.10.5
export HDF5_URL="https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-${HDF5_VERSION}/src/hdf5-${HDF5_VERSION}.tar.gz"
mkdir -p $HDF5_DIR
mkdir -p ${DOWNLOAD_DIR}/hdf5
cd ${DOWNLOAD_DIR}/hdf5 && \
wget ${HDF5_URL} && \
tar -xf hdf5-${HDF5_VERSION}.tar.gz && \
cd hdf5-${HDF5_VERSION} && \
CC=mpicc CXX=mpicxx ./configure \
  --prefix=$HDF5_DIR \
  --enable-parallel && \
make -j${CORE_COUNT} && make install -j${CORE_COUNT} && \
cd ../..
#rm -fr hdf5
export LD_LIBRARY_PATH=$HDF5_DIR/lib:$LD_LIBRARY_PATH

#
# NetCDF
#
#echo "Installing NetCDF"
#export NETCDF_DIR=${PARFLOW_LIB_DIR}/netcdf
#export NETCDF_VERSION=4.7.3
#export NETCDF_URL="https://github.com/Unidata/netcdf-c/archive/v$NETCDF_VERSION.tar.gz"
#mkdir -p $NETCDF_DIR
#mkdir -p ${DOWNLOAD_DIR}/netcdf
#cd ${DOWNLOAD_DIR}/netcdf

#wget ${NETCDF_URL} && \
#tar -xf v${NETCDF_VERSION}.tar.gz && \
#cd netcdf-c-${NETCDF_VERSION} && \
#CC=mpicc CPPFLAGS=-I${HDF5_DIR}/include LDFLAGS=-L${HDF5_DIR}/lib \
#./configure --disable-shared --disable-dap --prefix=${NETCDF_DIR} && \
#make -j${CORE_COUNT} && \
#make install -j${CORE_COUNT} && \
#cd ../.. && \
#rm -fr netcdf-c-$NETCDF_VERSION v$NETCDF_VERSION.tar.gz


#
# SILO 
#
echo "Installing SILO"
export SILO_DIR=${PARFLOW_LIB_DIR}/silo
export SILO_VERSION=4.10.2    
mkdir -p $SILO_DIR
mkdir -p ${DOWNLOAD_DIR}/silo
cd ${DOWNLOAD_DIR}/silo

wget -O silo-${SILO_VERSION}.tar.gz \
    https://wci.llnl.gov/content/assets/docs/simulation/computer-codes/silo/silo-${SILO_VERSION}/silo-${SILO_VERSION}.tar.gz && \
tar -xf silo-${SILO_VERSION}.tar.gz && \
cd silo-${SILO_VERSION} && \
./configure  --prefix=$SILO_DIR --disable-silex --disable-hzip --disable-fpzip FC=/usr/bin/gfortran F77=/usr/bin/gfortran && \
make install -j${CORE_COUNT} && \
cd ../..
#rm -fr silo #-${SILO_VERSION} silo-${SILO_VERSION}.tar.gz


#
# Hypre
#
echo "Installing Hypre"
export HYPRE_DIR=${PARFLOW_LIB_DIR}/hypre
export HYPRE_VERSION=2.17.0
mkdir -p ${DOWNLOAD_DIR}/hypre
cd ${DOWNLOAD_DIR}/hypre
wget https://github.com/hypre-space/hypre/archive/v${HYPRE_VERSION}.tar.gz && \
tar xf v${HYPRE_VERSION}.tar.gz && \
cd hypre-${HYPRE_VERSION}/src && \
./configure --prefix=${HYPRE_DIR} \
CC=mpicc CXX=mpicxx && \
make install -j${CORE_COUNT} && \
cd ../..
#rm -fr hypre   #-${HYPRE_VERSION} v${HYPRE_VERSION}.tar.gz
