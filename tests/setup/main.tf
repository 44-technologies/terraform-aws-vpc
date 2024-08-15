

resource "random_pet" "vpc_name" {
  length = 1
}

output "vpc_name" {
  value = random_pet.vpc_name.id
}