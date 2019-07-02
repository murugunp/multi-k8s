docker build -t murugun9/multi-client:latest -t murugun9/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t murugun9/multi-server:latest -t murugun9/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t murugun9/multi-worker:latest -t murugun9/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push murugun9/multi-client:latest
docker push murugun9/multi-server:latest
docker push murugun9/multi-worker:latest
docker push murugun9/multi-client:$SHA
docker push murugun9/multi-server:$SHA
docker push murugun9/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=murugun9/multi-server:$SHA
kubectl set image deployments/client-deployment client=murugun9/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=murugun9/multi-worker:$SHA