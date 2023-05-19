resource "aws_route53domains_registered_domain" "daughertylabs_io" {
  domain_name   = local.dl_root_domain
  auto_renew    = true
  transfer_lock = true
  dynamic "name_server" {
    for_each = local.base_name_servers
    content {
      name = name_server.value
    }
  }

  registrant_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  registrant_privacy = true
  admin_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  admin_privacy = true
  tech_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  tech_privacy = true

  tags = module.this.tags
}

resource "aws_route53domains_registered_domain" "daughertylab_io" {
  domain_name   = local.daughertylab_io_domain
  auto_renew    = true
  transfer_lock = true
  dynamic "name_server" {
    for_each = local.base_name_servers
    content {
      name = name_server.value
    }
  }

  registrant_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  registrant_privacy = true
  admin_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  admin_privacy = true
  tech_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  tech_privacy = true

  tags = module.this.tags
}

resource "aws_route53domains_registered_domain" "daughertylab_com" {
  domain_name   = local.daughertylab_com_domain
  auto_renew    = true
  transfer_lock = true
  dynamic "name_server" {
    for_each = local.base_name_servers
    content {
      name = name_server.value
    }
  }

  registrant_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  registrant_privacy = true
  admin_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  admin_privacy = true
  tech_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  tech_privacy = true

  tags = module.this.tags
}

resource "aws_route53domains_registered_domain" "daugherty_labs_com" {
  domain_name   = local.daugherty_labs_com_domain
  auto_renew    = true
  transfer_lock = true
  dynamic "name_server" {
    for_each = local.base_name_servers
    content {
      name = name_server.value
    }
  }

  registrant_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  registrant_privacy = true
  admin_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  admin_privacy = true
  tech_contact {
    contact_type      = local.domain_contact["contact_type"]
    first_name        = local.domain_contact["first_name"]
    last_name         = local.domain_contact["last_name"]
    organization_name = local.domain_contact["organization_name"]
    email             = local.domain_contact["email"]
    phone_number      = local.domain_contact["phone_number"]
    address_line_1    = local.domain_contact["address_line_1"]
    address_line_2    = local.domain_contact["address_line_2"]
    country_code      = local.domain_contact["country_code"]
    city              = local.domain_contact["city"]
    state             = local.domain_contact["state"]
    zip_code          = local.domain_contact["zip_code"]
  }
  tech_privacy = true

  tags = module.this.tags
}
