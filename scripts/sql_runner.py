" Run SQL queries from a file and print results for SELECT statements."
import sys

import duckdb

sql_file = sys.argv[1] if len(sys.argv) > 1 else "sql/example.sql"

with open(sql_file, "r") as f:
    sql_script = f.read()

statements = [s.strip() for s in sql_script.split(";") if s.strip()]

for statement in statements:
    try:
        result = duckdb.sql(statement)
        # Remove comments to check if this is a SELECT statement
        lines = [line.split("--")[0].strip() for line in statement.split("\n")]
        cleaned = " ".join(line for line in lines if line)
        if cleaned.upper().startswith(("SELECT", "WITH")):
            print(f"\n{'='*80}")
            print(result.to_df().to_string())
            print(f"{'='*80}\n")
    except Exception as e:
        print(f"Error executing query: {e}")
