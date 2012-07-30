#!/bin/bash

#+ cli pkg builder

WORKING_DIR=$(/usr/bin/dirname "${0}")
OUTPUT_DIR=${WORKING_DIR}

/bin/echo "${0} searching ${WORKING_DIR}"
for PKG_POSTFLIGHT in `/usr/bin/find -L ${WORKING_DIR} -name "*.sh" | /usr/bin/grep -v "config.sh" | /usr/bin/grep -v "PAYLOAD" | /usr/bin/grep -v "REDUNDANT" | /usr/bin/grep -v "SOURCE" | /usr/bin/grep -v "TEMPLATES"`
do
 ROOT=$(/usr/bin/dirname "${PKG_POSTFLIGHT}")
 IDENTIFIER=$(/usr/bin/basename "${PKG_POSTFLIGHT}" | sed 's/.sh//g')
 DESCRIPTION=$(cat "${PKG_POSTFLIGHT}" | grep "Description:" | sed "s/#+ Description: //g")
 VERSION=$(cat "${PKG_POSTFLIGHT}" | grep "Version:" | sed 's/#+ Version: //g')
 
 /bin/echo "${0} Root: ${ROOT}"
 /bin/echo "${0} Identifier: ${IDENTIFIER}"
 /bin/echo "${0} Description: ${DESCRIPTION}"
 /bin/echo "${0} Version: ${VERSION}"
 
 /bin/echo "${0} Cleaning ${OUTPUT_DIR}/${IDENTIFIER}.pkg"
 /bin/rm -Rf "${OUTPUT_DIR}/${IDENTIFIER}.pkg"
 
 /bin/echo "${0} making ${OUTPUT_DIR}/RESOURCES"
 /bin/mkdir -p ${OUTPUT_DIR}/RESOURCES
 /bin/echo "${0} making ${OUTPUT_DIR}/ROOT/Library"
 /bin/mkdir -p ${OUTPUT_DIR}/ROOT/Library
 /bin/echo "${0} making ${OUTPUT_DIR}/SCRIPTS"
 /bin/mkdir -p ${OUTPUT_DIR}/SCRIPTS
 
 /bin/echo "${0} Copying ${PKG_POSTFLIGHT} to ${OUTPUT_DIR}/SCRIPTS/postflight"
 /bin/cp -f "${PKG_POSTFLIGHT}" ${OUTPUT_DIR}/SCRIPTS/postflight
 
 /bin/echo "${0} Hopefully Building com.chrisgerke.${IDENTIFIER} to ${OUTPUT_DIR}/${IDENTIFIER}.pkg"
 "/Applications/PackageMaker.app/Contents/MacOS/PackageMaker" --id "com.chrisgerke.${IDENTIFIER}" --title "${IDENTIFIER}" --version "${VERSION}" --resources ${OUTPUT_DIR}/RESOURCES --scripts ${OUTPUT_DIR}/SCRIPTS --root ${OUTPUT_DIR}/ROOT --out ${OUTPUT_DIR}/${IDENTIFIER}.pkg --verbose
 
 /bin/echo "${0} writing Description: ${DESCRIPTION} to ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/en.lproj/Description IFPkgDescriptionDescription"
 /usr/bin/defaults write ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/en.lproj/Description IFPkgDescriptionDescription "${DESCRIPTION}"
 
 #+ Config?
 if [ -r "${ROOT}/config.plist" ]; then
  /bin/cp -Rf "${ROOT}/config.plist" ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/config.plist
 fi
 if [ -r "${ROOT}/config.sh" ]; then
  /bin/cp -Rf "${ROOT}/config.sh" ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/config.sh
  ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/config.sh
 fi
 
 #+ Payload?
 if [ -r "${ROOT}/PAYLOAD" ]; then
  /bin/cp -R "${ROOT}/PAYLOAD" ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/
 fi
 
 #+ Readme
 if [ -r "${ROOT}/README.md" ]; then
  /bin/cp -f "${ROOT}/README.md" ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/
 fi
 
 /bin/echo "${0} cleaning ${OUTPUT_DIR}/RESOURCES"
 /bin/rm -Rf ${OUTPUT_DIR}/RESOURCES
 /bin/echo "${0} cleaning ${OUTPUT_DIR}/ROOT"
 /bin/rm -Rf ${OUTPUT_DIR}/ROOT
 /bin/echo "${0} cleaning ${OUTPUT_DIR}/SCRIPTS"
 /bin/rm -Rf ${OUTPUT_DIR}/SCRIPTS

done

exit 0