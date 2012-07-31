#!/bin/bash

#+ cli pkg builder

WORKING_DIR=$(/usr/bin/dirname "${0}")
OUTPUT_DIR=${WORKING_DIR}
INSTAREADY_DIR=${OUTPUT_DIR}/InstaReady

/bin/mkdir -p "${INSTAREADY_DIR}"

/bin/echo "${0} searching ${WORKING_DIR}"
for PKG_POSTFLIGHT in `/usr/bin/find -L ${WORKING_DIR} -name "*.sh" | /usr/bin/grep -v "Config.sh" | /usr/bin/grep -v "Payload" | /usr/bin/grep -v "REDUNDANT" | /usr/bin/grep -v "Source" | /usr/bin/grep -v "TEMPLATES"`
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
 if [ -r "${ROOT}/${IDENTIFIER}Config.plist" ]; then
  /bin/cp -Rf "${ROOT}/${IDENTIFIER}Config.plist" ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/config.plist
 fi
 if [ -r "${ROOT}/${IDENTIFIER}Config.bash" ]; then
  /bin/cp -Rf "${ROOT}/${IDENTIFIER}Config.bash" ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/config.bash
  ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/config.bash
 fi
 
 #+ Payload?
 if [ -r "${ROOT}/${IDENTIFIER}Payload" ]; then
  /bin/cp -R "${ROOT}/${IDENTIFIER}Payload" ${OUTPUT_DIR}/${IDENTIFIER}.pkg/Contents/Resources/PAYLOAD
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
 
 /bin/rm -Rf "${INSTAREADY_DIR}/${IDENTIFIER}.pkg"
 /bin/mv -f "${OUTPUT_DIR}/${IDENTIFIER}.pkg" "${INSTAREADY_DIR}/"

done

exit 0