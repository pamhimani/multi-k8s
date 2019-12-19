docker build -t pamhimani/multi-client:latest -t pamhimani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pamhimani/multi-server:latest -t pamhimani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pamhimani/multi-worker:latest -t pamhimani/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pamhimani/multi-client:latest 
docker push pamhimani/multi-server:latest
docker push pamhimani/multi-worker:latest
docker push pamhimani/multi-client:$SHA
docker push pamhimani/multi-server:$SHA
docker push pamhimani/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pamhimani/multi-server:$SHA
kubectl set image deployments/client-deployment client=pamhimani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pamhimani/multi-worker:$SHA