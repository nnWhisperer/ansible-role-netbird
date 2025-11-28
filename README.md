crimsonfez.netbird
=========

Install Netbird and login with a setup key.

Requirements
------------

Debian 12 or later

Role Variables
--------------


| Name               | Description                               | Default Value               |
| -------------------- | ------------------------------------------- | :---------------------------- |
| netbird_mgmt_url   | Management Server                         | https://app.netbird.io:443/ |
| netbird_setup_key  | Setup Key used when registering the agent | ""                          |
| netbird_skip_login | Skip Login step, useful for testing       | False                       |

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
- hosts: servers
  roles:
  - crimsonfez.netbird
  vars:
    netbird_mgmt_url: https://netbird.example.com
    netbird_setup_key: "1234567890"
```

Testing
-------

This role includes Molecule tests that verify Netbird installation and mesh network connectivity between two VMs.

### Prerequisites

1. **Remote libvirt host**: A machine with libvirt/KVM configured and accessible via SSH (configured as `for-vagrant` in `~/.ssh/config`)
2. **SSH key**: SSH key for accessing the remote libvirt host at `~/.ssh/vagrant_remote`
3. **Netbird setup key**: A valid setup key from your Netbird account
4. **Python packages**: `molecule`, `molecule-plugins[vagrant]`, `python-vagrant`

### Environment Setup

Create a `.env` file in the role directory with your Netbird setup key:

```bash
export NETBIRD_SETUP_KEY="your-setup-key-here"
```

### Running the Tests

```bash
cd ansible-role-netbird

# Run the full test suite
./run-tests.sh

# Or run individual phases
./run-tests.sh create
./run-tests.sh converge
./run-tests.sh verify
./run-tests.sh destroy
```

### Test Phases

The test runs through the following phases:

1. **Destroy**: Clean up any existing test VMs
2. **Create**: Spin up two VMs (netbird-vm1, netbird-vm2) via vagrant/libvirt
3. **Prepare**: Update apt cache and verify internet connectivity
4. **Converge**: Apply the Netbird role to both VMs
5. **Idempotence**: Re-run the role to verify idempotency
6. **Verify**: Test mesh network connectivity via ICMP and HTTP between VMs
7. **Destroy**: Clean up test VMs

### Running Individual Phases

For debugging, you can run individual molecule phases:

```bash
# Create VMs only
molecule create

# Apply the role
molecule converge

# Run verification tests
molecule verify

# Clean up
molecule destroy
```

License
---

AGPLv3

Author Information
------------------

David Kovari

nnWhisperer
