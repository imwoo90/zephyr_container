# About
Easy Start Zephyr using docker container

# In my case, push docker hub for multi image
docker buildx build -t imwoo/zephyr:v3.4.0 --platform linux/amd64,linux/arm64 --push .
