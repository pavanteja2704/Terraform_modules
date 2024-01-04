class ProductController {
    constructor(products, cart){
        this.products = products;
        this.cart = cart;
    }

    buy(productId){
        let product = this.getProduct(productId);

        this.cart.addProduct(product);

    }

    getProduct(productId) {
        let foundProduct = null;
        this.products.forEach((product)=> {
           if (productId === product.id) {
               foundProduct = product;
           }
        });
        return foundProduct;
    }

}