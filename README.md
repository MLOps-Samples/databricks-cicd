# Overview

This example demonstrates how to run unit tests on Python code using [Databricks Connect](https://docs.microsoft.com/en-us/azure/databricks/dev-tools/databricks-connect) and integration tests on Databricks notebooks, all in [GitHub Actions](https://docs.github.com/en/actions/learn-github-actions).

The sample contains a single notebook [main_notebook.py](src/main_notebook.py) which calls [some_function](test/dbcicdlib/some_func.py) in a Python module. We run [unit test on some_function](test/unittests/test_some_func.py) and [integration test on main_notebook.py](test/run_notebook_tests.sh).

Another small feature used in this sample is to use a pre-commit-config hook to prevent secrets from being checked in.

## How it works

Databricks Connect enables IDE such as VSCode and [Databricks Connect Cli](https://docs.microsoft.com/en-us/azure/databricks/dev-tools/databricks-connect#step-1-install-the-client) tool to access Databricks cluster from the local dev machine or build agent. Unit tests should have no dependencies on things like dbfs, they should be taking dataframes as input/output parameters. Once Databricks Connect is set up, you can run unit tests using PyTest as usual, either in the command line, or in VSCode. You can also debug Python scripts or unit tests in VSCode. If the target Databricks cluster is not running, it will automatically start the cluster.

You can also run or debug Databricks Notebooks locally with Databricks Connect. However, in this example, we use run_notebook_test.sh creates a [job run]() that invokes test_main_notebook.py, which further invokes main_notebook.py and asserts its output against expectation. The reasons we are not using Databricks Connect to run integration tests include:

1. if the code is going to be run as Databricks Jobs in production, it's better to run the tests in a way that's as close to real environment as possible.
1. Normally you need to install your library code as modules for Notebooks to call, once libraries are installed it takes a cluster restart to remove it to tear down the tests, which makes continuous tests inefficient.  

### extras

1. create .secrets.baseline, ensure no secrets in it.
1. pre-commit-config to prevent secrets from being checked in.

### Unit tests

1. with Databricks Connect.
1. Same as Pytest.  
1. Local build and install package for development

### Integration tests

1. Deploy notebooks which test main_notebook, with asserts.
1. Build and Install package to cluster.
1. Run notebooks as job_submit.

## How to run tests on the local dev machine

### Prereq

1. Set up Conda
1. Set up VSCode
1. Set up .env

### Run unit tests

1. Set up Databricks Connect
1. From the project root, run `pytest test/unittests`
1. Set up VSCode to debug unit tests

### Run integration tests

1. export $(cat .env | xargs)
2. run_notebook_tests.sh

## Alternative approaches

1. Dev container with makefile
