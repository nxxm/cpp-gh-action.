#!/bin/bash

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "The GITHUB_TOKEN is required."
	exit 1
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nxxm/nxxm/master/install/install_for_macos_linux.sh)"

cd $GITHUB_WORKSPACE


if [ "$INPUT_ONLY_EXE" == "enable" ]
 then
/usr/local/bin/nxxm $GITHUB_WORKSPACE  -t "$INPUT_TARGET" -C "$INPUT_CONFIGURATION" -j "$INPUT_CPUS" -o --verbose 
if [ $? -ne 0 ]; then
echo "An error has occurred."
echo "Please look at the logs."
	exit 1
fi
 elif [ "$INPUT_USE_CMAKE" == "enable" ]
 /usr/local/bin/nxxm $GITHUB_WORKSPACE  -t "$INPUT_TARGET" -C "$INPUT_CONFIGURATION" -j "$INPUT_CPUS" -u --verbose 
 if [ $? -ne 0 ]; then
echo "An error has occurred."
echo "Please look at the logs."
	exit 1
fi
elif [ "$INPUT_USE_CMAKE" == "enable" ] && [ "$INPUT_USE_CMAKE" == "enable" ]
 /usr/local/bin/nxxm $GITHUB_WORKSPACE  -t "$INPUT_TARGET" -C "$INPUT_CONFIGURATION" -j "$INPUT_CPUS" -u -o --verbose 
 if [ $? -ne 0 ]; then
echo "An error has occurred."
echo "Please look at the logs."
	exit 1
fi
else 
 /usr/local/bin/nxxm $GITHUB_WORKSPACE  -t "$INPUT_TARGET" -C "$INPUT_CONFIGURATION" -j "$INPUT_CPUS"  --verbose 
 if [ $? -ne 0 ]; then
echo "An error has occurred."
echo "Please look at the logs."
	exit 1
fi
fi


zip -r build.zip ./build






