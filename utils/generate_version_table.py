#!/usr/bin/env python3

import argparse
import os
from typing import Dict

import pandas as pd

SCRIPT_PATH = os.path.dirname(os.path.abspath(__file__))

def parse_arguments():
    parser = argparse.ArgumentParser(description="Prints tool versions for docker-ros-ml-images")
    parser.add_argument("version_tables", nargs='+', help="List of csv files with version tables")
    return parser.parse_args()

def merge_tables(tables) -> Dict[str, pd.DataFrame]:
    all_tables = []
    for table in tables:
        if not os.path.exists(table):
            print(f"Error: File {table} not found.")
            return
        all_tables.append(pd.read_csv(table))
    merged_table = pd.concat(all_tables, sort=False) # concat tables
    merged_table = merged_table.fillna("-") # replace nan by -
    merged_table = merged_table.groupby("Tag").agg(lambda x: "<br>".join([str(e) for e in x]) if len(set(x)) > 1 else str(x.iloc[0])).reset_index() # group by tag, keep unique values joined by <br>
    merged_table["Repo"] = merged_table["Tag"].str.split(":").str[0].str.replace("`", "") # extract repo name
    repo_tables = merged_table.groupby("Repo")
    table_by_repo = {repo: table.drop(columns=["Repo"]) for repo, table in repo_tables}
    return table_by_repo

def print_markdown_table(data: pd.DataFrame):
    headers = list(data.columns)
    header_line = " | ".join(headers)
    separator_line = ":---" + " | " + " | ".join([":---:"] * (len(headers)-1))
    print(header_line)
    print(separator_line)
    for index, row in data.iterrows():
        print(" | ".join(row.values.astype(str)))

def main():
    args = parse_arguments()
    table_by_repo = merge_tables(args.version_tables)
    for repo, table in table_by_repo.items():
        print(f"### {repo}")
        print("")
        print_markdown_table(table)
        print("")


if __name__ == "__main__":
    main()
