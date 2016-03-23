#!/bin/sh

dd=$(cd `dirname $0`; pwd)
echo $dd

dt=`date +%Y%m%d%H%M%S`
echo $dt

#tag=cmptech/auto_alpine_golang_with_gorun_dev
tag=cmptech/auto_alpine_golang_with_gorun

#build first
docker build -t $tag $dd

docker run $tag go version

docker run \
-v $dd/test.go:/gopath/test.go \
-w /gopath/ \
$tag gorun test.go

exit

#TODO:

# docker export + import will flat/shrink the image, but the ENV is lost.
cid=`docker run -d $tag /goroot/go version`
docker export ${cid} | docker import - ${tag}_tmp

echo docker run --rm -ti $tag go version
echo docker run --rm -ti ${tag}_tmp go version

#bash -c "export GOROOT=/goroot && /goroot/go version"
