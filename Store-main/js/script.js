
let cart = new Cart();
let productsRender;
let store_category = document.querySelector('#store');
let store_catalog = document.querySelector('#store_catalog');
let filter = document.querySelector('#filter');
let btnFilter = document.querySelector('#btnFilter');

let cartHtml = document.querySelector('#cart');
let cartRender = new CartRender(cart, cartHtml, {
    onDeleteProduct: (productId) => {
        console.log("DELETE PRODUCT ID " + productId);

        let productCard = store_category.querySelector('#card_' + productId);
        if (productCard !== null) {
            let buyButton = productCard.querySelector('.add-to-cart');
            buyButton.removeAttribute('disabled');
            buyButton.classList.remove('disabled');
        }

    }
});

cartRender.render();

let breadCrumbs = document.querySelector('.breadcrumbs');

let catalogMenuRender = new CatalogMenuRender(catalogMenu, store_catalog);
catalogMenuRender.render();

let overlay  = document.querySelector('.overlay');
let btnCart = document.querySelector('#btn_cart');
let catalog = document.querySelector('.catalog-menu');
let contacts = document.querySelector('.container-contacts');
let btnCatalog = document.querySelector('#btn_catalog');
let btnContacts = document.querySelector('#btn_contacts');
let btnBurger = document.querySelector('.navigation-burger');


btnCart.addEventListener('click', ()=>{
    cartHtml.classList.add('active');
    overlay.classList.add('active');
});

btnCatalog.addEventListener('click', () => {
    catalog.classList.add('active');
    overlay.classList.add('active');

    let catalogRender = new CatalogRender(catalogMenu, catalog);
    catalogRender.render();
});
btnContacts.addEventListener('click', () => {
    contacts.classList.add('active');
    overlay.classList.add('active');
});

overlay.addEventListener('click', ()=>{
    cartHtml.classList.remove('active');
    overlay.classList.remove('active');
    catalog.classList.remove('active');
    contacts.classList.remove('active');
});

btnBurger.addEventListener('click', ()=>{
    catalog.classList.add('active');
    overlay.classList.add('active');

    let catalogRender = new CatalogRender(catalogMenu, catalog);
    catalogRender.render();
});


























