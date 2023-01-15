IMAGE_TAG:=pvphan/nerfstudio:0.1
REPO_PATH=$(HOME)/git/nerfstudio

image:
	docker build . --tag ${IMAGE_TAG}

shell: image
	docker run \
		--rm \
		--interactive \
		--tty \
		--gpus=all \
		--network=host \
		--volume=${REPO_PATH}:/root/nerfstudio \
		${IMAGE_TAG} bash
