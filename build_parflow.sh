  #
  #
  #
  #
    

    PFLIBS=$1
    PFDIR=$2

    cd $PFDIR
   
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
    
    #PARFLOW_MPIEXEC_EXTRA_FLAGS="--mca mpi_yield_when_idle 1 --oversubscribe --allow-run-as-root"
        
    git clone -b master --single-branch https://github.com/parflow/parflow.git parflow && \
    mkdir -p build install && \
    cd build && \
    cmake3 ../parflow \
    -DPARFLOW_AMPS_LAYER=mpi1 \
    -DPARFLOW_AMPS_SEQUENTIAL_IO=FALSE \
    -DHYPRE_ROOT=${HYPRE_DIR} \
    -DSILO_ROOT=${SILO_DIR} \
    -DHDF5_ROOT=${HDF5_DIR} \
    -DPARFLOW_ENABLE_TIMING=TRUE \
    -DPARFLOW_HAVE_CLM=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PARFLOW_DIR}/install && \
    make install -j${CORE_COUNT} && \
    cd .. && \
    rm -fr parflow build