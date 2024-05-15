# About
Easy Start nRF Connect SDK using docker container

# In my case, push docker hub for multi image
docker buildx build -t imwoo/ncs:v2.6.1 --platform linux/amd64,linux/arm64 --push .
