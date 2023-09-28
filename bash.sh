#!/bin/bash

extract_zip() {
    local input_zip="$1"
    local password="$2"

    unzip -P "$password" "$input_zip" -d "${input_zip%.zip}"

    for inner_zip in "${input_zip%.zip}"/*.zip; do
        local inner_password="${inner_zip%.zip}"
        inner_password="${inner_password##*/}"

        extract_zip "$inner_zip" "$inner_password"
    done
}

# Main script
for zip_file in *.zip; do
    password="${zip_file%.zip}"

    extract_zip "$zip_file" "$password"
done
