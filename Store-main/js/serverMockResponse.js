let catalogMenu = [
    {
        title: 'Fruits',
        url: 'fruits',
        products: [
            {
                id: 111,
                title: 'Oranges',
                url: 'card_1',
                price: '26.00',
                description: ' FRESH ',
                brand: 'Fit Product',
                availability: true,
                sale: '10%'
            },
            {
                id: 222,
                title: 'Apples',
                url: 'card_2',
                price: '35.00',
                description: ' FRESH ',
                brand: 'Fit Product',
                availability: false,
                sale: '10%'
            },
            {
                id: 333,
                title: 'Bananas',
                url: 'card_3',
                price: '19.50',
                description: ' FRESH ',
                brand: 'Organic',
                availability: true,
                sale: '15%'
            },
            {
                id: 444,
                title: 'Green Grape',
                url: 'card_4',
                price: '25.50',
                description: ' FRESH ',
                brand: 'Organic',
                availability: false,
                sale: '15%'
            },
            {
                id: 555,
                title: 'Red Grape',
                url: 'card_5',
                price: '29.50',
                description: ' FRESH ',
                brand: 'New Line',
                availability: true,
                sale: '10%'
            },
            {
                id: 666,
                title: 'Kivi',
                url: 'card_6',
                price: '20.50',
                description: ' FRESH ',
                brand: 'Fit Product',
                availability: true,
                sale: '20%'
            },
            {
                id: 777,
                title: 'Cherry',
                url: 'cherry',
                price: '56.00',
                description: ' FRESH ',
                brand: 'Organic',
                availability: true,
                sale: '5%'
            },
            {
                id: 888,
                title: 'Lime',
                url: 'lime',
                price: '48.60',
                description: ' FRESH ',
                brand: 'Organic',
                availability: true,
                sale: '5%'
            },
            {
                id: 999,
                title: 'Lemon',
                url: 'lemon',
                price: '32.50',
                description: ' FRESH ',
                brand: 'New Line',
                availability: true,
                sale: '8%'
            },
        ],
        sale: true
    },
    {
        title: 'Vegetables',
        url: 'vegetables',
        products: [
            {
                id: 1111,
                title: 'Potatoes',
                url: 'potatoes',
                price: '11.00',
                description: ' FRESH ',
                brand: 'Organic',
                availability: true,
                sale: '10%'
            },
            {
                id: 2222,
                title: 'Carrot',
                url: 'carrot',
                price: '15.00',
                description: ' FRESH ',
                brand: 'Organic',
                availability: true,
                sale: '10%'
            },
            {
                id: 3333,
                title: 'Onion',
                url: 'onion',
                price: '12.00',
                description: ' FRESH ',
                brand: 'Fit Product',
                availability: true,
                sale: '10%'
            },
            {
                id: 4444,
                title: 'Zucchini',
                url: 'zucchini',
                price: '18.00',
                description: ' FRESH ',
                brand: 'Fit Product',
                availability: true,
                sale: '10%'
            },
            {
                id: 5555,
                title: 'Eggplant',
                url: 'eggplant',
                price: '28.00',
                description: ' FRESH ',
                brand: 'Fit Product',
                availability: false,
                sale: '10%'
            },
            {
                id: 6666,
                title: 'Cabbage',
                url: 'cabbage',
                price: '6.00',
                description: ' FRESH ',
                brand: 'Organic',
                availability: true,
                sale: '10%'
            },
            {
                id: 7777,
                title: 'Brokkoli',
                url: 'brokkoli',
                price: '18.00',
                description: ' FRESH ',
                brand: 'Organic',
                availability: true,
                sale: '10%'
            },
            {
                id: 8888,
                title: 'Mashrooms',
                url: 'mashrooms',
                price: '30.00',
                description: ' FRESH ',
                brand: 'New Line',
                availability: true,
                sale: '10%'
            }

        ],
        sale: true
    },
    {
        title: 'MeatFish',
        url: 'meat&fish',
        products: [
            {
                id: 11111,
                title: 'Salmon',
                url: 'salmon',
                price: '350.00',
                description: ' FRESH ',
                brand: 'New Line',
                availability: true,
                sale: '10%'
            },
            {
                id: 22222,
                title: 'Trout',
                url: 'trout',
                price: '250.00',
                description: ' FRESH ',
                brand: 'New Line',
                availability: false,
                sale: '10%'
            },
            {
                id: 33333,
                title: 'Mackerel',
                url: 'mackerel',
                price: '90.00',
                description: ' FRESH ',
                brand: 'New Line',
                availability: true,
                sale: '10%'
            },
            {
                id: 44444,
                title: 'Beef',
                url: 'beef',
                price: '199.00',
                description: ' FRESH ',
                brand: 'Organic',
                availability: true,
                sale: '10%'
            },
            {
                id: 55555,
                title: 'Chicken',
                url: 'chicken',
                price: '85.00',
                description: ' FRESH ',
                brand: 'Organic',
                availability: true,
                sale: '10%'
            },
            {
                id: 66666,
                title: 'Pork',
                url: 'pork',
                price: '170.00',
                description: ' FRESH ',
                brand: 'Organic',
                availability: true,
                sale: '10%'
            },
            {
                id: 77777,
                title: 'Rabbit',
                url: 'rabbit',
                price: '400.00',
                description: ' FRESH ',
                brand: 'Fit Product',
                availability: false,
                sale: '10%'
            },
            {
                id: 88888,
                title: 'Turkey',
                url: 'turkey',
                price: '200.00',
                description: ' FRESH ',
                brand: 'Fit Product',
                availability: true,
                sale: '10%'
            },
        ],
        sale: true
    },
    {
        title: 'Sweets',
        url: 'sweets',
        sale: true,
        subProducts: [
            {
                title: 'chocolate',
                url: 'chokolate',
                sale: true,
                products: [
                    {
                        id: 11,
                        title: 'Caramel5',
                        url: 'caramel5',
                        price: '15.00',
                        description: ' FRESH ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 22,
                        title: 'Caramel6',
                        url: 'caramel6',
                        price: '15.00',
                        description: ' FRESH ',
                        brand: 'New Line',
                        availability: false,
                        sale: '10%'
                    },
                    {
                        id: 33,
                        title: 'Caramel7',
                        url: 'caramel7',
                        price: '15.00',
                        description: ' FRESH ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 44,
                        title: 'Caramel8',
                        url: 'caramel8',
                        price: '15.00',
                        description: ' FRESH ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 55,
                        title: 'Caramel9',
                        url: 'caramel9',
                        price: '15.00',
                        description: ' FRESH ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 66,
                        title: 'Caramel10',
                        url: 'caramel10',
                        price: '15.00',
                        description: ' FRESH ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 77,
                        title: 'Caramel11',
                        url: 'caramel11',
                        price: '15.00',
                        description: ' FRESH ',
                        brand: 'Fit Product',
                        availability: false,
                        sale: '10%'
                    },
                    {
                        id: 88,
                        title: 'Caramel12',
                        url: 'caramel12',
                        price: '15.00',
                        description: ' FRESH ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1211,
                        title: 'Dark',
                        url: 'chokolate1',
                        price: '328.00',
                        description: ' NICE FLAVOUR ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1222,
                        title: 'Milk',
                        url: 'chokolate2',
                        price: '320.00',
                        description: ' NICE FLAVOUR ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1233,
                        title: 'Mix',
                        url: 'chokolate4',
                        price: '350.00',
                        description: ' NICE FLAVOUR ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1244,
                        title: 'Dried fruits',
                        url: 'chokolate5',
                        price: '500.00',
                        description: ' NICE FLAVOUR ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1255,
                        title: 'White',
                        url: 'chokolate6',
                        price: '150.00',
                        description: ' NICE FLAVOUR ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1266,
                        title: 'Nuts',
                        url: 'chokolate7',
                        price: '250.00',
                        description: ' NICE FLAVOUR ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                ]
            },
            {
                title: 'ChocolateCandies',
                url: 'sweets_chokolate-candies',
                sale: true,
                products: [
                    {
                        id: 1311,
                        title: 'Candies1',
                        url: 'choko-candies1',
                        price: '100.00',
                        description: ' FLAVOUR ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1322,
                        title: 'Candies2',
                        url: 'choko-candies2',
                        price: '100.00',
                        description: ' FLAVOUR ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1333,
                        title: 'Candies3',
                        url: 'choko-candies3',
                        price: '100.00',
                        description: ' FLAVOUR ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1344,
                        title: 'Candies4',
                        url: 'choko-candies4',
                        price: '100.00',
                        description: ' FLAVOUR ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1355,
                        title: 'Candies5',
                        url: 'choko-candies5',
                        price: '100.00',
                        description: ' FLAVOUR ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1366,
                        title: 'Candies6',
                        url: 'choko-candies6',
                        price: '100.00',
                        description: ' FLAVOUR ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1377,
                        title: 'Candies7',
                        url: 'choko-candies7',
                        price: '100.00',
                        description: ' FLAVOUR ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1388,
                        title: 'Candies8',
                        url: 'choko-candies8',
                        price: '100.00',
                        description: ' FLAVOUR ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1399,
                        title: 'Candies9',
                        url: 'choko-candies9',
                        price: '100.00',
                        description: ' FLAVOUR ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1310,
                        title: 'Candies10',
                        url: 'choko-candies10',
                        price: '100.00',
                        description: ' FLAVOUR ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },

                ]
            },
        ]
    },
    {
        title: 'Bakery',
        url: 'bakery',
        sale: true,
        products: [
            {
                id: 11111111,
                title: 'Bread',
                url: 'bread',
                price: '20.00',
                description: ' FRESH  ',
                brand: 'Organic',
                availability: true,
                sale: '10%'
            },
            {
                id: 22222222,
                title: 'Baguette',
                url: 'baguette',
                price: '22.00',
                description: ' FRESH  ',
                brand: 'Organic',
                availability: true,
                sale: '10%'
            },
            {
                id: 33333333,
                title: 'Ciabatta',
                url: 'ciabatta',
                price: '25.00',
                description: ' FRESH  ',
                brand: 'Fit Product',
                availability: true,
                sale: '10%'
            },
            {
                id: 44444444,
                title: 'Croissant',
                url: 'croissant',
                price: '15.00',
                description: ' FRESH  ',
                brand: 'Fit Product',
                availability: true,
                sale: '10%'
            },
            {
                id: 555555555,
                title: 'Bun',
                url: 'buns',
                price: '8.00',
                description: ' FRESH  ',
                brand: 'New Line',
                availability: true,
                sale: '10%'
            },
            {
                id: 66666666,
                title: 'Puff',
                url: 'puff',
                price: '12.00',
                description: ' FRESH  ',
                brand: 'Fit Product',
                availability: false,
                sale: '10%'
            },
            {
                id: 77777777,
                title: 'Donut',
                url: 'donuts',
                price: '10.00',
                description: ' FRESH  ',
                brand: 'New Line',
                availability: true,
                sale: '10%'
            },
            {
                id: 88888888,
                title: 'Apple strudel',
                url: 'strudel',
                price: '100.00',
                description: ' FRESH  ',
                brand: 'Fit Product',
                availability: false,
                sale: '10%'
            },
            {
                id: 99999999,
                title: 'Cookies',
                url: 'cookies',
                price: '26.00',
                description: ' FRESH  ',
                brand: 'Organic',
                availability: true,
                sale: '10%'
            }
        ]
    },
    {
        title: 'Grocery',
        url: 'grocery',
        sale: true,
        subProducts:[
            {
                title: 'Groats',
                url: 'groatsmain',
                sale: false,
                products: [
                    {
                        id: 1711,
                        title: 'Groats1',
                        url: 'groats1',
                        price: '35.00',
                        description: ' MUST TRY ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1722,
                        title: 'Groats2',
                        url: 'groats2',
                        price: '55.00',
                        description: ' MUST TRY ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1733,
                        title: 'Groats3',
                        url: 'groats3',
                        price: '35.00',
                        description: ' MUST TRY ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1744,
                        title: 'Groats4',
                        url: 'groats4',
                        price: '45.00',
                        description: ' MUST TRY ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1755,
                        title: 'Groats5',
                        url: 'groats5',
                        price: '30.00',
                        description: ' MUST TRY ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1766,
                        title: 'Groats6',
                        url: 'groats6',
                        price: '60.00',
                        description: ' MUST TRY ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1777,
                        title: 'Groats7',
                        url: 'groats7',
                        price: '75.00',
                        description: ' MUST TRY ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },


                ]
            },
            {
                title: 'Pasta',
                url: 'pasta',
                sale: true,
                products: [
                    {
                        id: 1811,
                        title: 'Pasta1',
                        url: 'pasta1',
                        price: '120.00',
                        description: ' MFD 2023 ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1822,
                        title: 'Pasta2',
                        url: 'pasta2',
                        price: '100.00',
                        description: ' MFD 2023 ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1833,
                        title: 'Pasta3',
                        url: 'pasta3',
                        price: '85.00',
                        description: ' MFD 2023 ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1844,
                        title: 'Pasta4',
                        url: 'pasta4',
                        price: '95.00',
                        description: ' MFD 2023 ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1855,
                        title: 'Pasta5',
                        url: 'pasta5',
                        price: '75.00',
                        description: ' MFD 2023 ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1866,
                        title: 'Pasta6',
                        url: 'pasta6',
                        price: '80.00',
                        description: ' MFD 2023 ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1877,
                        title: 'Pasta7',
                        url: 'pasta7',
                        price: '90.00',
                        description: ' MFD 2023 ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1888,
                        title: 'Pasta8',
                        url: 'pasta8',
                        price: '80.00',
                        description: ' MFD 2023 ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1899,
                        title: 'Pasta9',
                        url: 'pasta9',
                        price: '100.00',
                        description: ' MFD 2023 ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 18101,
                        title: 'Pasta10',
                        url: 'pasta101',
                        price: '75.00',
                        description: ' MFD 2023 ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 18111,
                        title: 'Pasta11',
                        url: 'pasta11',
                        price: '90.00',
                        description: ' MFD 2023 ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 18112,
                        title: 'Pasta12',
                        url: 'pasta12',
                        price: '120.00',
                        description: ' MFD 2023 ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 18113,
                        title: 'Pasta13',
                        url: 'pasta13',
                        price: '110.00',
                        description: ' MFD 2023 ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },



                ]
            }

        ]
    },
    {
        title: 'Dairy',
        url: 'dairy',
        sale: true,
        subProducts: [
            {
                title: 'Cheeses',
                url: 'cheeses',
                sale: true,
                products: [
                    {
                        id: 1411,
                        title: 'Cheese1',
                        url: 'cheese1',
                        price: '290.00',
                        description: ' FRESH ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1422,
                        title: 'Cheese2',
                        url: 'cheese2',
                        price: '60.00',
                        description: ' FRESH ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1433,
                        title: 'Cheese3',
                        url: 'cheese3',
                        price: '290.00',
                        description: ' FRESH ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1444,
                        title: 'Mozzarella',
                        url: 'cheese4',
                        price: '200.00',
                        description: ' FRESH ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1455,
                        title: 'Brinza',
                        url: 'cheese5',
                        price: '250.00',
                        description: ' FRESH ',
                        brand: 'Organic',
                        availability: false,
                        sale: '10%'
                    },
                    {
                        id: 1466,
                        title: 'Feta',
                        url: 'cheese6',
                        price: '300.00',
                        description: ' FRESH ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1477,
                        title: 'Parmesan',
                        url: 'cheese7',
                        price: '690.00',
                        description: ' FRESH ',
                        brand: 'New Line',
                        availability: false,
                        sale: '10%'
                    },

                ]
            },
           
        ]
    },
    {
        title: 'Drinks',
        url: 'drinks',
        sale: true,
        subProducts:[
            {
                title: 'FreshJuice',
                url: 'juices',
                sale: false,
                products: [
                    {
                        id: 1911,
                        title: 'Fresh1',
                        url: 'fresh1',
                        price: '75.00',
                        description: ' MFD 2023 ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1922,
                        title: 'Fresh2',
                        url: 'fresh2',
                        price: '75.00',
                        description: ' MFD 2023 ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1933,
                        title: 'Fresh3',
                        url: 'fresh3',
                        price: '75.00',
                        description: ' MFD 2023 ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1944,
                        title: 'Fresh4',
                        url: 'fresh4',
                        price: '75.00',
                        description: ' MFD 2023 ',
                        brand: 'Fit Product',
                        availability: false,
                        sale: '10%'
                    },
                    {
                        id: 1955,
                        title: 'Fresh5',
                        url: 'fresh5',
                        price: '75.00',
                        description: ' MFD 2023 ',
                        brand: 'Organic',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1966,
                        title: 'Fresh6',
                        url: 'fresh6',
                        price: '75.00',
                        description: ' MFD 2023 ',
                        brand: 'New Line',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1977,
                        title: 'Fresh7',
                        url: 'fresh7',
                        price: '75.00',
                        description: ' MFD 2023 ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                    {
                        id: 1988,
                        title: 'Fresh8',
                        url: 'fresh8',
                        price: '75.00',
                        description: ' MFD 2023 ',
                        brand: 'Fit Product',
                        availability: true,
                        sale: '10%'
                    },
                ]
            },
           
        ]
    }
];