.PHONY: install run test

install:
	uv sync

run:
	uv run python src/main.py

test:
	uv run pytest
