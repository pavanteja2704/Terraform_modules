let productFilter = {
    brand: ['FIT PRODUCT', 'ORGANIC', 'NEW LINE'],
    price: [0, 1000],
    isAllowed: function(card) {
        if (this.brand.includes(card.brand.toUpperCase())
            && (this.price[0] <= card.price && card.price <= this.price[1])
        )
        {
            console.log('is allowed!');
            return true;
        }
    },
    filter: function (products) {
        let result = [];
        products.forEach((product) =>{
            if (this.isAllowed(product)){
               result.push(product);
            }
        });
        return result;
    }
};

