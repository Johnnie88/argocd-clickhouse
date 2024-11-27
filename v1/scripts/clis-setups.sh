#!/bin/bash

# Function to update package list and install prerequisites
install_prerequisites() {
    echo "Updating package list and installing prerequisites..."
    sudo apt-get update
    sudo apt-get install -y curl apt-transport-https lsb-release gnupg
    echo "Prerequisites installed successfully."
}

# Function to install Argo CD CLI
install_argocd_cli() {
    echo "Installing Argo CD CLI..."
    VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
    curl -sSL -o argocd-linux-amd64 "https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64"
    sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
    rm argocd-linux-amd64
    echo "Argo CD CLI installed successfully."
}

# Function to install Azure CLI
install_azure_cli() {
    echo "Installing Azure CLI..."
    curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
    AZ_REPO=$(lsb_release -cs)
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
    sudo apt-get update
    sudo apt-get install -y azure-cli
    echo "Azure CLI installed successfully."
}

# Function to verify installations
verify_installations() {
    echo "Verifying installations..."
    argocd version
    az version
    echo "Installations verified successfully."
}

# Display menu
while true; do
    echo "Select an option:"
    echo "1. Install prerequisites"
    echo "2. Install Argo CD CLI"
    echo "3. Install Azure CLI"
    echo "4. Verify installations"
    echo "5. Exit"
    read -p "Enter your choice [1-5]: " choice

    case $choice in
        1) install_prerequisites ;;
        2) install_argocd_cli ;;
        3) install_azure_cli ;;
        4) verify_installations ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice. Please select a valid option." ;;
    esac
done