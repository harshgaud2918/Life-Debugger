docker container stop ld_api
docker container rm ld_api
sudo docker build . -t ld_api_image
sudo docker run -d --name ld_api -p 8000:8000 ld_api_image 