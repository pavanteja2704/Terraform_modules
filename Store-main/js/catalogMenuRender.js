class CatalogMenuRender {
    constructor(catalogMenu, rootElement) {
        this.catalogMenu = catalogMenu;
        this.rootElement = rootElement;
    }

    render() {
        store_catalog.innerHTML = '';

        this.catalogMenu.forEach((category)=>{
            let categoryMenu = document.createElement('div');
            categoryMenu.classList.add('category-menu');
            categoryMenu.setAttribute('id', category.title.toLowerCase());
            this.rootElement.appendChild(categoryMenu);

            let cardMainPhoto = document.createElement('img');
            cardMainPhoto.setAttribute('src', 'assets/images/categories/' + category.url + '.jpg');
            categoryMenu.appendChild(cardMainPhoto);

            let cardTitle = document.createElement('a');
            cardTitle.classList.add('card_title');
            cardTitle.innerText = category.title;
            categoryMenu.appendChild(cardTitle);

            if (category.sale === true){
                let ribbon = document.createElement('span');
                ribbon.classList.add('ribbon');
                categoryMenu.appendChild(ribbon);
                ribbon.innerText = 'SALE';

            }

        });



        this.catalogMenu.forEach((category) => {

            let productController = new ProductController(category.products, cart);

            let buyButtonClickCallback = (product) => {
                productController.buy(product.id);
                cartRender.render();
            };

            let categoryHtml = document.querySelector('#' + category.title.toLowerCase());
            // console.log(categoryHtml);

            categoryHtml.addEventListener('click', ()=>{
                store_catalog.classList.add('hidden');
                store_category.classList.add('visible');
                store_category.setAttribute('data-category', category.title.toLowerCase());
                filter.classList.add('visible');

                



                if (category.subProducts === undefined ){
                    productsRender = new ProductsRender(category.products, store_category, buyButtonClickCallback, category.sale);
                    productsRender.render();
                } else {
                    filter.classList.remove('visible');
                    // btnFilter.classList.remove('visible');
                    store_catalog.innerHTML = '';
                    store_catalog.classList.remove('hidden');
                    store_category.classList.remove('visible');
                    catalogMenuRender = new CatalogMenuRender(category.subProducts, store_catalog);
                    catalogMenuRender.render();

                    category.subProducts.forEach((subCategory) => {
                        let productController = new ProductController(subCategory.products, cart);

                        let buyButtonClickCallback = (product) => {
                            productController.buy(product.id);
                            cartRender.render();
                        };

                        let categoryHtml = document.querySelector('#' + subCategory.title.toLowerCase());
                        // console.log(categoryHtml);

                        categoryHtml.addEventListener('click', ()=> {
                            // console.log('11');
                            store_catalog.classList.add('hidden');
                            store_category.classList.add('visible');

                            productsRender = new ProductsRender(subCategory.products, store_category, buyButtonClickCallback, category.sale);
                            productsRender.render();
                        });
                    })
                }
                cartRender.render();
                breadCrumbRender(category.title);
            });
        });
    }

}






