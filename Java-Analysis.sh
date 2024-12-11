#!/bin/bash

# Define the directory containing decoded JavaScript files
decoded_dir="./Decoded_Javascript"

# Ensure the directory exists
if [ ! -d "$decoded_dir" ]; then
  echo "Decoded_Javascript directory does not exist."
  exit 1
fi

# Loop through all decoded JavaScript files in the directory
for js_file in "$decoded_dir"/*.js; do
  # Check if the file exists and is readable
  if [ ! -f "$js_file" ]; then
    echo "File $js_file not found or is not readable."
    continue
  fi

  echo "=================================================================="
  echo "Processing $js_file..."
  echo "=================================================================="

  # Extract function declarations
  echo "Functions found:"
  grep -oE '\bfunction\s+\w+' "$js_file" | sort | uniq
  echo

  # Extract variable declarations (var, let, const)
  echo "Variables declared:"
  grep -oE '\b(var|let|const)\s+\w+' "$js_file" | sort | uniq
  echo

  # Extract comments
  echo "Comments found:"
  grep -oE '//.*|/\*[^*]*\*/' "$js_file" | sort | uniq
  echo

  # Function calls
  echo "Function calls found:"
  grep -oE '\b\w+\s*\(' "$js_file" | sort | uniq
  echo

  # AJAX calls
  echo "AJAX calls found:"
  grep -oE '\.(ajax|get|post|fetch|xmlHttpRequest)\s*\(' "$js_file" | sort | uniq
  echo

  # Regular expressions
  echo "Regular expressions found:"
  grep -oE '/[^/]+/' "$js_file" | sort | uniq
  echo

  # DOM manipulation
  echo "DOM manipulation methods found:"
  grep -oE '\b(document\.\w+|\$\([^)]+\))' "$js_file" | sort | uniq
  echo

  # External URLs
  echo "External resources/URLs found:"
  grep -oE 'https?://[^\s"\']+' "$js_file" | sort | uniq
  echo

  # Suspicious or dangerous code patterns
  echo "Potential vulnerabilities or suspicious code:"
  grep -oE '(eval\(.*\)|exec\(.*\)|dangerouslySetInnerHTML|innerHTML\s*=)' "$js_file" | sort | uniq
  echo

  # Arrow functions
  echo "Arrow functions found:"
  grep -oE '\b\w+\s*=>\s*\{' "$js_file" | sort | uniq
  echo

  # Class declarations
  echo "Class declarations found:"
  grep -oE '\bclass\s+\w+' "$js_file" | sort | uniq
  echo

  # ES6 import/export
  echo "ES6 import/export statements found:"
  grep -oE '\b(import|export)\s+\S+' "$js_file" | sort | uniq
  echo

  # Template literals
  echo "Template literals found:"
  grep -oE '`[^`]+`' "$js_file" | sort | uniq
  echo

  # Timers (setTimeout and setInterval)
  echo "Timer methods found:"
  grep -oE '\b(setTimeout|setInterval)\s*$begin:math:text$' "$js_file" | sort | uniq
  echo

  # try...catch blocks
  echo "try...catch blocks found:"
  grep -oE '\\btry\\s*\\{.*?\\}\\s*catch\\s*\\([^)]*$end:math:text$\s*\{' "$js_file" | sort | uniq
  echo

  # Window/document interactions
  echo "Window/document interactions found:"
  grep -oE '\b(window\.\w+|document\.\w+)' "$js_file" | sort | uniq
  echo

  # Event listeners (potential memory leaks)
  echo "Potential uncleaned event listeners:"
  grep -oE '\baddEventListener\s*$begin:math:text$' "$js_file" | sort | uniq
  echo

  # Function parameters
  echo "Function parameter definitions found:"
  grep -oE '\\bfunction\\s+\\w+\\s*\\([^)]*$end:math:text$' "$js_file" | sort | uniq
  echo

  # Async patterns (async/await, Promises)
  echo "Asynchronous patterns found:"
  grep -oE '\b(async\s+function|await|Promise\.\w+)' "$js_file" | sort | uniq
  echo

  # Deprecated functions
  echo "Deprecated functions found:"
  grep -oE '\b(document\.write|alert|confirm|prompt)\b' "$js_file" | sort | uniq
  echo
done
