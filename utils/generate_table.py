#!/usr/bin/env python3

import argparse
import os
import pandas as pd

SCRIPT_PATH = os.path.dirname(os.path.abspath(__file__))

def parse_arguments():
    parser = argparse.ArgumentParser(description="Prints tool versions for docker-ros-ml-images")
    parser.add_argument("version_tables", nargs='+', help="List of csv files with version tables")
    return parser.parse_args()

def merge_tables(tables) -> pd.DataFrame:
    all_tables = []
    for table in tables:
        if not os.path.exists(table):
            print(f"Error: File {table} not found.")
            return
        all_tables.append(pd.read_csv(table))
    merged_table = pd.concat(all_tables, sort=False)
    merged_table = merged_table.drop_duplicates()
    return merged_table
    
def print_markdown_table(data: pd.DataFrame):
    headers = list(data.columns)
    header_line = " | ".join(headers)
    separator_line = " | ".join(["---"] * len(headers))
    print(header_line)
    print(separator_line)
    
    for index, row in data.iterrows():
        print(" | ".join(row.values.astype(str)))

def main():
    args = parse_arguments()
    version_information = merge_tables(args.version_tables)
    md_table = version_information.to_markdown(index=False)
    print(md_table)
    print("\n\n")
    print_markdown_table(version_information)
    

if __name__ == "__main__":
    main()
