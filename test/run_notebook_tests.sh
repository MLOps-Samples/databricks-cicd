#!/bin/bash

python -m build --wheel src
name=$(cd src/dist; ls databrickscicd*.whl)
databricks fs cp --overwrite src/dist/${name} ${DATABRICKS_DBFS_PATH}
databricks libraries install --cluster-id ${DATABRICKS_CLUSTER_ID} --whl ${DATABRICKS_DBFS_PATH}/${name}
databricks workspace import --overwrite src/main_notebook.py --language PYTHON ${DATABRICKS_WORKSPACE_PATH}/main_notebook.py
pytest --cache-clear test/test_main_notebook.py
