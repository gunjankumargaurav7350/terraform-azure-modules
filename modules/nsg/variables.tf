variable "nsg_name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "security_rules" {
  type = map(object({
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(string, "*")
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
  }))
  description = "Security rules evaluated via for_each"
}
variable "tags" {
  type    = map(string)
  default = {}
}
