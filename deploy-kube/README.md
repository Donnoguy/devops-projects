# Deploying a Node.js Application to Kubernetes using Minikube

This guide walks you through deploying a Node.js application to a Kubernetes cluster using Minikube. It covers creating a Node.js app, Dockerizing it, pushing the image to Docker Hub, and deploying it to Kubernetes.

## Prerequisites
- [Node.js](https://nodejs.org/) installed
- [Docker](https://www.docker.com/get-started) installed
- [Minikube](https://minikube.sigs.k8s.io/docs/start/) installed
- [Kubectl](https://kubernetes.io/docs/tasks/tools/) installed

---

## 1. Create a Simple Node.js Application

---

## 2. Create a Dockerfile
Create a `Dockerfile` in the same directory:
```dockerfile
FROM node:latest
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]
```

---

## 3. Build and Test the Docker Image
Build the Docker image:
```sh
docker build -t your-dockerhub-username/node-app .
```
Run the container locally:
```sh
docker run -p 3000:3000 your-dockerhub-username/node-app
```
Test in the browser: `http://localhost:3000`

---

## 4. Push the Image to Docker Hub
Login to Docker Hub:
```sh
docker login
```
Push the image:
```sh
docker push your-dockerhub-username/node-app
```

---

## 5. Setup Kubernetes Deployment and Service

### Create `deployment.yaml`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: node-app-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: node-app
  template:
    metadata:
      labels:
        app: node-app
    spec:
      containers:
      - name: node-app
        image: your-dockerhub-username/node-app:latest
        ports:
        - containerPort: 3000
```

### Create `service.yaml`
```yaml
apiVersion: v1
kind: Service
metadata:
  name: node-app-service
spec:
  type: LoadBalancer
  selector:
    app: node-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
```

---

## 6. Deploy to Kubernetes
Start Minikube:
```sh
minikube start
```
Apply the deployment:
```sh
kubectl apply -f deployment.yaml
```
Apply the service:
```sh
kubectl apply -f service.yaml
```
Verify the deployment:
```sh
kubectl get deployments
kubectl get pods
kubectl get svc
```

Get the application URL:
```sh
minikube service node-app-service --url
```

Open the URL in a browser to test your application.

---

## Conclusion
- Create a simple Node.js application
- Dockerize the application
- Push the Docker image to Docker Hub
- Deploy the application to Kubernetes using Minikube

Your application is now running in a Kubernetes cluster!
