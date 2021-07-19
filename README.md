# Overview

This example demonstrates how to run unit tests on Python code using [Databricks Connect](https://docs.microsoft.com/en-us/azure/databricks/dev-tools/databricks-connect) and integration tests on Databricks notebooks, all in [GitHub Actions](https://docs.github.com/en/actions/learn-github-actions).

The sample contains a single notebook [main_notebook.py](src/main_notebook.py) which calls [some_function](test/dbcicdlib/some_func.py) in a Python module. We run [unit test on some_function](test/unittests/test_some_func.py) and [integration test on main_notebook.py](test/run_notebook_tests.sh).

## How it works

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
