# About
Easy Start Zephyr using docker container

# In my case, push docker hub for multi image
docker buildx build -t imwoo/zephyr:v3.3.0-rc3 --platform linux/amd64,linux/arm64 --push .
