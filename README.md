# tf-state-storage

This repository contains Terraform code to automate the deployment of a secure private infrastructure behind a bastion host, dedicated to managing Terraform state files remotely.

## Structure

* **bastion_postgres/**: Terraform project to create the bastion host and a private VM running PostgreSQL. The PostgreSQL database will be used to store Terraform state securely.

* **tf-backend/**: Terraform project configured to use the PostgreSQL database from the previous step as a remote backend for storing state files.

## Overview

* Bastion host provides controlled SSH access to the private network.
* PostgreSQL VM is configured to store Terraform state, accessible only from the Terraform controller.
* Terraform state backend ensures consistent and secure management of infrastructure state.

This setup allows you to safely manage and version Terraform state files in a private environ
