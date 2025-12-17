# README.md

# Setting Up PostgreSQL Backend for Terraform on Rocky Linux

This guide explains the steps to configure a **private PostgreSQL VM** to be used as a backend for Terraform, before running the second Terraform project (`tf-backend`).

---

## Prerequisites

* A running **Rocky Linux VM** with PostgreSQL installed.
* Terraform controller or Bastion host with network access to the PostgreSQL VM.
* SSH access to both the controller and the PostgreSQL VM.
* PostgreSQL user and database created (e.g., `tf_user` and `tf_state`).

---

## Step 1: SSH into the PostgreSQL VM

```bash
ssh -i ~/.ssh/id_ed25519 rocky@<POSTGRESQL_VM_PRIVATE_IP>
```

Replace `<POSTGRESQL_VM_PRIVATE_IP>` with the private IP of your PostgreSQL VM (e.g., `172.18.41.113`).

---

## Step 2: Open the PostgreSQL HBA configuration

On Rocky Linux, the configuration file is typically located at:

```bash
sudo vi /var/lib/pgsql/data/pg_hba.conf
```

---

## Step 3: Add the controller host to `pg_hba.conf`

Append the following lines **at the end of the file**:

```text
# Allow Terraform controller to access tf_state database
host    tf_state    tf_user    <TERRAFORM_CONTROLLER_PRIVATE_IP>/32    md5

# Optional: allow all databases and users from the controller
host    all         all        <TERRAFORM_CONTROLLER_PRIVATE_IP>/32    md5
```

* Replace `<TERRAFORM_CONTROLLER_PRIVATE_IP>` with the private IP of your Terraform controller/Bastion (e.g., `172.18.41.120`).
* `md5` enforces password authentication.

---

## Step 4: Restart PostgreSQL

Apply the configuration changes:

```bash
sudo systemctl restart postgresql
sudo systemctl enable postgresql
```

---

## Step 5: Reconfigure Terraform backend

On your Terraform controller, navigate to the `tf-backend` project and run:

```bash
terraform init \
  -reconfigure \
  -backend-config="conn_str=postgres://tf_user:tf_password@<POSTGRESQL_VM_PRIVATE_IP>:5432/tf_state?sslmode=disable"
```

* Replace `<POSTGRESQL_VM_PRIVATE_IP>` with your PostgreSQL VM private IP.
* This command ensures Terraform uses the PostgreSQL database as the **remote backend** for storing its state.

---

## Step 6: Verify connectivity

You can test the connection manually from the controller:

```bash
psql "host=<POSTGRESQL_VM_PRIVATE_IP> port=5432 dbname=tf_state user=tf_user password=tf_password"
```

You should connect successfully without errors.

---

## Notes

* The PostgreSQL VM must be **running and accessible** before initializing the Terraform backend.
* Always use the **private IP** for secure internal traffic.
* Consider using **environment variables** or `-backend-config` for sensitive credentials instead of hardcoding them in Terraform files.
* After this setup, any Terraform run in the `tf-backend` project will automatically store state in the PostgreSQL database.
