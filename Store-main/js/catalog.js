class CatalogRender {
    constructor(catalogMenu, rootElement) {
        this.catalogMenu = catalogMenu;
        this.rootElement = rootElement;
    }

    render(){
        this.rootElement.innerHTML='';
             let catalogItems = document.createElement('div');
             catalogItems.classList.add('catalog-items');
             this.rootElement.appendChild(catalogItems);

        this.catalogMenu.forEach((card)=>{
            let catalogItem = document.createElement('ul');
            catalogItem.classList.add('catalog-item');
            catalogItem.innerText = card.title;
            catalogItems.appendChild(catalogItem);

            if (card.subProducts !== undefined){
                card.subProducts.forEach((subProduct) => {
                    let catalogItemProducts = document.createElement('li');
                    catalogItemProducts.innerText = subProduct.title;
                    catalogItem.appendChild(catalogItemProducts);
                })

            }

        })
    }
}