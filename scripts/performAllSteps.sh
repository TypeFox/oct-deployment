#!/bin/bash

path_cghr=$(realpath $(dirname "${BASH_SOURCE[0]}"))
. ${path_cghr}/../.env

${path_cghr}/setup/updateServiceAccounts.sh

${path_cghr}/setup/createBuildsConnection.sh

${path_cghr}/setup/createBuildsRepository.sh

${path_cghr}/setup/createArtifactsRepository.sh

${path_cghr}/setup/createBuildsTrigger.sh
