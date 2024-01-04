class ProductsRender {
    constructor(products, rootElement, buyButtonClickCallback, sale) {
        this.products = products;
        this.rootElement = rootElement;
        this.buyButtonClickCallback = buyButtonClickCallback;
        this.sale = sale;
    }

    render() {
        this.rootElement.innerHTML = '';
        let i = 1;
        let filteredProducts = productFilter.filter(this.products);
        filteredProducts.forEach((card)=>{
            let cardWrap = document.createElement('div');
            cardWrap.classList.add('card_wrap');
            cardWrap.classList.add('num');
            cardWrap.setAttribute('data-num', i++);
            this.rootElement.appendChild(cardWrap);
            cardWrap.setAttribute('id', 'card_' + card.id);

            let cardTitle = document.createElement('div');
            cardTitle.classList.add('card_title');
            cardTitle.innerText = card.title;
            cardWrap.appendChild(cardTitle);

            let cardMainPhoto = document.createElement('img');
            cardMainPhoto.setAttribute('src', 'assets/images/' + card.url + '.jpg');
            cardWrap.appendChild(cardMainPhoto);

            let cardDescription = document.createElement('div');
            cardDescription.classList.add('card_description');
            cardDescription.innerText = card.description;
            cardWrap.appendChild(cardDescription);

            let cardBrand = document.createElement('div');
            cardBrand.classList.add('card_brand');
            cardBrand.innerText = card.brand;
            cardWrap.appendChild(cardBrand);

            let cardAvailability = document.createElement('div');
            cardAvailability.classList.add('card_availability');
            cardWrap.appendChild(cardAvailability);

            let cardPrice = document.createElement('div');
            cardPrice.classList.add('card_price');

            let cardPriceValue = document.createElement('span');
            cardPriceValue.classList.add('card_price__value');
            cardPriceValue.innerText = card.price;
            cardWrap.appendChild(cardPrice);
            cardPrice.appendChild(cardPriceValue);

            let cardUserPanel = document.createElement('div');
            cardUserPanel.classList.add('card_price__control-panel');
            cardPrice.appendChild(cardUserPanel);

            let cardBuy = document.createElement('button');
            cardBuy.classList.add('add-to-cart');
            cardUserPanel.appendChild(cardBuy);
            cardBuy.setAttribute('value', 'Add to Cart');
            cardBuy.setAttribute('data-value', card.price);
            cardBuy.setAttribute('data-name', card.title);
            cardBuy.setAttribute('data-url', 'assets/images/' + card.url + '.jpg');

            if(cart.containsInCart(card.id)){
                cardBuy.setAttribute('disabled', 'disabled');
                cardBuy.classList.add('disabled');
            }

            if (card.availability === true){
                cardAvailability.innerText = 'Available';
                cardAvailability.classList.add('available');

            } else {
                cardAvailability.innerText = 'Not available';
                cardAvailability.classList.add('notAvailable');
                cardBuy.setAttribute('disabled', 'disabled');
                cardBuy.classList.add('not-available');
            }

            cardBuy.addEventListener('click', () => {
                btnCart.classList.remove('shake');
                this.buyButtonClickCallback(card);
                cardBuy.setAttribute('disabled', 'disabled');
                btnCart.classList.add('shake');
                console.log('Cart Shake!');
                cardBuy.classList.add('disabled');
            });

            cardDescription.addEventListener('mouseover', () => {
                cardDescription.classList.add('full');
            });
            cardDescription.addEventListener('mouseout', () => {
                cardDescription.classList.remove('full');
            });

            //Render ribbon with sale
            if (this.sale === true && card.availability === true){
                // console.log('sale = true');
                let ribbonProduct = document.createElement('div');
                    ribbonProduct.classList.add('ribbon1');
                    cardWrap.appendChild(ribbonProduct);
                    let ribbonProductSpan = document.createElement('span');
                    ribbonProductSpan.innerText = card.sale;
                    ribbonProduct.appendChild(ribbonProductSpan);
            } else{
                // console.log('sale = false');
            }

        });

        paginator(filteredProducts.length);
    }


}
