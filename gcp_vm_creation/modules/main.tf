module "childmodule-01" {
    source = "./childmodule1"
}

module "childmodule-02" {
    source = "./childmodule2"
}

#terraform {
# backend "local" {
# path ="C:/terraform state/state.tfstate"  
# }
#}