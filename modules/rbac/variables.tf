variable "role_assignments" {
  type = map(object({
    scope                = string
    role_definition_name = optional(string)
    role_definition_id   = optional(string)
    principal_id         = string
    description          = optional(string)
  }))
  description = "Role assignments configured via for_each adhering to least privilege"
}
