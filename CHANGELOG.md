* v2.0 changelog
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
