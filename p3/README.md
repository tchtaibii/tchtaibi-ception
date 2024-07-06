# k3d and Argo CD Setup with Deployment

## Table of Contents

1. [Introduction](#introduction)
   - [Overview of the Setup](#overview-of-the-setup)
2. [Scripts Overview](#scripts-overview)
   - [`run.sh`](#runsh)
   - [`setup.sh`](#setupsh)
   - [`service.yml`](#serviceyml)
   - [`deployment.yml`](#deploymentyml)
   - [`argo.yml`](#argoyml)
3. [Step-by-Step Execution](#step-by-step-execution)
   - [Running `run.sh`](#running-runsh)
4. [Detailed Explanation](#detailed-explanation)
   - [What Each Script Does](#what-each-script-does)
5. [Accessing the Services](#accessing-the-services)
   - [Accessing Argo CD](#accessing-argo-cd)
   - [Accessing the Application](#accessing-the-application)

---

## 1. Introduction

### Overview of the Setup

This guide outlines the setup and deployment process using k3d and Argo CD. The `run.sh` script automates the setup of a k3d cluster, installs necessary tools, deploys Argo CD, and configures and deploys an application using Argo CD.

---

## 2. Scripts Overview

### `run.sh`

The main script to be executed. It checks for root privileges, sets up the environment, patches the Argo CD service to NodePort, applies Kubernetes deployments, and sets up port forwarding for the Argo CD server.

### `setup.sh`

A script to install Homebrew, Docker, kubectl, and k3d if they are not already installed. It then creates a k3d cluster and namespaces, and installs Argo CD in the `argocd` namespace.

### `service.yml`

A Kubernetes Service manifest that exposes the application using a NodePort.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
  namespace: dev
spec:
  selector:
    app: myapp
  ports:
  - name: dev
    port: 80
    targetPort: 8888
    nodePort: 30001
  type: NodePort
```
### `deployment.yml`

A Kubernetes Deployment manifest for deploying a simple application.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  namespace: dev
spec:
  replicas: 1
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: wil42/playground
        ports:
        - containerPort: 8888
````
This manifest deploys a single replica of an application container using the wil42/playground:v[] Docker image. It exposes port 8888 within the container.

## 3. Step-by-Step Execution

### Running `run.sh`

To deploy the application defined in `deployment.yml` and configure the setup using k3d and Argo CD, follow these steps:

1. **Make sure you have root privileges**:
   Ensure you run the script with `sudo` as it checks for root user.

2. **Execute the script**:
   ```sh
   sudo sh run.sh

   ## Accessing Argo CD

After running `run.sh`, navigate to `http://localhost:9000` in your web browser to access the Argo CD UI. Use the initial admin password obtained from the Argo CD secret to log in.

## Accessing the Application

The application deployed using `deployment.yml` is accessible via a NodePort service. Use the following URL format to access it:
Replace `<NodeIP>` and `<NodePort>` with the IP address and NodePort of your Kubernetes node where the application is deployed.

