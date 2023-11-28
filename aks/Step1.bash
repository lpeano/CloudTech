az account list --query "[?user.name=='peanoluca@gmail.com'].{Name:name, ID:id, Default:isDefault}" --output Table
az account set --subscription  peanolab

