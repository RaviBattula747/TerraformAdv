resource "azurerm_resource_group" "az-rg" {
    name = var.name
    location = var.location
        tags = {
    PROJECT_CONTACT = var.tags.PROJECT_CONTACT
    CMDB_CI_NAME = var.tags.CMDB_CI_NAME
    SYSTEM_CODE = var.tags.SYSTEM_CODE
    SAP_COST_CENTER = var.tags.SAP_COST_CENTER
    RESOURCE_TYPE = var.tags.RESOURCE_TYPE
    PORTFOLIO = var.tags.PORTFOLIO
    OPERATING_UNIT = var.tags.OPERATING_UNIT
    PRIORITY        = var.tags.PRIORITY
    }
    /*lifecycle {
      ignore_changes = [tags]
    }*/
}
