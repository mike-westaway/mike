/*
* main.tf
*/

provider "azurerm" {
  environment = ""
}

provider "google" {}

module "vault" {
  source  = "hashicorp/vault/azurerm"
  version = "0.0.2"
  # A list of CIDR-formatted IP address ranges from which the Azure Instances will allow connections to Consul
  allowed_inbound_cidr_blocks = []
  # The SSH public key that will be added to SSH authorized_users on the consul instances
  key_data = ""
  # The URI to the Azure image that should be deployed to the consul cluster.
  image_uri = ""
  # The key for storage_account_name.
  storage_account_key = ""
  # The Azure subscription ID
  subscription_id = ""
  # The name of the Azure resource group consul will be deployed into. This RG should already exist
  resource_group_name = ""
  # The Azure secret access key
  secret_access_key = ""
  # The name of an Azure Storage Account. This SA should already exist
  storage_account_name = ""
  # The Azure client ID
  client_id = ""
  # The Azure tenant ID
  tenant_id = ""
}

module "virtual-network" {
  source  = "sjones-sot/virtual-network/azurerm"
  version = "0.1.1"
}

module "vmss-cloudinit" {
  source  = "Azure/vmss-cloudinit/azurerm"
  version = "1.1.0"
  # The subnet id of the virtual network on which the vm scale set will be connected
  vnet_subnet_id = ""
  # The location of the cloud init configuration file.
  cloudconfig_file = ""
  # The id of the backend address pools of the loadbalancer to which the VM scale set is attached
  load_balancer_backend_address_pool_ids = ""
}

module "key-vault" {
  source  = "avinor/key-vault/azurerm"
  version = "1.0.0"
  # Azure location where resources should be deployed.
  location = ""
  # Name of resource group to deploy resources in.
  resource_group_name = ""
  # Name of key vault account.
  name = ""
  # Network rules to apply to key vault.
  network_acls = {}
  # Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent.
  log_analytics_workspace_id = ""
}

module "regions" {
  source  = "claranet/regions/azurerm"
  version = "2.0.1"
  # Azure Region in slug format
  azure_region = ""
}

module "vnet" {
  source  = "claranet/vnet/azurerm"
  version = "2.0.1"
  # The address space that is used by the virtual network
  vnet_cidr = []
  # Project stack name
  stack = ""
  # Client name/account used in naming
  client_name = ""
  # Azure region to use
  location = ""
  # Resource group name
  resource_group_name = ""
  # Project environment
  environment = ""
  # Short string for Azure location.
  location_short = ""
}

module "mysql" {
  source = "https://github.com/sblack4/terraform-azurerm-mysql?ref=0.2.1"
}

module "mysql" {
  source  = "rhythmictech/mysql/azurerm"
  version = "2.0.0"
  # The name of the server and resources to be created.
  name = ""
  # The administrator password of the MySQL Server.
  password = ""
  # The administrator username of MySQL Server.
  admin_username = ""
  # Specifies the supported Azure location where the resource exists.
  location = ""
}

module "vm" {
  source  = "rhythmictech/vm/azurerm"
  version = "0.1.0"
  # Resource Group for bastion server
  resource_group_name = ""
  # Subnet for bastion server
  subnet_name = ""
  # VNET containing subnet for bastion server
  vnet_name = ""
  # Moniker to apply to all resources in the module
  name = ""
}

module "keyvault" {
  source  = "claranet/keyvault/azurerm"
  version = "2.0.1"
  # Azure location for Key Vault.
  location            = ""
  stack               = ""
  resource_group_name = ""
  client_name         = ""
  # Short string for Azure location.
  location_short = ""
  environment    = ""
}

module "nsg" {
  source  = "claranet/nsg/azurerm"
  version = "2.0.1"
  # Resource group name
  resource_group_name = ""
  # Short string for Azure location.
  location_short = ""
  # Azure location.
  location = ""
  # Client name/account used in naming
  client_name = ""
  # Project stack name
  stack = ""
  # Project environment
  environment = ""
}

module "vm-backup" {
  source  = "claranet/vm-backup/azurerm"
  version = "2.0.0"
  # The name of the resource group in which the VM has been created.
  resource_group_name = ""
  # Project stack name
  stack = ""
  # Client name/account used in resource naming
  client_name = ""
  # Backup policy to attach
  backup_policy_id = ""
  # Number of Azure vm to attach to the Backup policy
  vm_count = ""
  # List of Azure VM ID to attach to the Backup policy
  vm_ids = []
  # Short version of the Azure location, used by naming convention.
  location_short = ""
  # Specifies the supported Azure location where the resource exists.
  location = ""
  # Project environment
  environment = ""
  # Backup recovery vault name
  backup_recovery_vault_name = ""
}

module "vm-logs" {
  source  = "claranet/vm-logs/azurerm"
  version = "2.0.1"
  # Azure Linux VM ID to enable Diagnostics
  vm_id = ""
  # Azure Linux VM name to enable Diagnostics
  vm_name = ""
  # Project stack name
  stack = ""
  # Client name/account used in naming
  client_name = ""
  # Azure Storage Account to use for logs and diagnostics
  diagnostics_storage_account_name = ""
  # Project environment
  environment = ""
  # Azure Storage Account SAS Token. An Account SAS token for Blob and Table services (ss='bt'), applicable to containers and objects (srt='co'), which grants add, create, list, update, and write permissions (sp='acluw'). Do not include the leading question-mark (?).
  diagnostics_storage_account_sas_token = ""
  # Short version of the Azure location, used by naming convention.
  location_short = ""
  # Specifies the supported Azure location where the resource exists.
  location = ""
  # The name of the resource group in which the VM has been created.
  resource_group_name = ""
}

module "kubernetes-cluster" {
  source  = "innovationnorway/kubernetes-cluster/azurerm"
  version = "0.1.0-alpha.1"
  # The Kubernetes version to use.
  kubernetes_version = ""
  # The name of the node resource group.
  node_resource_group = ""
  # The name of an existing resource group.
  resource_group_name = ""
  # The name of the managed cluster.
  name = ""
  # A `service_principal` object.
  service_principal = {}
  # List of node pools. This should be `node_pools` object.
  node_pools = ""
}

module "caf-diagnostics" {
  source  = "aztfmod/caf-diagnostics/azurerm"
  version = "0.1.1"
  # (Required) Contains the diagnostics setting object.
  diag_object = ""
  # (Required) Fully qualified Azure resource identifier for which you enable diagnostics.
  resource_id = ""
  # (Required) Name of the diagnostics object.
  name = ""
  # (Required) contains the log analytics workspace ID details for operations diagnostics.
  log_analytics_workspace_id = ""
  # (Required) contains the SA and EH details for operations diagnostics.
  diagnostics_map = ""
}

module "caf-resource-group" {
  source  = "aztfmod/caf-resource-group/azurerm"
  version = "0.1.1"
  # (Optional) You can use a prefix to add to the list of resource groups you want to create
  prefix = ""
  # (Required) Map of the resource groups to create
  resource_groups = ""
}

module "linux-vm" {
  source = "https://github.com/kjanshair/terraform-azurerm-linux-vm?ref=1.0.0"
}

module "linux-vm" {
  source = "https://github.com/kjanshair/terraform-azurerm-linux-vm?ref=1.0.0"
}

module "linux-vm" {
  source = "https://github.com/kjanshair/terraform-azurerm-linux-vm?ref=1.0.0"
}

module "naming" {
  source  = "gsoft-inc/naming/azurerm"
  version = "0.3.3"
  # Resource name.
  name = ""
  # List of suffixes to append at the end of the resource name.
  suffixes = []
  # List of prefixes to append in front of the resource name.
  prefixes = []
}

module "vm-run-command" {
  source  = "erlacherl-city/vm-run-command/azurerm"
  version = "1.1.0-b3"
  # The location of the virtual machine.
  virtual_machine_location = ""
  # The name of the resource group.
  resource_group_name = ""
  # Specifies the operating system type.
  os_type = ""
  # The name of the virtual machine.
  virtual_machine_name = ""
}

module "container-registry" {
  source  = "avinor/container-registry/azurerm"
  version = "1.2.1"
  # Azure location where to place resources
  location = ""
  # Name of resource group to deploy resources in.
  resource_group_name = ""
  # Name of the resource
  name = ""
  # A list of Azure locations where the container registry should be geo-replicated.
  georeplication_locations = []
}

module "function-app-single" {
  source              = "claranet/function-app-single/azurerm"
  version             = "2.0.1"
  stack               = ""
  client_name         = ""
  resource_group_name = ""
  # Id of the App Service Plan for Function App hosting
  app_service_plan_id = ""
  environment         = ""
  # Short string for Azure location.
  location_short = ""
  # Azure location for App Service Plan.
  location = ""
}

module "function-app-with-plan" {
  source = "https://github.com/claranet/terraform-azurerm-function-app-with-plan?ref=2.0.1"
}

module "policy" {
  source = "https://github.com/claranet/terraform-azurerm-policy?ref=1.0.0"
}

module "policy" {
  source = "https://github.com/claranet/terraform-azurerm-policy?ref=1.0.0"
}

module "Az-AppService" {
  source = "https://github.com/JamesDLD/terraform-azurerm-Az-AppService?ref=0.1.0"
}
