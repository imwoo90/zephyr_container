# About
Easy Start Zephyr using docker container

# In my case, push docker hub for multi image
docker buildx build -t imwoo/zephyr:backport-52519-to-v2.7-branch --platform linux/amd64,linux/arm64 --push .
