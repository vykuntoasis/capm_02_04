using { anubhav.db  } from '../db/datamodel';
using { cappo.cds } from '../db/CDSViews';

service CatalogService @(path:'CatalogService'){

        @Capabilities : { Insertable,Deletable : false}
        entity BusinessPartnerSet as projection on db.master.businesspartner;
        entity AddressSet as projection on db.master.address;
        @readonly
        entity EmployeeSet as projection on db.master.employees;
        entity PurchaseorderItems as projection on db.transaction.poitems;
        entity POs as projection on db.transaction.purchaseorder{
            *,
            // round(GROSS_AMOUNT) as GROSS_AMOUNT 
            // :Decimal(10,2),
            Items :redirected to PurchaseorderItems
        } actions{
        action boost();
        function largestOrder() returns array of POs;
        }
        entity CProductValuesView as projection on cds.CDSViews.CProductValuesView;   
        
         

}


