variable "name" {
  description = "The name of the resource group"
  type        = string
}


variable "location" {
  description = "The location of the resource group"
  type        = string
}

  variable "tags" {
    type   = object({
    PROJECT_CONTACT = string
    CMDB_CI_NAME = string
    SYSTEM_CODE = string
    SAP_COST_CENTER = string
    RESOURCE_TYPE = string
    PORTFOLIO = string
    OPERATING_UNIT = string
    PRIORITY  = string
    })

    }
