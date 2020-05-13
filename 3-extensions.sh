#!/bin/sh

read -p "list all extensions"
mvn quarkus:list-extensions


read -p "add an extension"

grep metrics pom.xml

read
mvn quarkus:add-extension -Dextensions="metrics"

grep metrics pom.xml

exit 0