# About
Easy Start nRF Connect SDK using docker container

# In my case, push docker hub for multi image
docker buildx build -t imwoo/zephyr:ncs_v2.4.2 --platform linux/amd64,linux/arm64 --push .
