## Come utilizzare i modelli esportati con Terraform e Crossplane

### Introduzione

I modelli esportati possono essere utilizzati per creare risorse di infrastruttura in modo rapido e semplice. In questo documento, viene illustrato come utilizzare i modelli esportati con Terraform e Crossplane.

### Terraform

Terraform è un framework di gestione dell'infrastruttura che consente di creare, gestire e distribuire risorse di infrastruttura in modo declarative. Per utilizzare Terraform per creare risorse basate su un modello esportato, è necessario seguire questi passaggi:

1. Esportare il modello dal provider di cloud.
2. Creare un file Terraform che utilizza il modello esportato.
3. Eseguire il piano Terraform.
4. Applicare il piano Terraform.

### Esempio

Per utilizzare Terraform per creare una risorsa di macchina virtuale in Azure basata su un modello esportato, è possibile seguire questi passaggi:

1. Esportare il modello di macchina virtuale da Azure utilizzando il comando seguente:


az deployment export --resource-group <resource-group-name> --name <deployment-name> --output-file <output-file-name>


2. Creare un file Terraform che utilizza il modello esportato. Il file Terraform dovrebbe contenere le seguenti informazioni:

```
resource "azurerm_resource_group" "my_resource_group" {
  name = "my-resource-group"
}

resource "azurerm_deployment" "my_deployment" {
  name = "my-deployment"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  template_file = "./my-vm.json"

  parameters = {
    vm_name = "my-vm"
    vm_size = "Standard_D2s_v3"
    vm_image = "ubuntu-latest"
  }
}
```

3. Eseguire il piano Terraform utilizzando il comando seguente:

```
terraform plan
```

4. Applicare il piano Terraform utilizzando il comando seguente:

```
terraform apply
```

Eseguire questi passaggi creerà una risorsa di macchina virtuale in Azure basata sul modello esportato.

### Crossplane

Crossplane è un framework di gestione dell'infrastruttura che consente di creare, gestire e distribuire risorse di infrastruttura in modo declarative. Crossplane può essere utilizzato per creare risorse in Azure, AWS, Google Cloud Platform e altri provider di cloud.

Per utilizzare Crossplane per creare risorse basate su un modello esportato, è necessario seguire questi passaggi:

1. Esportare il modello dal provider di cloud.
2. Creare un manifest Crossplane che utilizza il modello esportato.
3. Applicare il manifest Crossplane.

### Esempio

Per utilizzare Crossplane per creare una risorsa di macchina virtuale in Azure basata su un modello esportato, è possibile seguire questi passaggi:

1. Esportare il modello di macchina virtuale da Azure utilizzando il comando seguente:


az deployment export --resource-group <resource-group-name> --name <deployment-name> --output-file <output-file-name>


2. Creare un manifest Crossplane che utilizza il modello esportato. Il manifest Crossplane dovrebbe contenere le seguenti informazioni:

```
apiVersion: core.crossplane.io/v1alpha1
kind: Machine
metadata:
  name: my-vm
spec:
  providerRef:
    name: azure
  resource:
    apiVersion: azure.crossplane.io/v1alpha1
    kind: Machine
    properties:
      template:
        resource:
          apiVersion: resources.azure.com/v1alpha1
          kind: Deployment
          properties:
            template:
              parameters:
                vm_name: my-vm
                vm_size: Standard_D2s_v3
                vm_image: ubuntu-latest
              template:
                uri: <path-to-template>
```

3. Applicare il manifest Crossplane utilizzando il comando seguente:

```
kubectl apply -f my-vm.yaml
```

Eseguire questi passaggi creerà una risorsa di macchina virtuale in Azure basata sul modello esportato.

### Conclusione

I modelli esportati possono essere utilizzati per creare risorse di infrastruttura in modo rapido e semplice.