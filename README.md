# TEMPLATE Repo - For DE work using UV

##### A general template for DE work 

- You can use this template or just upload using data_engineering_repo_bootstrap.sh
    - For the script shell (WORK IN PROGRESS)
```bash
    ./data_engineering_repo_bootstrap.sh
```

### Setup
uv venv
source .venv/bin/activate
uv sync

### Run ETL
make run

### Run Spark
make spark

### Run SQL
make sql

### Run tests
make test

### Claude
- CLAUDE.MD 
- Agents

### Notes
- Uses DuckDB for local analytics
- Includes optional Spark + Airflow
- Designed for fast iteration


```bash
.
├── src/
│   ├── pipelines/
│   │   ├── etl_api_to_duckdb.py
│   │   ├── spark_job.py
│   │   └── sql_runner.py
│   ├── utils/
│   │   ├── logger.py
│   │   └── config.py
│   └── main.py
│
├── tests/
│   └── test_main.py
│
├── sql/
│   └── example.sql
│
├── airflow/dags/
│   └── example_dag.py
│
├── docker/
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── .vscode/settings.json
├── .pre-commit-config.yaml
├── pyproject.toml
├── Makefile
├── README.md
├── .gitignore
└── .env.example
```



