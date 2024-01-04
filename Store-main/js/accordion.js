let accordion = (function (element) {
    let _getItem = function (elements, className) { 
        let element = undefined;
        elements.forEach(function (item) {
            if (item.classList.contains(className)) {
                element = item;
            }
        });
        return element;
    };
    return function () {
        let _mainElement = {}, 
            _items = {}, 
            _contents = {}; 
        let _actionClick = function (e) {
                if (!e.target.classList.contains('accordion-item-header')) { 
                    return;
                }
                e.preventDefault(); 
                
                let header = e.target,
                    item = header.parentElement,
                    itemActive = _getItem(_items, 'show');
                
            let arrow = header.querySelector('.arrow');

            let itemId = (e.target.querySelector('span:nth-child(1)').innerText).toLowerCase();
            let brandInputs = item.querySelectorAll('.accordion-item-content .filter-item input');
            

            let brand = [];
            brandInputs.forEach((brandInput) => {
                brand.push(brandInput.name.toUpperCase());
            });

            for (let i = 0; i <= brandInputs.length-1; i++){
                

                brandInputs[i].addEventListener('click', ()=>{
                    if (brandInputs[i].checked === true){
                        brand.push(brandInputs[i].name.toUpperCase());
                    } else{
                        
                        const index = brand.indexOf(brandInputs[i].name.toUpperCase());
                        if (index >= 0) {
                            brand.splice(index, 1);
                        }
                    }
                    console.log(brand);
                    productFilter.brand = brand;
                    productsRender.render();
                })
            }


                if (itemActive === undefined) { 
                    item.classList.add('show');
                    arrow.classList.add('rotate');
                    item.setAttribute('id', itemId);
                } else {
                     item.classList.remove('show');
                     itemActive.addEventListener('click', () =>{
                    if (itemActive !== item) {
                        item.classList.add('show');
                        arrow.classList.add('rotate');
                        item.setAttribute('id', itemId);
                    }
                    else {
                        itemActive.classList.remove('show');
                        arrow.classList.remove('rotate');
                    }
                     })

                }
            },
            _setupListeners = function () {
                                _mainElement.addEventListener('click', _actionClick);
            };

        return {
            init: function (element) {
                _mainElement = (typeof element === 'string' ? document.querySelector(element) : element);
                _items = _mainElement.querySelectorAll('.accordion-item');
                _setupListeners();
            }
        }
    }
})();

let accordion1 = accordion();
accordion1.init('#accordion');