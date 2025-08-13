
variable "name" {
    description = "The name of the virtual network gateway."
    type        = string
}

variable "location" {
    description = "The location/region where the virtual network gateway is created."
    type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group."
    type        = string
}

variable "type" {
    description = "The type of the gateway. Valid values are 'Vpn' or 'ExpressRoute'."
    type        = string

    validation {
        condition     = contains(["Vpn", "ExpressRoute"], var.type)
        error_message = "The type must be either 'Vpn' or 'ExpressRoute'."
    }
}

variable "vpn_type" {
    description = "The type of VPN. Valid values are 'RouteBased' or 'PolicyBased'."
    type        = string
    default     = "RouteBased"

    validation {
        condition     = contains(["RouteBased", "PolicyBased"], var.vpn_type)
        error_message = "The vpn_type must be either 'RouteBased' or 'PolicyBased'."
    }
}

variable "active_active" {
    description = "Whether the gateway is active-active. If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a HighPerformance or an UltraPerformance SKU. If false, an active-standby gateway will be created."
    type        = bool
    default     = false

    validation {
        condition = (
            !var.active_active ||
            contains(["HighPerformance", "UltraPerformance"], var.sku)
        )
        error_message = "Active-active gateways require the SKU to be either 'HighPerformance' or 'UltraPerformance'."
    }
}

variable "enable_bgp" {
    description = "Whether BGP is enabled for this gateway."
    type        = bool
    default     = false
}

variable "sku" {
    description = "The SKU of the virtual network gateway."
    type        = string

    validation {
        condition = (
            (
                var.vpn_type == "PolicyBased" && var.sku == "Basic"
            ) ||
            (
                var.type == "ExpressRoute" && var.sku == "UltraPerformance"
            ) ||
            (
                var.vpn_type != "PolicyBased" && var.type != "ExpressRoute" && contains([
                    "Standard", "HighPerformance", "ErGw1AZ", "ErGw2AZ", "ErGw3AZ",
                    "VpnGw1", "VpnGw2", "VpnGw3", "VpnGw4", "VpnGw5",
                    "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ", "VpnGw4AZ", "VpnGw5AZ"
                ], var.sku)
            )
        )
        error_message = "Invalid SKU. For PolicyBased VPN, only 'Basic' is allowed. For ExpressRoute, only 'UltraPerformance' is allowed. Otherwise, valid SKUs are: Standard, HighPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ, VpnGw1, VpnGw2, VpnGw3, VpnGw4, VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ, VpnGw4AZ, VpnGw5AZ."
    }
}

variable "generation" {
    description = "The generation of the gateway. Possible values are 'Generation1', 'Generation2', or 'None'."
    type        = string
    default     = "None"

    validation {
        condition     = contains(["Generation1", "Generation2", "None"], var.generation)
        error_message = "The generation must be 'Generation1', 'Generation2', or 'None'."
    }
}

variable "edge_zone" {
    description = "The Edge Zone within the Azure Region."
    type        = string
    default     = null
}

variable "tags" {
    description = "A mapping of tags to assign to the resource."
    type        = map(string)
    default     = {}
}

variable "ip_configuration_name" {
    description = "The name of the IP configuration."
    type        = string
    default     = "vnetGatewayConfig"
}

variable "ip_configuration_public_ip_address_id" {
    description = "The ID of the public IP address for the IP configuration."
    type        = string

}

variable "ip_configuration_private_ip_address_allocation" {
    description = "Defines how the private IP address of the gateway's virtual interface is assigned. The only valid value is 'Dynamic' for Virtual Network Gateway (Static is not supported by the service yet). Defaults to 'Dynamic'."
    type        = string
    default     = "Dynamic"

    validation {
        condition     = var.ip_configuration_private_ip_address_allocation == "Dynamic"
        error_message = "The only valid value for ip_configuration_private_ip_address_allocation is 'Dynamic'."
    }
}

variable "ip_configuration_subnet_id" {
    description = "The ID of the subnet for the IP configuration."
    type        = string
}

variable "vpn_client_configuration_address_space" {
    description = "The address space for VPN clients."
    type        = list(string)
}

variable "root_certificate_name" {
    description = "The name of the root certificate."
    type        = string
}

variable "root_certificate_public_cert_data" {
    description = "The public certificate data for the root certificate."
    type        = string
}

variable "revoked_certificate_name" {
    description = "The name of the revoked certificate."
    type        = string
}

variable "revoked_certificate_thumbprint" {
    description = "The thumbprint of the revoked certificate."
    type        = string
}

variable "vpn_client_protocols" {
    description = "The protocols supported by the VPN client. Supported values are SSTP, IkeV2, and OpenVPN. SSTP and IkeV2 are incompatible with the use of aad_tenant, aad_audience, and aad_issuer."
    type        = list(string)

    validation {
        condition = alltrue([
            length(var.vpn_client_protocols) > 0,
            alltrue([
                for p in var.vpn_client_protocols : contains(["SSTP", "IkeV2", "OpenVPN"], p)
            ]),
            (
                (
                    var.aad_tenant == null && var.aad_audience == null && var.aad_issuer == null
                ) ||
                (
                    !contains(var.vpn_client_protocols, "SSTP") &&
                    !contains(var.vpn_client_protocols, "IkeV2")
                )
            )
        ])
        error_message = "vpn_client_protocols must only contain SSTP, IkeV2, and OpenVPN. If aad_tenant, aad_audience, or aad_issuer is set, SSTP and IkeV2 cannot be used."
    }
}

variable "vpn_auth_types" {
    description = "List of the VPN authentication types for the virtual network gateway. The supported values are AAD, Radius, and Certificate."
    type        = list(string)
    default     = []
    validation {
        condition     = alltrue([for t in var.vpn_auth_types : contains(["AAD", "Radius", "Certificate"], t)])
        error_message = "vpn_auth_types must only contain: AAD, Radius, and Certificate."
    }
}

variable "aad_tenant" {
    description = "The AzureAD Tenant URL for VPN authentication."
    type        = string
    default     = null
}

variable "aad_audience" {
    description = "The client id of the Azure VPN application."
    type        = string
    default     = null
}

variable "aad_issuer" {
    description = "The STS url for your tenant."
    type        = string
    default     = null
}

variable "radius_server_address" {
    description = "The address of the RADIUS server."
    type        = string
    default     = null
}

variable "radius_server_secret" {
    description = "The secret for the RADIUS server."
    type        = string
    default     = null
}

variable "radius_servers" {
    description = "A list of RADIUS servers."
    type        = list(object({
        address = string
        secret  = string
    }))
    default     = []
}

variable "bgp_asn" {
    description = "The ASN for BGP."
    type        = number
}

variable "bgp_peering_address" {
    description = "The peering address for BGP."
    type        = string
}

variable "bgp_peer_weight" {
    description = "The peer weight for BGP."
    type        = number
}

variable "bgp_peering_addresses" {
    description = "A list of BGP peering addresses."
    type        = list(object({
        ip_configuration_name = string
        apipa_addresses       = list(string)
    }))
    default     = []
}

variable "custom_route_address_prefixes" {
    description = "A list of custom route address prefixes."
    type        = list(string)
}

variable "gateway_default_site" {
    description = "The default site for the gateway."
    type        = string
    default     = null
}

variable "timeout_create" {
    description = "Timeout for creating the resource."
    type        = string
    default     = "60m"
}

variable "timeout_update" {
    description = "Timeout for updating the resource."
    type        = string
    default     = "60m"
}

variable "timeout_delete" {
    description = "Timeout for deleting the resource."
    type        = string
    default     = "60m"
}