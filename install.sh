#!/bin/bash
# Quick installer for QuickSearch

set -e

echo "🔍 Installing QuickSearch..."

# Create bin directory
mkdir -p ~/.local/bin/

# Copy main script
cp quicksearch.sh ~/.local/bin/
chmod +x ~/bin/quicksearch.sh

# Create all symbolic links
cd ~/.local/bin/
for cmd in so sf su se gh gist mdn godocs rustdocs pydocs aws man docs \
  npm pypi nixpkgs archpkg fedorapkg archwiki gentoowiki debianwiki \
  nixwiki susewiki voiddocs voidwiki fedoradocs linuxwiki yt reddit \
  wiki chatgpt perplexity claude ddg; do
  ln -sf quicksearch.sh search-$cmd
done

echo "✅ Installation complete!"
echo ""
echo "⚠️  Make sure ~/.local/bin is in your PATH. Add this to your shell config if needed:"
echo '    export PATH="$HOME/.local/bin:$PATH"'
echo ""
echo "🚀 Try it: search-so \"hello world\""
