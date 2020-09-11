# nxxm_ci_docker

## NXXM
Please visit our website : https://nxxm.github.io 

# Usage
Create a ``.yml`` file under ``.github/workflows`` with the following contents

### Configuration to check if your code compiles under linux 

```yml
name: CI
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]
jobs:
  build:
    name: nxxm_CI
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: nxxm_CI 
        uses: nxxm/nxxm_ci_docker@master
    env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        
```
### Configuration to check if your code compiles under linux and downloads the build folder 


```yml
name: CI
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]
jobs:
  build:
    name: nxxm_CI
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: nxxm_CI 
        uses: nxxm/nxxm_ci_docker@master
      - name: Upload the build directory
        uses: actions/upload-artifact@v2
        with:
          name: my_build
          path: build/
    env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
       
```

### Configuration to check if your code compiles and downloads the build folder with option 

```yml
name: CI
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]
jobs:
  build:
    name: nxxm_CI_input
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: nxxm_CI 
        uses: nxxm/nxxm_ci_docker@master
        with: 
          target: ""
          sources: ""
          exclude: ""
          config: ""
          jobs: ""
          use_cmakelists: ""
          test: ""
          exclude_test: ""          
          extra_args: ""
      - name: Upload the build directory
        uses: actions/upload-artifact@v2
        with:
          name: my_build
          path: build/
    env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Input options

``target`` : Choice of the compilation target. 
             For linux : ``-t gcc-7-cxx17``
             For webassembly : ``-t wasm-cxx17``
             In default nxxm choose -t wasm-cxx17
             
``sources`` : Directorie(s) containing the libs sources and headers. Defaults to project root. eg  ``-s folder/path/`` 
              Repeat to add many dirs e.g.  ``-s include -s src ``
  
 ``exclude`` : Directories within project dir to exclude from source analysis 
               Repeat to exclude multiple dirs e.g.  ``-x="benchmark/" -x="test/"``

``config`` : Build type, defaults to optimized MinSizeRel build.But you can have ``-C MinSizeRel`` or ``-C Release`` or ``-C RelWithDebInfo`` or ``-C Debug``

``jobs`` : How many CPU cores have to be dedicated to the build. example: ``-j3``

``use_cmakelists`` :  ``-u`` : Don't build by convention, use CMakeLists.txt at toplevel.

``test`` :  ``--test`` : Whether to run the tests built ( i.e. .cpp files found in test[s]/ or example[s]/ folder)
            ``--test=all`` runs the full test suite, ``--test=example/mytest`` runs mytest.

``exclude_test`` :  ``--test-exclude`` : regular expression to match test to exclude. When --test=all is passed, this allows excluding a test or more.

``etra_args`` : You can enter all the other options of nxxm

