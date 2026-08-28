import csv
csv_path = r"***"
with open(csv_path, "r", encoding="utf-8-sig", newline="") as file:
    reader = csv.reader(file)

    header = next(reader)
    first_row = next(reader)

    print("HEADER:")
    for i, column in enumerate(header, start=1):
        print(i, column)

    print("\nFIRST ROW:")
    for i, value in enumerate(first_row, start=1):
        print(i, value)

    print("\nCOLUMN COUNTS:")
    print("Header columns:", len(header))
    print("First row columns:", len(first_row))