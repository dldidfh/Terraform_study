output "terraform_images_id" {
	value = var.image_id

}

output "terraform_availability_zone_names" {
	value = var.availability_zone_names 
}
output "terraform_ami_id_map" {
	value = var.ami_id_maps
}
output "terraform_first_availability_zone_names" {
        value = var.availability_zone_names[0]
}

