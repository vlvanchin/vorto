#!/bin/bash -e
#
# this script is to repackage repository jar with neccessory jars
#
# copying the mariadb java client
pwd
exit 1

mkdir ~/wgetDownload
wget -P ~/wgetDownload/ https://downloads.mariadb.com/Connectors/java/connector-java-2.3.0/mariadb-java-client-2.3.0.jar

# setting up artifact uploads to aws
mkdir -p ~/aws-upload/tmp

# copying the repository artifact to the aws-upload
cp ./repository/repository-server/target/infomodelrepository.jar ~/aws-upload/tmp
cd ~/aws-upload/tmp
jar -xvf infomodelrepository.jar
rm -f infomodelrepository.jar
cp ~/wgetDownload/mariadb-java-client-2.3.0.jar ./BOOT-INF/lib/
pwd
jar -cvf infomodelrepository-dbclient.jar .
cd ~
cp ~/aws-upload/tmp/infomodelrepository-dbclient.jar ~/aws-upload/${ARTIFACT_NAME}_${ELASTIC_BEANSTALK_LABEL}.jar
rm -rf ~/aws-upload/tmp
ls -l

# copying the official generators to the aws-upload folder
cp ~/generators/generator-runner/target/generator-runner-exec.jar ~/aws-upload/${GEN_ARTIFACT_NAME}_${ELASTIC_BEANSTALK_LABEL}.jar

# list the contents of aws-upload folder
ls -al ~/aws-upload

