resource "azurerm_virtual_network_gateway" "example" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = var.type                # "Vpn" o "ExpressRoute"
  vpn_type            = var.vpn_type            # "RouteBased" o "PolicyBased"
  active_active       = var.active_active
  enable_bgp          = var.enable_bgp
  sku                 = var.sku                 # Ej: "VpnGw1", "VpnGw2", etc.
  generation          = var.generation          # "Generation1" o "Generation2"
  edge_zone           = var.edge_zone           # Opcional
  tags                = var.tags                # Map de etiquetas

  ip_configuration {
    name                          = var.ip_configuration_name
    public_ip_address_id          = var.ip_configuration_public_ip_address_id
    private_ip_address_allocation = var.ip_configuration_private_ip_address_allocation
    subnet_id                     = var.ip_configuration_subnet_id
  }

  vpn_client_configuration {
    address_space = var.vpn_client_configuration_address_space

    root_certificate {
      name = var.root_certificate_name
      public_cert_data = var.root_certificate_public_cert_data
    }

    revoked_certificate {
      name       = var.revoked_certificate_name
      thumbprint = var.revoked_certificate_thumbprint
    }

    vpn_client_protocols = var.vpn_client_protocols # ["SSTP", "IKEv2", "OpenVPN"]
    vpn_auth_types       = var.vpn_auth_types       # ["AAD", "Certificate"]
    aad_tenant           = var.aad_tenant           # Opcional
    aad_audience         = var.aad_audience         # Opcional
    aad_issuer           = var.aad_issuer           # Opcional

    radius_server {
      radius_server_address = var.radius_server_address # Opcional
      radius_server_secret  = var.radius_server_secret  # Opcional
    }
    
  }

  bgp_settings {
    asn               = var.bgp_asn
    peering_address   = var.bgp_peering_address
    peer_weight       = var.bgp_peer_weight
    bgp_peering_addresses = var.bgp_peering_addresses # Opcional (bloque)
  }

  custom_route {
    address_prefixes = var.custom_route_address_prefixes
  }

  gateway_default_site = var.gateway_default_site # Opcional

  timeouts {
    create = var.timeout_create
    update = var.timeout_update
    delete = var.timeout_delete
  }
}
