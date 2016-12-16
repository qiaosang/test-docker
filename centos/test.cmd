set TEST_NAME=centos

docker build -t %TEST_NAME% .

docker run -d --name %TEST_NAME% %TEST_NAME% date

docker logs -f %TEST_NAME%