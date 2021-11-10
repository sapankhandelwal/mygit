global class LibItemGridCard {
    
    @AuraEnabled
        public String id{get;set;}
        
        @AuraEnabled
        public Library_Item__c libItem{get;set;}
        
    
        @AuraEnabled
        public String libPhotoUrl{get;set;}
    }