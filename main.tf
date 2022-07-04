terraform { 
    backend "azurerm"{ 
        resource_group_name = "manikanta" 
        storage_account_name = "soragetfstaterg12" 
        container_name = "devstage143" 
        key = "terraform.devstage" 
        access_key = "CGG/5YB8uTMi/6l4STiaytdUcNoVxCSaLnyT1UzZSxCNwB8GwN1mknhodm3XrzjiRp/zStcnnqFv+AStxerYHQ=="
      
    }
  
}
provider "azurerm"  {
    features {
    
    }
        subscription_id = "1d04f666-8de6-473d-8023-68f0396f8187"
        client_id = "b4af4907-3011-4ac3-833b-9758e928f0e6"
        tenant_id = "2b49480c-1baa-45da-ad4f-d522266c85b7"
        client_secret = ".5O8Q~s1rU8W5HV5YIIEOr2h4oy7V1LO5WRB1aUN" 
}  
resource "azurerm_resource_group" "manikanta1" {
    name = "vinayaka"
    location = "Australia East"

}
resource "azurerm_virtual_network" "vinyaka123" {
    name = "vnet1"
    resource_group_name = azurerm_resource_group.manikanta1.name
    location = azurerm_resource_group.manikanta1.location
    address_space = [ "10.60.0.0/16" ]

}
resource "azurerm_subnet" "websubnet" {
    name = "naniwebsubnet"
    resource_group_name = azurerm_resource_group.manikanta1.name
    virtual_network_name = azurerm_virtual_network.vinyaka123.name
    address_prefixes = [ "10.60.1.0/24" ]

  
}
resource "azurerm_subnet" "appsubnet" {
    name = "naniappsubnet"
    resource_group_name = azurerm_resource_group.manikanta1.name
    virtual_network_name = azurerm_virtual_network.vinyaka123.name
    address_prefixes = ["10.60.2.0/24"]

  
}
resource "azurerm_subnet" "subnet" {
    name = "nanidbsubnet"
    resource_group_name = azurerm_resource_group.manikanta1.name
    virtual_network_name = azurerm_virtual_network.vinyaka123.name
    address_prefixes = [ "10.60.3.0/24" ]
  
}
resource "azurerm_public_ip" "vinayakapublicip" {
    name = "iacpublicip"
    resource_group_name = azurerm_resource_group.manikanta1.name
    location = azurerm_resource_group.manikanta1.location
    allocation_method = "Static"

  
}
resource "azurerm_network_interface" "IACNIC1" {
    name = "iacnic2"
    resource_group_name = azurerm_resource_group.manikanta1.name
    location = azurerm_resource_group.manikanta1.location
    ip_configuration {
    name = "iacipconfig" 
    subnet_id = azurerm_subnet.websubnet.id 
    private_ip_address_allocation = "Dynamic" 
    public_ip_address_id = azurerm_public_ip.vinayakapublicip.id
    }
}
resource "azurerm_linux_virtual_machine" "webvm" {
    name = "vitual12345"
    resource_group_name = azurerm_resource_group.manikanta1.name
    location = azurerm_resource_group.manikanta1.location
    size = "Standard_B1s"
    admin_username = "adminuser"
    network_interface_ids = [ azurerm_network_interface.IACNIC1.id ] 
    admin_ssh_key { 
        username = "adminuser" 
        public_key = file("~/.ssh/id_rsa.pub")
      
    }
    os_disk { 
      caching = "ReadWrite" 
      storage_account_type = "Standard_LRS" 
      
    } 
    source_image_reference { 
        publisher = "canonical" 
        offer = "Ubuntuserver" 
        sku = "18.04-LTS" 
        version = "latest" 
      
    }
  
} 



