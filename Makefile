IMAGE_TAG:=pvphan/nerfstudio:0.1
REPO_PATH:=$(dir $(abspath $(firstword $(MAKEFILE_LIST))))
RUN_FLAGS:=--rm \
	--interactive \
	--tty \
	--gpus=all \
	--network=host \
	--volume=${REPO_PATH}:/root/nerfstudio \
	--user="$(id -u):$(id -g)" \

demo: image
	docker run \
		${RUN_FLAGS} \
		${IMAGE_TAG} ./demo.sh

shell: image
	docker run \
		${RUN_FLAGS} \
		${IMAGE_TAG} bash

image:
	docker build . --tag ${IMAGE_TAG}
