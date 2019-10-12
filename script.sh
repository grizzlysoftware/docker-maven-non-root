#!/bin/bash
repository="grizzlysoftware/maven-non-root"
jdk_template="__JDK_VERSION__"
mvn_template="__MAVEN_VERSION__"
templateDockerFile="mnr-dockerfile.template"
templateSettingsFile="settings.xml"
jdks=("11.0.4-jdk-stretch" "8u222-jdk-stretch")
mvns=("3.6.2" "3.6.1" "3.6.0" "3.5.4" "3.5.3" "3.5.2" "3.5.0" "3.3.9". "3.3.3" "3.3.1" "3.2.5" "3.2.3" "3.2.2" "3.2.1" "3.1.1" "3.1.0" "3.0.5" "3.0.4" "3.0.3" "3.0.2" "3.0.1" "3.0")
dockerHost="localhost:2375"
for jdk in "${jdks[@]}" 
do
	for maven in "${mvns[@]}"
	do
		startLocation=$(pwd)
		echo "$startLocation"
		tag=$maven-$jdk
		location=$tag
		#create directory
		mkdir -p $location
		#copy template file 
		cp $templateDockerFile $location/Dockerfile 
		cp $templateSettingsFile $location/settings.xml
		#replace templates
		sed -i -e "s/$jdk_template/$jdk/g" $location/Dockerfile 
		sed -i -e "s/$mvn_template/$maven/g" $location/Dockerfile 
		#run docker build
		cd $location
		docker -H $dockerHost build . --tag $repository:$tag
		dockerResult=$?
		cd $startLocation
		echo "$(pwd)"
		if [ $dockerResult -ne 0 ] 
		then
			rm -rf $location
		else
			docker -H $dockerHost push $repository:$tag
		fi
	done
done