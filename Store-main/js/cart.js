class Cart {
    constructor() {
        this.positions = new Map();
    }

    addProduct(product) {
        if(this.positions.has(product.id)) {
            this.positions.get(product.id).count++;
        } else {
            this.positions.set(product.id, {
                "product": product,
                "count": 1
            });
        }

      
    }

    getPositions() {
        return this.positions;
    }

    removeProduct(productId){
        this.positions.delete(productId);
    }

    containsInCart(productId){
        return this.positions.has(productId);
    }


}