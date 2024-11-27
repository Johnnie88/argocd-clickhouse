#!/bin/bash

# Function to install Helm
install_helm() {
    echo "Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    echo "Helm installed successfully."
}

# Function to install ArgoCD
install_argocd() {
    echo "Installing ArgoCD..."
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    echo "ArgoCD installed successfully."
}

# Function to setup Helm repository for ArgoCD
setup_helm_repo() {
    echo "Setting up Helm repository for ArgoCD..."
    helm repo add argo https://argoproj.github.io/argo-helm
    helm repo update
    echo "Helm repository for ArgoCD set up successfully."
}

# Function to install ArgoCD using Helm
install_argocd_helm() {
    echo "Installing ArgoCD using Helm..."
    helm install argo-cd argo/argo-cd --namespace argocd --create-namespace
    echo "ArgoCD installed using Helm successfully."
}

# Display menu
while true; do
    echo "Select an option:"
    echo "1. Install Helm"
    echo "2. Install ArgoCD"
    echo "3. Setup Helm repository for ArgoCD"
    echo "4. Install ArgoCD using Helm"
    echo "5. Exit"
    read -p "Enter your choice [1-5]: " choice

    case $choice in
        1) install_helm ;;
        2) install_argocd ;;
        3) setup_helm_repo ;;
        4) install_argocd_helm ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice. Please select a valid option." ;;
    esac
done