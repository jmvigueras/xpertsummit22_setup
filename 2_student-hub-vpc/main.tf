

// Create VPC HUB with FGT standalone
module "fgt-vpc-hub" {
    //source = "github.com/jmvigueras/modules//aws/fgt-1az-vpc-sec"
    source = "./modules/fgt-vpc-hub"

    tags            = var.tags
    region          = var.region
    admin_cidr      = var.admin_cidr
    admin_port      = var.admin_port
    
    vpc-hub_cidr    = var.vpc-hub_cidr
    hub_advpn       = var.hub_advpn
    hub_advpn_psk   = data.terraform_remote_state.student-accounts.outputs.externalid-token

    key-pair_name           = null
    key-pair_rsa-public-key = var.key-pair_rsa-public-key
}

// Create VPC spoke site with FGT standalone
module "fgt-spoke-site" {
    //source = "github.com/jmvigueras/modules//aws/fgt-1az-vpc-sec"
    source = "./modules/fgt-spoke-site"

    tags        = {
        Name    = "site-test-xs22"
        Project = "xs22"
    }
    region          = var.region
    admin_cidr      = var.admin_cidr
    admin_port      = var.admin_port
    
    vpc-spoke_cidr    = var.vpc-spoke_cidr
    hub_advpn         = {
        hub_asn       = var.hub_advpn["hub_asn"]
        spoke_asn     = var.hub_advpn["spoke_asn"]
        advpn_net     = var.hub_advpn["advpn_net"]
        advpn_e-ip1   = module.fgt-vpc-hub.fgt["advpn_pip"]
    }

    hub_advpn_psk   = data.terraform_remote_state.student-accounts.outputs.externalid-token

    key-pair_name           = null
    key-pair_rsa-public-key = var.key-pair_rsa-public-key
}

// create test servers spoke test Site
module "server-vpc-spoke" {
    //source = "github.com/jmvigueras/modules//aws/fgt-1az-vpc-sec"
    source = "./modules/server-test"

    tags        = {
        Name    = "server-vpc-spoke"
        Project = "xs22"
    }
    
    eni-server      = module.fgt-spoke-site.eni-server
    key-pair_name   = module.fgt-spoke-site.key-pair
}