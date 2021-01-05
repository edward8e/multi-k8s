docker build -t edward8e/multi-client:latest -t edward8e/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t edward8e/multi-server:latest -t edward8e/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t edward8e/multi-worker:latest -t edward8e/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push edward8e/multi-client:latest
docker push edward8e/multi-server:latest
docker push edward8e/multi-worker:latest

docker push edward8e/multi-client:$SHA
docker push edward8e/multi-server:$SHA
docker push edward8e/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=edward8e/multi-server:$SHA
kubectl set image deployments/client-deployment client=edward8e/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=edward8e/multi-worker:$SHA