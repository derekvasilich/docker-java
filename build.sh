set e+x

TAG=derekvasilich/docker-java:latest

echo "Building $TAG"
docker build -t $TAG .

echo "Pushing $TAG"
docker push $TAG