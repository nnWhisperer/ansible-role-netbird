#!/bin/bash
set -e

cd "$(dirname "$0")"

# Load environment variables
if [[ -f .env ]]; then
    source .env
    export NETBIRD_SETUP_KEY
else
    echo "Error: .env file not found. Create one with NETBIRD_SETUP_KEY."
    exit 1
fi

# Set required environment variables
export ANSIBLE_LIBRARY=/usr/local/python/3.12.1/lib/python3.12/site-packages/molecule_plugins/vagrant/modules
export MOLECULE_EPHEMERAL_DIRECTORY=/tmp/molecule-test

# Create ephemeral directory
mkdir -p "$MOLECULE_EPHEMERAL_DIRECTORY"

echo "Running molecule ${1:-test}..."
molecule "${@:-test}"
