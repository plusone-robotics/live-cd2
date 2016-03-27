#!/bin/bash

set -e
#set -x

git clone -b v2.2.2 https://github.com/github/hub.git;
(cd hub; ./script/build; sudo cp hub /usr/local/bin/)

mkdir -p ~/.config/
echo "github.com:" > ~/.config/hub
echo "- user: k-okada" >> ~/.config/hub
echo "  oauth_token: $GITHUB_ACCESS_TOKEN" >> ~/.config/hub
for isf in $CIRCLE_ARTIFACTS/*.iso ; do 
    hub release create -p -a $iso -m "$CIRCLE_TAG"$'\n'"Released on `date '+%Y/%m/%d %H:%M:%S'`" $CIRCLE_TAG;
done

