# Conformity Template Scanner

A GitHub action to scan your infrastructure templates modelled either in Terraform or CloudFormation. The type of resources scanned depends on the currently supported list from Cloud Conformity.

## Pre-requisites

- You have a Cloud Conformity API key
- You know the Cloud conformity region


## Usage



```yaml
      - name: Initiate scan
        uses: quixoticmonk/conformity-template-scanner@v1
        with:
          conformity_region: "us-1"
          conformity_api_key: ${{secrets.conformity_api_key}}
          template_type: "terraform-template"
          template_path: "infra/tf_plan.json"
```


## Input

| Input    | Description |
| -------- | ------- |
| conformity_region  | Your Cloud conformity region    |
| conformity_api_key | Your Cloud conformity API key     |
| template_type    | Your infrastructure template type    |
| template_path    | Path of the template to sca     |

## Output

The action reviews the generated CloudFormation template or Terraform plan against the conformity api to provide you a categorized output of rules , their risk levels and status. The script is further configured to fail with an exit code of 1 in case of high or Very_high findings.

The output generated will be a json the format below

```bash

{
  "DNS Compliant S3 Bucket Names": {
    "risk": "LOW",
    "status": "SUCCESS"
  },
  "Enable S3 Block Public Access for S3 Buckets": {
    "risk": "MEDIUM",
    "status": "FAILURE"
  },
  .....
  "Secure Transport": {
    "risk": "MEDIUM",
    "status": "FAILURE"
  },
  "Server Side Encryption": {
    "risk": "HIGH",
    "status": "FAILURE"
  },
  "Tags": {
    "risk": "LOW",
    "status": "FAILURE"
  }
}
{'VERY_HIGH': 10, 'MEDIUM': 3, 'LOW': 7, 'HIGH': 1}

```