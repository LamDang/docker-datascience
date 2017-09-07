
# v2.2.0
* Major changes:
    * Start semantic versioning MAJOR.MINOR.PATCH
    * New images 40_ocr:
        * tesseract 4.0-alpha and dependencies
        * some linux lib to read images format
    * New packages:
        * SpaCy
        * fastparquet & pyarrow
        * holoviews & datashader
        * plotly & dash
        * brunel
        * several minor packages:
            * lifelines
            * nlopt
            * imbalanced-learn
            * jellyfish
            * python-Levenshtein
            * python-igraph
            * fuzzywuzzy
    * Several packages have been switched from git install to conda install to improve stability:
        * xgboost
        * lightgbm
        * tensorflow
        * keras

# v2.1
* Major changes:
    * New packages:
        * opencv
        * tqdm
        * pydotplus
    * Updates:
        * Anaconda -> 4.4.0
        * tensorflow -> 1.2.*
    * Add mkl validation tests
* Bug fixes:
    * Fix mkl broken after tensorflow installation

# v2.0
* Major changes:
    * Remove dependencies from jupyter docker stacks
        * Base image become ubuntu:xenial
        * Copied the jupyter_notebook_config.py and .sh run files from the repo
    * Reorganization:
        * Image 00 become 00_setup instead of 00_jupyter_setup
            * This image only contain a basic ubuntu installation with minimal
            setup
    * Removing Spark installation:
        * Spark usage on local does not prove to be useful
        * Spark should be integrated in a Hadoop distribution. Integration
        with Jupyter notebook can be done with volume mount and env variables
* Updates:
    * Anaconda version updated to 4.3.1
    * tensorflow updated to 1.0.1
    * theano updated to 0.9
    * keras updated to 2.0
* Additions:
    * fastparquet to work with parquet file in Python
    * libgpuarray backend for theano (possibility to use float16)
* Bug fixes:
    * Rollback jupyter notebook to 4.2.3 since the version in anaconda 4.3.1
    crashed with keras progbar.
