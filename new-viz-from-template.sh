#!/bin/bash

set -e

# function to calculate week number from date
get_week_number() {
    local date=$1
    # Convert date to week number (ISO week)
    local week=$(date -d "$date" +%V)
    # Remove leading zero if present
    week=$((10#$week))
    # Remove as it is for the week before
    week=$((week - 1))
    echo $week
}

# check arguments
if [ $# -ne 3 ]; then
    echo "Usage: $0 <date> <language> <title>"
    echo "Example: $0 2024-12-10 r 'Coffee Data Analysis'"
    echo "Language options: r, python"
    echo "Creates structure: challenges/YYYY/YYYY_WW_Title/language/YYYY_WW_Title.qmd"
    exit 1
fi

DATE=$1
LANGUAGE=$2
TITLE=$3

# validate language
if [[ "$LANGUAGE" != "r" && "$LANGUAGE" != "python" ]]; then
    echo "Error: Language must be 'r' or 'python'"
    exit 1
fi

# validate date format
if ! echo "$DATE" | grep -qE '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$'; then
    echo "Error: Date must be in YYYY-MM-DD format"
    exit 1
fi

YEAR=$(echo $DATE | cut -d'-' -f1)
WEEK_NUM=$(get_week_number $DATE)

# pad week number to two digits
printf -v WEEK_PAD "%02d" $WEEK_NUM

# sanitize title: replace spaces and other characters with underscore
TITLE_SAFE=$(echo "$TITLE" | sed -E 's/[^a-zA-Z0-9]+/_/g' | sed -E 's/^_+|_+$//g')

# build folder and filename
CHALLENGE_DIR="challenges/${YEAR}/${YEAR}_${WEEK_PAD}_${TITLE_SAFE}"
LANG_DIR="${CHALLENGE_DIR}/${LANGUAGE}"
QMD_FILE="${LANG_DIR}/${YEAR}_${WEEK_PAD}_${TITLE_SAFE}.qmd"

# create dirs
mkdir -p "$LANG_DIR"

if [ -f "$QMD_FILE" ]; then
    echo "Error: File $QMD_FILE already exists"
    exit 1
fi

# copy template
cp template.qmd "$QMD_FILE"

# replace placeholders (macOS/Linux)
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/{{TITLE}}/$TITLE/g" "$QMD_FILE"
    sed -i '' "s/{{DATE}}/$DATE/g" "$QMD_FILE"
    sed -i '' "s/{{LANGUAGE}}/$LANGUAGE/g" "$QMD_FILE"
    if [ "$LANGUAGE" = "r" ]; then
        sed -i '' "s/{{LANGUAGE_UPPER}}/R/g" "$QMD_FILE"
        sed -i '' "s/{{LANGUAGE_CODE}}/r/g" "$QMD_FILE"
        sed -i '' "s/{{LANGUAGE_EXT}}/R/g" "$QMD_FILE"
        sed -i '' "s/{{CATEGORIES}}/ggplot2, tidyverse, data-viz/g" "$QMD_FILE"
        sed -i '' "s/{{TOOLS_USED}}/R, ggplot2, tidyverse/g" "$QMD_FILE"
        sed -i '' "s/{{KEY_LIBRARIES}}/ggplot2, dplyr, tidyr/g" "$QMD_FILE"
        sed -i '' "s/{{IMAGE_FILE}}/plot.svg/g" "$QMD_FILE"
    else
        sed -i '' "s/{{LANGUAGE_UPPER}}/Python/g" "$QMD_FILE"
        sed -i '' "s/{{LANGUAGE_CODE}}/python/g" "$QMD_FILE"
        sed -i '' "s/{{LANGUAGE_EXT}}/py/g" "$QMD_FILE"
        sed -i '' "s/{{CATEGORIES}}/matplotlib, pandas, data-viz/g" "$QMD_FILE"
        sed -i '' "s/{{TOOLS_USED}}/Python, pandas, matplotlib, seaborn/g" "$QMD_FILE"
        sed -i '' "s/{{KEY_LIBRARIES}}/pandas, matplotlib, seaborn/g" "$QMD_FILE"
        sed -i '' "s/{{IMAGE_FILE}}/plot.png/g" "$QMD_FILE"
    fi
else
    sed -i "s/{{TITLE}}/$TITLE/g" "$QMD_FILE"
    sed -i "s/{{DATE}}/$DATE/g" "$QMD_FILE"
    sed -i "s/{{LANGUAGE}}/$LANGUAGE/g" "$QMD_FILE"
    if [ "$LANGUAGE" = "r" ]; then
        sed -i "s/{{LANGUAGE_UPPER}}/R/g" "$QMD_FILE"
        sed -i "s/{{LANGUAGE_CODE}}/r/g" "$QMD_FILE"
        sed -i "s/{{LANGUAGE_EXT}}/R/g" "$QMD_FILE"
        sed -i "s/{{CATEGORIES}}/ggplot2, tidyverse, data-viz/g" "$QMD_FILE"
        sed -i "s/{{TOOLS_USED}}/R, ggplot2, tidyverse/g" "$QMD_FILE"
        sed -i "s/{{KEY_LIBRARIES}}/ggplot2, dplyr, tidyr/g" "$QMD_FILE"
        sed -i "s/{{IMAGE_FILE}}/plot.svg/g" "$QMD_FILE"
    else
        sed -i "s/{{LANGUAGE_UPPER}}/Python/g" "$QMD_FILE"
        sed -i "s/{{LANGUAGE_CODE}}/python/g" "$QMD_FILE"
        sed -i "s/{{LANGUAGE_EXT}}/py/g" "$QMD_FILE"
        sed -i "s/{{CATEGORIES}}/matplotlib, pandas, data-viz/g" "$QMD_FILE"
        sed -i "s/{{TOOLS_USED}}/Python, pandas, matplotlib, seaborn/g" "$QMD_FILE"
        sed -i "s/{{KEY_LIBRARIES}}/pandas, matplotlib, seaborn/g" "$QMD_FILE"
        sed -i "s/{{IMAGE_FILE}}/plot.png/g" "$QMD_FILE"
    fi
fi

echo "Created new visualization:"
echo "   $QMD_FILE"
echo ""
echo "Next steps:"
echo " - Edit $QMD_FILE to add your analysis"
echo " - Save visualizations to ${LANGUAGE}/${YEAR}/${YEAR}_${WEEK_PAD}_${TITLE_SAFE}/ directory"
echo " - Update image paths if needed"
echo " - Run 'quarto render' to build the site"