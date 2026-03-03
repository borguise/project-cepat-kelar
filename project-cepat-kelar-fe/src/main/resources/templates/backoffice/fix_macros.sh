#!/bin/bash

files=(
  "admin-audio-editor.ftl:audio:Admin - Editor Audio"
  "admin-collection-editor.ftl:koleksi:Admin - Editor Koleksi"
  "admin-event-editor.ftl:agenda:Admin - Editor Agenda"
  "admin-highlight-editor.ftl:sorotan:Admin - Editor Sorotan"
  "admin-voting-editor.ftl:voting:Admin - Editor Voting"
)

for item in "${files[@]}"; do
  IFS=':' read -r file page title <<< "$item"
  echo "Processing $file..."
  
  # Add opening macro after imports
  sed -i.bak "/<#import/a\\
<@layout.backofficeLayout title=\"$(echo $title)\" activePage=$page adminName=adminName>" "$file"
  
  # Replace closing tags  
  sed -i '' 's|</body>\n</html>|</@layout.backofficeLayout>|' "$file"
done

echo "Done!"
