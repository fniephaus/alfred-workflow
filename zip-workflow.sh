#!/bin/bash

rootdir=$(dirname "$0")
zipfile="${rootdir}/alfred-workflow.zip"
sourcedir="${rootdir}/workflow"

function help() {
cat << EOF
Create ZIP archive of workflow

  zip-workflow.sh -s, --show	Only show what would done
  zip-workflow.sh -h, --help	Show this message

EOF
}

show=0

case "$1" in
	-h|--help)
		help
		exit 0
		;;
	-s|--show)
		show=1
		;;
	*)
		;;
esac

# echo "\$rootdir : ${rootdir}	\$zipfile : ${zipfile}	\$sourcedir : ${sourcedir}"
# exit 0

if [[ -f "${zipfile}" ]] && [[ $show -eq 0 ]]; then
	echo "Deleting existing zip archive"
	rm -f "${zipfile}"
fi


if [[ $show -eq 1 ]]; then
	zip -sf -r ${zipfile} ${sourcedir} -i '*.py'
	status=$?
else
	zip -r ${zipfile} ${sourcedir} -i '*.py'
	status=$?
fi

if [[ $status -gt 0 ]]; then
	echo "ERROR: zip returned ${status}"
	exit $status
else
	if [[ $show -eq 0 ]]; then
		echo "Created ${zipfile}"
	fi
fi
