#!/bin/bash
set -e

template="./assets/post_template.md"
list="./assets/corinthiale.csv"

IFS=','
read -a headers
while read -a line ; do
	# Copy template
	#post_file="$HOME/""${line[4]}"-"${line[0]}".md
	post_file="./_posts/""${line[4]}"-"${line[0]}".md
	cp "$template" "$post_file"

	# Substitute data into template
	for i in "${!line[@]}"; do
		# Remove double quotes
		line[i]="${line[i]%\"}"
		line[i]="${line[i]#\"}"

		#echo "${headers[i]}: ${line[i]}"
		sed -i "s/@"${headers[i]}"@/"${line[i]}"/g" "$post_file"
	done
	# Capitalize id for title
	id_c="${line[0]}"
	id_c="${id_c^^}"
	sed -i "s/@ID-C@/"$id_c"/g" "$post_file"
done

