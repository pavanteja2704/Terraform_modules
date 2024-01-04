function breadCrumbRender(title) {
    let breadCrumbHome = document.querySelector('.breadcrumb-home');
    breadCrumbHome.classList.add('visible');
    breadCrumbHome.setAttribute('id', 'home');


    let breadCrumb = document.createElement('li');
    breadCrumb.innerText = title;
    breadCrumb.setAttribute('id', title);
    breadCrumbs.appendChild(breadCrumb);

    let breadCrumbBeforeLast = breadCrumbs.querySelector('li:nth-last-child(2)');
    
    let breadCrumbLast = breadCrumbs.querySelector('li:nth-last-child(1)');

    breadCrumbBeforeLast.addEventListener('click', () => {
        store_catalog.classList.remove('hidden');
        filter.classList.remove('visible');
        
        store_category.classList.remove('visible');
        breadCrumbLast.remove();

    });

    breadCrumbHome.addEventListener('click', ()=> {
        breadCrumbHome.classList.remove('visible');
        store_catalog.classList.remove('hidden');
        store_category.classList.remove('visible');
        filter.classList.remove('visible');
        

        catalogMenuRender = new CatalogMenuRender(catalogMenu, store_catalog);
        catalogMenuRender.render();

        breadCrumb.remove();

    });

}