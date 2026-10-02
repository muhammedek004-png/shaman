#!/bin/bash
# Auto-commit and push script for automatic web updates
# Place this file in your project root and run: chmod +x auto-push.sh && ./auto-push.sh

echo "🚀 Auto-push watcher enabled..."
echo "Any changes to index.html will automatically commit and deploy to Vercel"
echo ""

# Watch for file changes
while true; do
  # Get current file modification time
  CURRENT_TIME=$(stat -f%m index.html 2>/dev/null || stat -c%Y index.html 2>/dev/null)
  
  if [ ! -z "$LAST_TIME" ] && [ "$CURRENT_TIME" != "$LAST_TIME" ]; then
    echo "✨ Changes detected in index.html!"
    echo "📤 Committing and pushing to GitHub..."
    
    git add -A
    git commit -m "Auto-update: Changes to index.html - $(date '+%Y-%m-%d %H:%M:%S')"
    git push
    
    echo "✅ Pushed to GitHub! Vercel will auto-deploy in seconds..."
    echo "🌐 Live at: https://report-sigma-indol.vercel.app"
    echo ""
  fi
  
  LAST_TIME="$CURRENT_TIME"
  sleep 2  # Check every 2 seconds
done
