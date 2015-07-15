#!/bin/bash

# Licensed Materials - Property of IBM
# 5725-I43 (C) Copyright IBM Corp. 2006, 2013. All Rights Reserved.
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp.

# Update buildtime in project
echo -n ${TARGET_BUILD_DIR}/${PRODUCT_NAME}.app/worklight.plist | xargs -0 /usr/libexec/PlistBuddy -c "Set :buildtime `date +\"%s\"`"
