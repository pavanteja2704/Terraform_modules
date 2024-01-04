let minPriceHtml = document.querySelector('#minPrice');
let maxPriceHtml = document.querySelector('#priceProductOutput');
let minPrice = Number(minPriceHtml.innerText);
let maxPrice = Number(maxPriceHtml.innerText);
let btnRange = document.querySelector('#rangeOk');
console.log(productFilter.price);

btnRange.addEventListener('click', () =>{
    maxPrice = Number(maxPriceHtml.innerText);
    productFilter.price[0] = minPrice;
    productFilter.price[1] = maxPrice;
    console.log(productFilter.price);
    productsRender.render();
});



