IMAGE_TAG:=pvphan/nerfstudio:0.1

image:
	docker build . --tag ${IMAGE_TAG}

shell: image
	docker run \
		--rm \
		--interactive \
		--tty \
		--gpus=all \
		--user="$(id -u):$(id -g)" \
		${IMAGE_TAG} bash
