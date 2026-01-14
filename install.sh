#!/bin/bash

set -e

REPO_BASE="https://raw.githubusercontent.com/promethus/agent-browser-skill/main" # Placeholder URL, will need to be updated with actual user/repo
CLAUDE_DIR="$HOME/.claude/skills"
SKILL_DIR="$CLAUDE_DIR/agent-browser"

GREEN='\033[0;32m'
GRAY='\033[0;90m'
NC='\033[0m'

echo ""
echo -e "${GRAY}Installing agent-browser skill...${NC}"

# 1. Install the CLI tool
if ! command -v agent-browser &> /dev/null; then
    echo -e "${GRAY}Installing agent-browser CLI via npm...${NC}"
    if ! command -v npm &> /dev/null; then
        echo "Error: npm is required to install agent-browser."
        exit 1
    fi
    npm install -g agent-browser
    agent-browser install
else
    echo -e "${GREEN}✓ agent-browser CLI already installed${NC}"
fi

# 2. Install the Skill
echo -e "${GRAY}Setting up Claude skill...${NC}"
mkdir -p "$SKILL_DIR"

# In a real scenario, we would curl from the repo. 
# For local dev, we might copy, but let's assume this script is run from the repo or curl'd.
# We'll use the local file if it exists (dev mode), otherwise curl.

if [ -f "SKILL.md" ]; then
    cp "SKILL.md" "$SKILL_DIR/SKILL.md"
else
    # Fallback to downloading (placeholder logic)
    # curl -sSL "$REPO_BASE/SKILL.md" -o "$SKILL_DIR/SKILL.md"
    echo "SKILL.md not found in current directory. Please run this script from the repo root."
    exit 1
fi

echo ""
echo -e "${GREEN}> /agent-browser skill installed successfully${NC}"
echo -e "${GRAY}  Location: $SKILL_DIR/SKILL.md${NC}"
echo ""
exit 0
