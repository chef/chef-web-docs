#!/bin/bash

set -euo pipefail

# Configuration
readonly CONTENT_DIR="${1:-./content}"
readonly ALLOWED_NON_ASCII='[✓|├|─|│|└|↑|↓|‣|✔|✗|☛|»|Ω|★|☑|é|í]'

# Skip auto-generated files
readonly SKIP_FILES=("habitat_cli.md" "service_templates.md")

# Function to check for non-ASCII characters
check_non_ascii() {
    local content_dir="$1"
    local allowed_chars="$2"

    if [[ ! -d "$content_dir" ]]; then
        echo "Error: Content directory '$content_dir' not found" >&2
        return 2
    fi

    # Find non-ASCII characters, excluding allowed ones and skipped files
    local violations
    violations=$(grep -r -I --color=auto -o --with-filename -n -P '[^\x00-\x7F]' "$content_dir" 2>/dev/null \
        | grep -v "$allowed_chars" \
        | grep -v -E "$(printf "|%s" "${SKIP_FILES[@]}")" || true)

    if [[ -z "$violations" ]]; then
        return 0  # Success - no violations found
    else
        echo "$violations"
        return 1  # Failure - violations found
    fi
}

# Function to display usage information
usage() {
    cat << EOF
Usage: $0 [CONTENT_DIR]

Check for non-ASCII characters in Hugo content files.

Arguments:
    CONTENT_DIR    Directory to check (default: ./content)

Exit codes:
    0    Success - no non-ASCII violations found
    1    Failure - non-ASCII violations found
    2    Error - content directory not found
EOF
}

# Main execution
main() {
    # Handle help flag
    if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
        usage
        exit 0
    fi

    echo "Checking for non-ASCII characters in '$CONTENT_DIR'..."

    if violations=$(check_non_ascii "$CONTENT_DIR" "$ALLOWED_NON_ASCII"); then
        echo "✓ Success! No non-ASCII violations found."
        exit 0
    else
        echo "✗ Failure! Found non-ASCII violations:"
        echo "$violations"
        exit 1
    fi
}

# Only run main if script is executed directly (not sourced)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
