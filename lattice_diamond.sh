#!/bin/bash

echo "Please enter the path to the tar installation file: "
read path

rpm -K "$path"
