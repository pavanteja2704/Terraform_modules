class CartRender {
    constructor(cart,rootElement, cartListener){
        this.rootElement = rootElement;
        this.cart = cart;
        this.sum = 0;

        this.cartListener = cartListener
    }

    clean () {
        this.rootElement.innerHTML = '';
        this.sum = 0;
    }

    render() {
        this.clean();

        this.rootElement.classList.add('cart_wrap');

        //Created header Cart
        let cartHeader = document.createElement('div');
        cartHeader.classList.add('cart_header');
        this.rootElement.appendChild(cartHeader);

        let cartTitle = document.createElement('div');
        cartTitle.classList.add('cart_title');
        cartTitle.innerText = 'Cart';
        cartHeader.appendChild(cartTitle);

        let cartHeaderButtonDelete = document.createElement('button');
        cartHeaderButtonDelete.classList.add('cart_header-btn-delete');
        cartHeader.appendChild(cartHeaderButtonDelete);

        cartHeaderButtonDelete.addEventListener('click', () => {
            let lines = this.rootElement.querySelectorAll('.cart_list__item');
            for (let i = 0; i < lines.length; i++) {
                if (lines[i].querySelector('.cart_list__item-check').getAttribute('checked') === 'true'){
                    lines[i].querySelector('.delete-item').click();
                }
            }
        });

        let cartHeaderButtonDeleteImg = document.createElement('img');
        cartHeaderButtonDeleteImg.setAttribute('src', 'assets/images/icon_delete.png');
        cartHeaderButtonDelete.appendChild(cartHeaderButtonDeleteImg);

        //Created button Close Cart
        let closeCart = document.createElement('button');
        closeCart.classList.add('close_cart');
        this.rootElement.appendChild(closeCart);

        closeCart.addEventListener('click', ()=>{
            cartHtml.classList.remove('active');
            overlay.classList.remove('active');
        });

        let closeImg = document.createElement('img');
        closeImg.setAttribute('src', 'assets/images/icon_close.png');
        closeCart.appendChild(closeImg);

        //created block for empty Cart
        this.blockEmptyCart = document.createElement('div');
        this.blockEmptyCart.classList.add('empty-cart');
        this.blockEmptyCart.textContent = 'Your shopping cart is empty';
        this.rootElement.appendChild(this.blockEmptyCart);


        //Created footer Cart
        this.cartFooter = document.createElement('div');
        this.cartFooter.classList.add('cart_footer');
        this.rootElement.appendChild(this.cartFooter);

        let cartFooterColumn1 = document.createElement('div');
        cartFooterColumn1.classList.add('cart_footer-column');
        this.cartFooter.appendChild(cartFooterColumn1);

        let cartFooterShopLogo = document.createElement('img');
        cartFooterShopLogo.setAttribute('src', 'assets/images/foog-logo.png');
        cartFooterColumn1.appendChild(cartFooterShopLogo);

        let  cartFooterShopName = document.createElement('span');
        cartFooterShopName.classList.add('cart_footer-shop-name');
        cartFooterColumn1.appendChild(cartFooterShopName);
        cartFooterShopName.innerHTML = 'FOOD';

        let cartFooterColumn2 = document.createElement('div');
        cartFooterColumn2.classList.add('cart_footer-column');
        this.cartFooter.appendChild(cartFooterColumn2);

        let cartFooterSpanTotalSum = document.createElement('span');
        cartFooterSpanTotalSum.classList.add('cart_footer-span-total-sum');
        cartFooterSpanTotalSum.innerHTML = 'Total Sum';
        cartFooterColumn2.appendChild(cartFooterSpanTotalSum);

        let cartFooterContinueShopping = document.createElement('button');
        cartFooterContinueShopping.classList.add('button_continue');
        cartFooterContinueShopping.textContent = 'Continue Shopping';
        cartFooterColumn2.appendChild(cartFooterContinueShopping);

        cartFooterContinueShopping.addEventListener('click', ()=>{
            cartHtml.classList.remove('active');
            overlay.classList.remove('active');
        });

        let cartFooterColumn3 = document.createElement('div');
        cartFooterColumn3.classList.add('cart_footer-column');
        this.cartFooter.appendChild(cartFooterColumn3);

        this.totalSum = document.createElement('span');
        this.totalSum.classList.add('cart_sum');
        this.totalSum.innerHTML = '0';
        cartFooterColumn3.appendChild(this.totalSum);

        let cartFooterCheckout = document.createElement('button');
        cartFooterCheckout.classList.add('button_checkout');
        cartFooterCheckout.textContent = 'Checkout';
        cartFooterColumn3.appendChild(cartFooterCheckout);


        //Created List Cart
        let cartList = document.createElement('ul');
        cartList.classList.add('cart_list');
        this.rootElement.appendChild(cartList);

        let positions = this.cart.getPositions();


        for (let position of positions.values()) {
            this.renderCartListItem(cartList, position, position.product, position.count);
        }

        this.renderSum();
    }

    renderCartListItem(cartList, position, card, count) {
        this.blockEmptyCart.remove();

        //Created li
        let cartListItem = document.createElement('li');
        cartListItem.classList.add('cart_list__item');
        cartList.appendChild(cartListItem);
        // cartList.classList.add('test');
        this.cartFooter.classList.add('test');

        //created Column1
        let cartListColumn1 = document.createElement('div');
        cartListColumn1.classList.add('cart_list__item-column');
        cartListItem.appendChild(cartListColumn1);

        let cartListItemCheck = document.createElement('input');
        cartListItemCheck.setAttribute('type', 'checkbox');
        cartListItemCheck.classList.add('cart_list__item-check');
        cartListColumn1.appendChild(cartListItemCheck);

        cartListItemCheck.addEventListener('click', () =>{
            let isChecked = cartListItemCheck.getAttribute('checked');

            if (isChecked === null){
                cartListItemCheck.setAttribute('checked', true);
                console.log('This cartListItemCheck is checked');
            } else{
                cartListItemCheck.removeAttribute('checked');
                console.log('This cartListItemCheck is NOT checked');
            }
        });



        //Created Column2
        let cartListColumn2 = document.createElement('div');
        cartListColumn2.classList.add('cart_list__item-column');
        cartListItem.appendChild(cartListColumn2);

        let cartListItemId = document.createElement('span');
        cartListItemId.classList.add('cart_list__item-id');
        cartListColumn2.appendChild(cartListItemId);

        let cartListItemPreview = document.createElement('img');
        cartListItemPreview.setAttribute('src', 'assets/images/'+ card.url + '.jpg');
        cartListItemPreview.classList.add('cart_list__item-preview');
        cartListColumn2.appendChild(cartListItemPreview);

        //Created Column3
        let cartListColumn3 = document.createElement('div');
        cartListColumn3.classList.add('cart_list__item-column');
        cartListItem.appendChild(cartListColumn3);

        let cartListItemName = document.createElement('span');
        cartListItemName.classList.add('cart_list__item-name');
        cartListColumn3.appendChild(cartListItemName);

        let cartListItemValue = document.createElement('span');
        cartListItemValue.classList.add('cart_list__item-value');
        cartListColumn3.appendChild(cartListItemValue);

        //Created Column4
        let cartListColumn4 = document.createElement('div');
        cartListColumn4.classList.add('cart_list__item-column');
        cartListItem.appendChild(cartListColumn4);


        let cartListItemSpanControlNumber = document.createElement('span');
        cartListItemSpanControlNumber.classList.add('cart_list__item-span-control-number');
        cartListColumn4.appendChild(cartListItemSpanControlNumber);

        let cartListItemControlNumber = document.createElement('div');
        cartListItemControlNumber.classList.add('cart_list__item-control-number');
        cartListColumn4.appendChild(cartListItemControlNumber);

        let buttonDown = document.createElement('button');
        buttonDown.classList.add('count_down');
        cartListItemControlNumber.appendChild(buttonDown);
        buttonDown.textContent = '-';

        let numberUnits = document.createElement('input');
        numberUnits.classList.add('cart_list__item-number');
        cartListItemControlNumber.appendChild(numberUnits);
        numberUnits.value = count;
        

        buttonDown.addEventListener('click', () => {
            console.log('Button Down clicked');
            position.count--;
            if (position.count < 0){
                position.count = 0;
            }
            numberUnits.value = position.count;
            subTotal.innerHTML = card.price * position.count;
            this.renderSum();
        }) ;

        let buttonUp = document.createElement('button');
        buttonUp.classList.add('count_up');
        cartListItemControlNumber.appendChild(buttonUp);
        buttonUp.textContent = '+';

        buttonUp.addEventListener('click', () => {
            console.log('Button Up clicked');
            position.count++;
            numberUnits.value = position.count;
            subTotal.innerHTML = card.price * position.count;
            this.renderSum();
        }) ;


        //created Column5
        let cartListColumn5 = document.createElement('div');
        cartListColumn5.classList.add('cart_list__item-column');
        cartListItem.appendChild(cartListColumn5);

        let subTotalSpan = document.createElement('span');
        subTotalSpan.classList.add('cart_list__item-subTotal-span');
        cartListColumn5.appendChild(subTotalSpan);
        subTotalSpan.textContent = 'SubTotal';


        let subTotal = document.createElement('span');
        subTotal.classList.add('cart_list__item-subTotal');
        cartListColumn5.appendChild(subTotal);
        let positionSum = card.price * count;



        this.sum += positionSum;
        subTotal.innerHTML = positionSum;
        // return cartListItem;

        //Created Column6
        let cartListColumn6 = document.createElement('button');
        cartListColumn6.classList.add('cart_list__item-column');
        cartListColumn6.classList.add('no-hover');
        cartListColumn6.classList.add('delete-item');
        cartListItem.appendChild(cartListColumn6);

        cartListColumn6.addEventListener('click',()=>{
            this.deleteCartListItem(card.id);
            cartListItem.remove();
        });

        cartListColumn6.addEventListener('mouseover', ()=>{
            cartListColumn6.classList.add('hover');
        });
        cartListColumn6.addEventListener('mouseout', ()=>{
        cartListColumn6.classList.remove('hover');
        });


        cartListItemId.textContent = 'id '+ card.id;
        cartListItemName.textContent = card.title;
        cartListItemValue.textContent = "Price " + card.price;
        cartListItemSpanControlNumber.textContent = 'Numbers';


    }

    renderSum(){
        let cartCount = document.querySelector('.cart_count');
        let sum=0;
        let cart_count = 0;

        let positions = this.cart.getPositions();

        for (let position of positions.values()) {
            sum = sum + position.product.price * position.count;
            cart_count +=position.count;
        }
        if (cart_count > 0){
            cartCount.classList.add('visible');
            cartCount.innerHTML = cart_count;
        } else {
            cartCount.classList.remove('visible');
        }


         this.totalSum.innerHTML = sum;
    };

    deleteCartListItem(productId){
        this.cart.removeProduct(productId);
        this.renderSum();

        this.cartListener.onDeleteProduct(productId);
    }

}