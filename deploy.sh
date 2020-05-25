docker build -t michaeljkavanagh/multi-client:latest -t michaeljkavanagh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t michaeljkavanagh/multi-server:latest -t michaeljkavanagh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t michaeljkavanagh/multi-worker:latest -t michaeljkavanagh/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push michaeljkavanagh/multi-client:latest
docker push michaeljkavanagh/multi-server:latest
docker push michaeljkavanagh/multi-worker:latest 

docker push michaeljkavanagh/multi-client:$SHA
docker push michaeljkavanagh/multi-server:$SHA
docker push michaeljkavanagh/multi-worker:$SHA 

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=michaeljkavanagh/multi-server:$SHA
kubectl set image deployments/client-deployment client=michaeljkavanagh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=michaeljkavanagh/multi-worker:$SHA