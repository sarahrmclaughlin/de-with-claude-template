# TEMPLATE Repo - For DE work using UV

- You can use this as well data_engineering_repo_bootstrap.sh

## Setup (uv)

```bash
uv venv
source .venv/bin/activate
uv sync
```

## Run

```bash
uv run python src/main.py
```

## Test

```bash
uv run pytest
```

## Alternative (pip)

```bash
uv export --format requirements-txt > requirements.txt
pip install -r requirements.txt
```


```bash
Task	            Command
List dependencies	uv pip list
Add package	        uv add <package>
Add dev package	    uv add --dev <package>
Remove package	    uv remove <package>
Remove dev package	uv remove --dev <package>
Sync env(post update)	uv sync 
Run script inside venv	uv run python src/main.py
```

## Virtual Environment

- Don't activate, just run 
```bash
uv run python src/main.py
uv run pytest
```

- Activate
```bash
source .venv/bin/activate
python src/main.py
pytest
```