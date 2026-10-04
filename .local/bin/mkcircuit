#! /bin/bash
# Enhanced TikZ diagram generator with color and transparency options
# Usage: ./generate_diagram.sh INPUT.m4 [--color=COLOR] [--density=DPI] [--transparent=COLOR]
set -euo pipefail  # Better error handling

# Default values
COLOR="black"
DENSITY=300
TRANSPARENT="white"
M4_PATH="$HOME/texmf/circuit_macros"



# Usage help function
usage() {
    cat <<EOF
Usage: $0 [OPTIONS] INPUT.m4
Circuit macro warper ! 
Generate TikZ diagrams from M4 source files using circuir macro.

Options:
  -h, --help            Show this help message and exit
  -c, --color=COLOR     Set diagram color name
                        Examples: red,blue, green
                        for custom colors add to this script
  -d, --density=DPI     Output image DPI (default: 300)
  -t, --transparent=COLOR  Color to make transparent (default: white)

Examples:
  $0 circuit.m4 --color=blue
  $0 circuit.m4 -c=red-d 600 -t white 
EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -c | --color=*)
            COLOR="${1#*=}"
            shift
            ;;
        -d | --density=*)
            DENSITY="${1#*=}"
            shift
            ;;
        -t | --transparent=*)
            TRANSPARENT="${1#*=}"
            shift
            ;;
        *)
            INPUT=$(realpath "$1")
            INPUT="${INPUT%.m4}"
            shift
            ;;
    esac
done

# Validate input
if [[ ! -f "${INPUT}.m4" ]]; then
    echo "Error: Input file ${INPUT}.m4 not found" >&2
    exit 1
fi

TMP_DIR=$(mktemp -d)
TMP_FILE="${TMP_DIR}/picture.tex"

trap 'rm -rf "$TMP_DIR"' EXIT  # Auto-cleanup on exit


echo "Processing in temporary directory: $TMP_DIR"

# Generate LaTeX document
cat > "${TMP_DIR}/picture.tex" <<EOF
\documentclass[11pt]{article}
\usepackage{tikz}
\usepackage{xcolor}  % For color support
\usetikzlibrary{external}
\tikzexternalize
\pagestyle{empty}
\definecolor{cs_blue}{RGB}{0,32,96}
EOF

echo "\begin{document}" >> $TMP_FILE
echo "\color{$COLOR}" >> "${TMP_DIR}/picture.tex"

# Process diagram with m4 and dpic
if ! m4 -I"${M4_PATH}" pgf.m4 libcct.m4 "${INPUT}.m4" | dpic -g >> "${TMP_DIR}/picture.tex"; then
    echo "Error in m4/dpic processing" >&2
    exit 1
fi


cat >> "${TMP_DIR}/picture.tex" <<EOF
\end{document}
EOF

# Compile LaTeX
(
    cd "$TMP_DIR" || exit 1
    if ! pdflatex -shell-escape -interaction=nonstopmode picture.tex >/dev/null; then
        echo "LaTeX compilation failed" >&2
        cat $TMP_DIR/picture.tex
        exit 1
    fi
)


# Handle output files
if [[ -f "${TMP_DIR}/picture-figure0.pdf" ]]; then
    cp "${TMP_DIR}/picture-figure0.pdf" "${INPUT}.pdf"
else
    echo "Warning: Expected output PDF not found" >&2
fi

# Convert to PNG
if ! magick -density "$DENSITY" "${INPUT}.pdf" -transparent "$TRANSPARENT" "${INPUT}.png"; then
    echo "ImageMagick conversion failed" >&2
    exit 1
fi

echo "Successfully generated:"
echo "- ${INPUT}.pdf"
rm "${INPUT}.pdf"
echo "- ${INPUT}.png"

