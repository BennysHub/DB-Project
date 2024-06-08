

## pad with zeros
import re

def pad_id_with_zeros(id_value):
    return id_value.zfill(9)

def process_sql_file(sql_file_path):
    with open(sql_file_path, 'r') as sql_file:
        sql_content = sql_file.read()

    # Split the content into individual lines
    sql_lines = sql_content.splitlines()

    updated_lines = []  # To store modified lines
    for line in sql_lines:
        start_index = line.find("values") + len("values")
        numeric_value = line[start_index:].split("(")[1].split(",")[0]
        modified_line = line.replace(numeric_value, f"'{numeric_value}'") 
        updated_lines.append(modified_line)

    # Write the updated content back to the file
    with open(sql_file_path, 'w') as updated_sql_file:
        updated_sql_file.write('\n'.join(updated_lines))

    print(f"Updated SQL file: {sql_file_path}")

# Example usage
sql_file_path = 'C:/Users/benny/Downloads/person.sql'
process_sql_file(sql_file_path)



## soround with '  ' 
import re

def pad_id_with_zeros(id_value):
    return id_value.zfill(9)

def process_sql_file(sql_file_path):
    with open(sql_file_path, 'r') as sql_file:
        sql_content = sql_file.read()

    # Split the content into individual lines
    sql_lines = sql_content.splitlines()

    updated_lines = []  # To store modified lines

    for line in sql_lines:
        # Extract the ID value from the line
        match = re.search(r'values \((\d+),', line, re.IGNORECASE)
        if match:
            id_value = match.group(1)
            padded_id = pad_id_with_zeros(id_value)
            # Replace the original ID value with the padded one
            updated_line = re.sub(r'\b\d+\b', padded_id, line, count=1)
            updated_lines.append(updated_line)
        else:
            updated_lines.append(line)

    # Write the updated content back to the file
    with open(sql_file_path, 'w') as updated_sql_file:
        updated_sql_file.write('\n'.join(updated_lines))

    print(f"Updated SQL file: {sql_file_path}")

# Example usage
sql_file_path = 'C:/Users/benny/Downloads/person.sql'
process_sql_file(sql_file_path)


## remove  '  ' 
import re

def pad_id_with_zeros(id_value):
    return id_value.zfill(9)

def process_sql_file(sql_file_path):
    with open(sql_file_path, 'r') as sql_file:
        sql_content = sql_file.read()

    # Split the content into individual lines
    sql_lines = sql_content.splitlines()

    updated_lines = []  # To store modified lines
    for line in sql_lines:
        start_index = line.find("values") + len("values")
        numeric_value = line[start_index:].split("(")[1].split(",")[0]
        modified_line = line.replace(numeric_value, f"'{numeric_value.strip('\'')}'")
        updated_lines.append(modified_line)

    # Write the updated content back to the file
    with open(sql_file_path, 'w') as updated_sql_file:
        updated_sql_file.write('\n'.join(updated_lines))

    print(f"Updated SQL file: {sql_file_path}")

# Example usage
sql_file_path = 'C:/Users/benny/Downloads/person.sql'
process_sql_file(sql_file_path)










durations = [15, 20, 25, 30, 40]

import re
from datetime import datetime, timedelta
import random

# Define the file paths
input_file_path = 'C:/Users/benny/Downloads/lectures (11).sql'
output_file_path = 'C:/Users/benny/Downloads/lectures (11).sql'
# Define the possible durations to add to time_start


# Read the input SQL file
with open(input_file_path, 'r') as file:
    lines = file.readlines()

# Process each line in the file
new_lines = []
for line in lines:
    # Match the insert statement pattern, accounting for an optional ADVISING_NOTES field
    match = re.search(r"values \('.*', '.*', '(.*)', 'error:.*'(, '.*'|, null)?\);", line)
    if match:
        # Extract the time_start value
        time_start_str = match.group(1)
        # Convert time_start to a datetime object
        time_start = datetime.strptime(time_start_str, '%Y-%m-%d %H:%M:%S')
        # Add a random duration to time_start
        time_end = time_start + timedelta(minutes=random.choice(durations))
        # Format time_end back to string
        time_end_str = time_end.strftime('%Y-%m-%d %H:%M:%S')
        # Replace the error message with the new time_end value
        new_line = re.sub(r"'error:.*?'(, '.*'|, null)?", f"'{time_end_str}'\\1", line)
        new_lines.append(new_line)
    else:
        # If no match, keep the line as is
        new_lines.append(line)

# Write the new SQL statements to the output file
with open(output_file_path, 'w') as file:
    file.writelines(new_lines)

print(f"Updated SQL file has been saved to {output_file_path}")




# Read the original SQL file
with open('C:/Users/benny/Downloads/assignment (1).sql', 'r') as file:
    sql_statements = file.readlines()

# Add 'IGNORE' to each INSERT statement
modified_statements = [line.replace('INSERT INTO', 'INSERT IGNORE INTO') if 'INSERT INTO' in line else line for line in sql_statements]

# Write the modified SQL statements to a new file
with open('C:/Users/benny/Downloads/assignment (1).sql', 'w') as file:
    file.writelines(modified_statements)

print("The INSERT statements have been modified with IGNORE.")



import re
from datetime import datetime, timedelta
import random

# Define the file paths
input_file_path = 'C:/Users/benny/Downloads/lectures (11).sql'
output_file_path = 'C:/Users/benny/Downloads/lectures (11).sql'

# Define the possible durations to add to start_time

durations = [60, 90, 120, 150, 180]
# Read the input SQL file
with open(input_file_path, 'r') as file:
    lines = file.readlines()

# Process each line in the file
new_lines = []
for line in lines:
    # Match the insert statement pattern
    match = re.search(r"values \('.*', .*, '(.*)', 'error:.*?', .*, .*\);", line)
    if match:
        # Extract the start_time value
        start_time_str = match.group(1)
        # Convert start_time to a datetime object
        start_time = datetime.strptime(start_time_str, '%Y-%m-%d %H:%M:%S')
        # Add a random duration to start_time
        end_time = start_time + timedelta(minutes=random.choice(durations))
        # Format end_time back to string
        end_time_str = end_time.strftime('%Y-%m-%d %H:%M:%S')
        # Replace the error message with the new end_time value
        new_line = re.sub(r"'error:.*?'", f"'{end_time_str}'", line)
        new_lines.append(new_line)
    else:
        # If no match, keep the line as is
        new_lines.append(line)

# Write the new SQL statements to the output file
with open(output_file_path, 'w') as file:
    file.writelines(new_lines)

print(f"Updated SQL file has been saved to {output_file_path}")























import re
from datetime import datetime

# Define the file paths
input_file_path = 'C:/Users/benny/Downloads/lectures (11).sql'
output_file_path = 'C:/Users/benny/Downloads/lectures (11).sql'

# Read the input SQL file
with open(input_file_path, 'r') as file:
    content = file.readlines()

# Extract INSERT statements and their start times
insert_statements = []
for line in content:
    match = re.search(r"values \('.*', .*, '(.*)', .*?\);", line)
    if match:
        start_time_str = match.group(1)
        start_time = datetime.strptime(start_time_str, '%Y-%m-%d %H:%M:%S')
        insert_statements.append((start_time, line))

# Sort the INSERT statements by start time
sorted_statements = sorted(insert_statements, key=lambda x: x[0])

# Write the sorted INSERT statements to the output file
with open(output_file_path, 'w') as file:
    for _, statement in sorted_statements:
        file.write(statement)

print(f"Sorted SQL file has been saved to {output_file_path}")

