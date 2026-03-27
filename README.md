# Azure Enterprise VM Workload Stack

This repository contains the Terraform configuration for deploying a Linux and Windows virtual machine workload into the **Azure Enterprise Landing Zone**. It is part of a modular, multi-environment infrastructure stack designed for scalability, security, and maintainability.

> **Deployment order:**
> 1. **Terraform State** — storage accounts and containers must exist first
> 2. **Landing Zone** — hub networking, firewall, NAT gateway
> 3. **This repo** — reads networking outputs from landing zone remote state

---

## 📦 Components

- **Linux VM**: Ubuntu 22.04 LTS, `Standard_B1s`, SSH key authentication, private IP `10.0.1.4`
- **Windows VM**: Windows Server 2022, `Standard_B1s`, password authentication, private IP `10.0.1.5`
- **Network Interfaces**: Both VMs attached to the hub `default` subnet (`10.0.1.0/24`)
- **Resource Group**: Dedicated `rg-vm-workload` — isolated from hub networking resources
- **Remote State Backend**: Azure Blob Storage for Terraform state isolation
- **Landing Zone Integration**: Location and subnet sourced from landing zone remote state

---

## 📁 File Structure

| File           | Purpose                                          |
|----------------|--------------------------------------------------|
| `main.tf`      | Resource group and landing zone remote state     |
| `vm_linux.tf`  | Linux VM and NIC definition                      |
| `vm_windows.tf`| Windows VM and NIC definition                    |
| `network.tf`   | Landing zone remote state reference (intentionally minimal) |
| `providers.tf` | Azure provider and SP authentication             |
| `backend.tf`   | Remote state backend                             |
| `variable.tf`  | Input variables                                  |
| `outputs.tf`   | Output values (private IPs)                      |

---

## 🚫 Security Hygiene

This repo **does not contain**:
- `terraform.tfvars`
- `.terraform/` provider binaries
- `terraform.tfstate`
- Any secrets, credentials, SSH keys, or passwords

All sensitive data is managed locally and excluded via `.gitignore`.

---

## 🚀 Deployment

### Prerequisites
- Landing zone deployed and state accessible in Azure Blob Storage
- Service principal with Contributor rights
- SSH public key generated locally
- `terraform.tfvars` created locally (never commit this file)

### Generate SSH key (if needed)
```powershell
ssh-keygen -t rsa -b 4096 -f "$HOME\.ssh\id_rsa_azure"
```

### Deploy
```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

> Ensure your `terraform.tfvars` is stored securely and never committed.

---

## 📌 Notes

- Both VMs are deployed into the hub `default` subnet and are accessible via Azure Bastion
- No public IPs are assigned — all access is private
- The `vm_resource_group` variable allows the workload RG to be configured independently from the hub
- Networking is owned entirely by the landing zone — this repo contains no VNet or subnet resources

---

## 📈 Future Enhancements

- Add Azure Bastion access documentation
- Integrate with Azure Monitor and Log Analytics for VM diagnostics
- Add data disks and managed disk configuration
- Implement auto-shutdown schedules for cost management
- Add GitHub Actions CI/CD pipeline for automated deployments

---

## 🛡️ Author

**Joshua Phillis**
Retired Army Major | Cloud & Platform Engineer
GitHub: [@joshphillis](https://github.com/joshphillis)
