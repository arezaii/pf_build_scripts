# ParFlow Build Scripts

A set of scripts for downloading and building necessary libraries and the ParFlow model.

## Files

* dl_and_build_libs.sh - downloads the and builds necessary libraries
* clone_and_build_pf_repo.sh - clone a specific ParFlow repository and branch, then build


## Requirements

### CMake

### Git

### Wget

### C/C++ compiler

### Fortran compiler


### TCL/TK and Headers

Should be able to get these for your distribution if not included. Most shared systems have them available as modules.



### Environment Vars

In almost all cases, you will need to point cmake to specific libraries or headers for your system. The build script does this using environt vars. Here are the ones you should set:

* PARFLOW_DIR - the base directory for ParFlow - often parflow_dir/install


###Update PATH-

It is important to update the PATH variable to include the OpenMPI installation. 

```
export PATH=${OMPI_DIR}/bin:$PATH
```

This prepends the OMPI_DIR/bin location to the existing PATH, ensuring our version of OMPI will be used when mpirun is called.

## Usage

### Typical Use

For a first time installation, ensure you have met the requirements, then install the libraries by running:

```
./dl_and_build_libs.sh <base_directory>
```

This should produce a directory structure like this in `<base_directory>`

```
.
├── downloads
│   ├── hdf5
│   ├── hypre
│   ├── ompi
│   └── silo
└── pflib
    ├── hdf5
    ├── hypre
    ├── ompi
    └── silo
```

In this structure, all of the required libraries are created under `pflib`. Directories under `downloads` can be safely deleted.

If everything goes OK you can move on to step 2, cloning and building ParFlow:

```
./clone_and_build_parflow.sh <pf_libs directory> <parflow_install directory> <parflow repository> <branch>
```

example usage:
```
export PARFLOW_DIR=~/pf/parflow/install
./clone_and_build_parflow.sh ~/pf/pflib ~pf/parflow https://github.com/parflow/parflow master
```

and the resulting directory structure:
```
.
├── downloads
│   ├── hdf5
│   ├── hypre
│   ├── ompi
│   └── silo
├── parflow
│   ├── build
│   ├── install
│   └── parflow
└── pflib
    ├── hdf5
    ├── hypre
    ├── ompi
    └── silo
```


## Troubleshooting


