/**
 * # vault_policy_management
 *
 * ([Module sources](https://github.com/wescale/hashistack/tree/main/terraform/vault_policy_management))
 *
 * ```{admonition} Leading practice
 * :class: important
 *
 * This module is produced as guiding sample for implementing your own policy management.
 * It creates an ACL policy, with associated tokens, to create other policies, while
 * excplicitly denying any modification on a list of other policies.
 * ```
 *
 */
locals {
  policy_management_policy_name = "${terraform.workspace}_policy_management_policy"

  policy_management_token_ttl             = var.policy_management_token_ttl
  policy_management_token_renewable       = var.policy_management_token_renewable
  policy_management_token_renew_min_lease = var.policy_management_token_renew_min_lease
  policy_management_token_renew_increment = var.policy_management_token_renew_increment
}

resource "vault_policy" "policy_management" {
  name = local.policy_management_policy_name

  policy = templatefile("${path.module}/policies/policy_management.tpl", {})
}

resource "vault_token" "policy_management" {
  metadata = {
    "purpose" = "Policy management"
  }

  policies = [
    vault_policy.policy_management.name
  ]

  renewable = local.policy_management_token_renewable
  ttl       = local.policy_management_token_ttl

  renew_min_lease = local.policy_management_token_renew_min_lease
  renew_increment = local.policy_management_token_renew_increment
}

