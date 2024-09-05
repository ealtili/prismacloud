# Terraform Prisma Cloud Policies Exporter

This Terraform configuration exports all Prisma Cloud policies to local JSON files. Each policy is saved in a directory structure based on its type and whether it is a built-in or custom policy.

## Prerequisites

- Terraform installed on your machine.
- Access to Prisma Cloud with appropriate permissions to list policies.
- Replace values in credentials.json

## Usage

1. **Clone the repository:**

    ```sh
    git clone <repository-url>
    cd <repository-directory>
    ```

2. **Initialize Terraform:**

    ```sh
    terraform init
    ```

3. **Apply the configuration:**

    ```sh
    terraform apply
    ```

    This will export all Prisma Cloud policies to the `policies/` directory.

## Code Explanation

### Data Source
This data source fetches all policies from Prisma Cloud.

```hcl
data "prismacloud_policies" "all_policies" {}
```

### Resource
This resource creates a local file for each policy. The file is named based on the policy type and whether it is a built-in or custom policy. The content of the file is the JSON-encoded policy data.
```hcl
resource "local_file" "exported_policy_files" {
  for_each = {
    for key, value in data.prismacloud_policies.all_policies.listing :
    key => value
  }
  filename = "policies/${each.value.policy_type}/${each.value.system_default ? "builtin" : "custom"}/${substr(each.value.name, 0, 60)}.json"
  content  = jsonencode(each.value)
}
```

### Directory Structure

The exported policies will be organized in the following directory structure:

```
policies/
  ├── <policy_type>/
  │   ├── builtin/
  │   │   ├── <policy_name>.json
  │   └── custom/
  │       ├── <policy_name>.json
```
- <policy_type>: The type of the policy (e.g., network, config).
- builtin: Built-in policies provided by Prisma Cloud.
- custom: Custom policies created by the user.
- <policy_name>: The name of the policy, truncated to 60 characters.

### License
This project is licensed under the MIT License. See the LICENSE file for details.

### Contributing
Contributions are welcome! Please open an issue or submit a pull request.
