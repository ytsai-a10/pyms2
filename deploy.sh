# Change image or tag for your testing image/build
docker build -t sidp-ref-microservice-python:pyms2 .
docker tag sidp-ref-microservice-python:pyms2 us-phoenix-1.ocir.io/axqel8fpeyhe/sidp-ref-microservice-python:pyms2
docker push us-phoenix-1.ocir.io/axqel8fpeyhe/sidp-ref-microservice-python:pyms2

# Modify and deploy pyms2
#    ex: kubectl -f example/pyms2-wasm.yaml

# Modify and deploy example/vs-pyms2.yaml, if VirtualService is not there for your service
